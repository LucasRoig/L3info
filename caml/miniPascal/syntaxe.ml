#open "lexuniv";;
(*load_object "lexuniv.zo";;

  type constante =
  | Entiere of int
  | Booleenne of bool;;

type expr_type =
  | Integer
  |Boolean
  |Array of int*int*expr_type (* les deux int sont les bornes *);;

type expression =
  |Constante of constante
  |Variable of string
  |Application of string * expression list
  |Op_unaire of string*expression
  |Op_binaire of string * expression * expression
  |Acces_tableau of expression*expression;;

type instruction =
  |Affectation_var of string*expression
  |Affectation_tableau of expression*expression*expression
  |Appel of string * expression list
  |If of expression * instruction * instruction
  |While of expression * instruction
  |Write of expression
  |Read of string
  |Bloc of instruction list;;

type decl_proc =
  { proc_parametres : (string * expr_type) list;
    proc_variables : (string * expr_type) list;
    proc_corps : instruction}
and decl_fonc =
  {fonc_parametres: (string * expr_type) list;
   fonc_type_resultat: expr_type;
   fonc_variables: (string * expr_type) list;
   fonc_corps: instruction};;

type programme =
  {prog_variables: (string * expr_type) list;
   prog_procedures: (string * decl_proc) list;
   prog_fonctions: (string * decl_fonc) list;
   prog_corps: instruction};;*)

(* -----------------------------FONCTIONS-------------------------------------------------- *)
  
let analyseur_lexical = construire_analyseur
["false";"true";"("; ","; ")"; "["; "]"; "not"; "*"; "/"; "-"; "+";
"="; "<>"; "<"; ">"; "<="; ">="; "and"; "or"; "if"; "then"; "else";
"while"; "do"; "write"; "read"; "begin"; ";"; "end"; ":=";
"integer"; "boolean"; "array"; "of"; ".."; "var"; ":";"procedure"; "function"; "program"];;
    
let lire_liste lire_element separateur =
  let rec lire_reste = function
    | [< (stream_check
	    (function lexeme -> lexeme = MC separateur)) sep;
       lire_element elt;
       lire_reste reste >] -> elt :: reste
    | [< >] -> [] in
  function [< lire_element elt; lire_reste reste >] -> elt :: reste
	 | [< >] -> [];;

let est_un_operateur operateurs = function
  | MC op -> mem op operateurs
  | _     -> false;;

let lire_operateur operateurs = function
  | [< (stream_check (est_un_operateur operateurs)) (MC op) >] -> op;;

let lire_operation lire_base operateurs =
  let rec lire_reste e1 = function
    | [< (lire_operateur operateurs) op;
       lire_base e2;
       (lire_reste (Op_binaire(op, e1, e2))) e >] -> e
    | [< >] -> e1 in
  function [< lire_base e1; (lire_reste e1) e >] -> e;;

let rec lire_expr0 flux =
  match flux with
  | [< 'Entier n >] -> Constante(Entiere n)
  | [< 'MC "false" >] -> Constante(Booleenne false)
  | [< 'MC "true" >] -> Constante(Booleenne true)
  | [< 'Ident nom >] ->
     begin match flux with
	   | [< 'MC "("; (lire_liste lire_expr ",") el; 'MC ")">] ->
	      Application(nom, el)
	   | [< >] -> Variable nom
     end
  | [<'MC "("; lire_expr e; 'MC ")" >] -> e
and lire_expr1 flux =
  match flux with
    [< lire_expr0 e1 >] ->
    match flux with
    | [< 'MC "["; lire_expr e2; 'MC "]" >] -> Acces_tableau(e1,e2)
    | [< >] -> e1
and lire_expr2 = function
  | [< 'MC "-"; lire_expr1 e >] -> Op_unaire("-", e)
  | [< 'MC "not"; lire_expr1 e >] -> Op_unaire("not", e)
  | [< lire_expr1 e >] -> e
and lire_expr3 flux =
  lire_operation lire_expr2 ["*"; "/"] flux
and lire_expr4 flux =
  lire_operation lire_expr3 ["+"; "-"] flux
and lire_expr5 flux =
  lire_operation lire_expr4 ["="; "<>"; "<"; ">"; "<="; ">="] flux
and lire_expr6 flux =
  lire_operation lire_expr5 ["and"] flux
and lire_expr flux =
  lire_operation lire_expr6 ["or"] flux;;

let rec lire_instr flux =
  match flux with
  | [< 'MC "if"; lire_expr e1; 'MC "then"; lire_instr i2 >] ->
     begin match flux with
	   | [< 'MC "else"; lire_instr i3 >] -> If(e1, i2, i3)
	   | [< >] -> If(e1, i2, Bloc [])
     end
  | [< 'MC "while"; lire_expr e1; 'MC "do"; lire_instr i2 >] ->
     While(e1, i2)
  | [< 'MC "write"; 'MC "("; lire_expr e; 'MC ")" >] ->
     Write e
  | [< 'MC "read"; 'MC "("; 'Ident nom; 'MC ")" >] ->
     Read nom
  | [< 'MC "begin"; (lire_liste lire_instr ";") il; 'MC "end" >] ->
     Bloc il
  | [< lire_expr e >] ->
     match e with
     | Application(nom, el) ->
	Appel(nom, el)
     | Variable nom ->
	begin match flux with
	      | [< 'MC ":="; lire_expr e >] ->
		 Affectation_var(nom, e)
	end
     | Acces_tableau(e1, e2) ->
	begin match flux with
	      | [< 'MC ":="; lire_expr e3 >] ->
		 Affectation_tableau(e1, e2, e3)
	end
     | _ -> raise Parse_error;;

let rec lire_type = function
  | [< 'MC "integer" >] -> Integer
  | [< 'MC "boolean" >] -> Boolean
  | [< 'MC "array"; 'MC "["; 'Entier bas; 'MC ".."; 'Entier haut;'MC "]";'MC "of"; lire_type ty >] ->
     Array(bas, haut, ty);;

let rec lire_variables = function
  | [< 'MC "var"; 'Ident nom; 'MC ":"; lire_type ty; 'MC ";";lire_variables reste >] ->
     (nom,ty)::reste
  | [< >] -> [];;

let lire_un_parametre = function
  | [< 'Ident nom; 'MC ":"; lire_type ty >] -> (nom,ty);;

let lire_parametres = function
  | [< 'MC "(";
     (lire_liste lire_un_parametre ",") parametres;'MC ")" >] -> parametres;;

let lire_procedure = function
  | [< 'MC "procedure"; 'Ident nom; lire_parametres p; 'MC ";" ;
     lire_variables v; lire_instr i; 'MC ";" >] ->
     (nom, {proc_parametres=p; proc_variables=v; proc_corps=i});;

let lire_fonction = function
  | [< 'MC "function"; 'Ident nom; lire_parametres p; 'MC ":";
     lire_type ty; 'MC ";"; lire_variables v;
     lire_instr i; 'MC ";" >] ->
     (nom, {fonc_parametres=p; fonc_type_resultat=ty;
	    fonc_variables=v; fonc_corps=i});;

let rec lire_proc_fonc = function
  | [< lire_procedure proc; lire_proc_fonc (procs, foncs) >] ->
     (proc::procs, foncs)
  | [< lire_fonction fonc;  lire_proc_fonc (procs, foncs) >] ->
     (procs, fonc::foncs)
  | [< >] -> ([], []);;

let lire_prog = function
  | [< 'MC "program"; 'Ident nom_du_programme; 'MC ";";
     lire_variables v; lire_proc_fonc (p,f); lire_instr i >] ->
     { prog_variables=v; prog_procedures=p;
       prog_fonctions=f; prog_corps=i };;

  let lire_programme flux = lire_prog(analyseur_lexical flux);;
