#open "lexuniv";;

  (*-------------------------------------------
  load_object("lexuniv.zo");;
  type expression =
    | Variable of string
    | Fonction of (motif * expression) list
    | Application of expression * expression
    | Let of definition * expression
    | Booleen of bool
    | Nombre of int
    | Paire of expression * expression
    | Nil
    | Cons of expression * expression

   and motif =
     | Motif_variable of string
     | Motif_booleen of bool
     | Motif_nombre of int
     | Motif_paire of motif * motif
     | Motif_nil
     | Motif_cons of motif * motif
   and directive =
     {nom_dir: string}
   and definition =
     { recursive: bool;
       nom: string;
       expr: expression };;
    
  type phrase =
    | Directive of directive
    | Expression of expression
    | Definition of definition;;
  

  ----------------------------------------*)

    
let est_un_operateur operateurs = function
  | MC op -> mem op operateurs
  | _     -> false;;

let lire_operateur operateurs = function
  | [< (stream_check (est_un_operateur operateurs)) (MC op) >] -> op;;

let lire_operation lire_base operateurs =
  let rec lire_reste e1 = function
    | [< (lire_operateur operateurs) op;
       lire_base e2;
       (lire_reste (Application(Variable op, Paire(e1, e2)))) e>] -> e
    | [< >] -> e1 in
  function [< lire_base e1; (lire_reste e1) e >] -> e;;

let lire_infixe lire_base infixe construire_syntaxe flux =
  let rec lire_debut = function
    | [< lire_base e1; (lire_reste e1) e2 >] -> e2
  and lire_reste e1 = function
    | [< (stream_check (function MC op -> op = infixe | _ -> false)) _;
       lire_debut e2 >] -> construire_syntaxe e1 e2
    | [< >] -> e1 in lire_debut flux;;

let rec phrase = function
  | [< directive d; 'MC ";;" >] -> Directive d 
  | [< definition d; (fin_de_definition d) p; 'MC ";;" >] -> p
  | [< expression e; 'MC ";;" >] -> Expression e
and directive = function
  | [< 'MC "#";'Ident n >] -> {nom_dir = n}
and fin_de_definition d = function
  | [< 'MC "in"; expression e >] -> Expression (Let(d, e))
  | [< >] -> Definition d
and expression = function
  | [< definition d; 'MC "in"; expression e >] -> Let(d, e)
  | [< 'MC "function"; liste_de_cas liste >] ->
     Fonction(liste)
  | [< 'MC "match"; expression e; 'MC "with";
     liste_de_cas liste >] ->
     Application(Fonction(liste), e)
  | [< expr5 e >] -> e
and expr_simple = function
  | [< 'Entier i >] -> Nombre i
  | [< 'MC "true" >] -> Booleen true
  | [< 'MC "false" >] -> Booleen false
  | [< 'Ident id >] -> Variable id
  | [< 'MC "["; 'MC "]" >] -> Nil
  | [< 'MC "("; expression e; 'MC ")" >] -> e
and expr0 = function
  | [< expr_simple es; (suite_d'applications es) e >] -> e
and suite_d'applications f = function
  | [< expr_simple arg;
     (suite_d'applications (Application(f, arg))) e >] -> e
  | [<>] -> f
and expr1 flux =
  lire_operation expr0 ["*"; "/"] flux
and expr2 flux =
  lire_operation expr1 ["+"; "-"] flux
and expr3 flux =
  lire_operation expr2 ["="; "<>"; "<"; ">"; "<="; ">="] flux
and expr4 flux =
  lire_infixe expr3 "::" (fun e1 e2 -> Cons(e1, e2)) flux
and expr5 flux =
  lire_infixe expr4 "," (fun e1 e2 -> Paire(e1, e2)) flux
and definition = function
  | [< 'MC "let"; recursive r; 'Ident nom; 'MC "="; expression e >] ->
     {recursive = r; nom = nom; expr = e}
and recursive = function
  | [< 'MC "rec" >] -> true
  | [< >] -> false
and liste_de_cas = function
  | [< motif m; 'MC "->"; expression e; autres_cas reste >] ->
     (m, e) :: reste
and autres_cas = function
  | [< 'MC "|"; motif m; 'MC "->"; expression e;
     autres_cas reste >] -> (m, e) :: reste
  | [< >] -> []
and motif_simple = function
  | [< 'Ident id >] -> Motif_variable id
  | [< 'Entier n >] -> Motif_nombre n
  | [< 'MC "true" >] -> Motif_booleen true
  | [< 'MC "false" >] -> Motif_booleen false
  | [< 'MC "["; 'MC "]" >] -> Motif_nil
  | [< 'MC "("; motif e; 'MC ")" >] -> e
and motif1 flux =
  lire_infixe motif_simple "::" (fun m1 m2 -> Motif_cons(m1,m2)) flux
and motif flux =
  lire_infixe motif1 "," (fun m1 m2 -> Motif_paire(m1,m2)) flux;;

let analyseur_lexical = construire_analyseur
			  ["function"; "let"; "rec"; "in"; "match"; "with"; "->"; ";;";
			   "true"; "false"; "["; "]"; "("; ")"; "::"; "|"; ",";
			   "*"; "/"; "-"; "+"; "="; "<>"; "<"; ">"; "<="; ">="; "::";"#"];;

let lire_phrase f = print_string("yo! ");phrase (analyseur_lexical f);;
