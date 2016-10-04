#open "syntaxe";;

  (*------------------------------------------
  load_object("syntaxe.zo");;
  type valeur =
    | Val_nombre of int
    | Val_booleenne of bool
    | Val_paire of valeur * valeur
    | Val_nil
    | Val_cons of valeur * valeur
    | Val_fermeture of fermeture
    | Val_primitive of valeur -> valeur
   and fermeture =
     { definition: (motif * expression) list;
       mutable environnement: environnement }
   and environnement == (string * valeur) list;;

  exception Erreur of string;;

    ------------------------------------------*)

exception Echec_filtrage;;

let rec filtrage valeur motif =
  match (valeur, motif) with
  | (val, Motif_variable id) -> [id, val]
  | (Val_booleenne b1, Motif_booleen b2) ->
     if b1 = b2 then [] else raise Echec_filtrage
  | (Val_nombre i1, Motif_nombre i2) ->
     if i1 = i2 then [] else raise Echec_filtrage
  | (Val_paire(v1, v2), Motif_paire(m1, m2)) ->
     filtrage v1 m1 @ filtrage v2 m2
  | (Val_nil, Motif_nil) -> []
  | (Val_cons(v1, v2), Motif_cons(m1, m2)) ->
     filtrage v1 m1 @ filtrage v2 m2
  | (_, _) -> raise Echec_filtrage;;

let rec evalue env expr =
  match expr with
  | Variable id ->
     begin try
	 assoc id env
       with Not_found -> raise(Erreur(id ^ " est inconnu"))
     end
  | Fonction(liste_de_cas) ->
     Val_fermeture {definition = liste_de_cas; environnement = env}
  | Application(fonction, argument) ->
     let val_fonction = evalue env fonction in
     let val_argument = evalue env argument in
     begin match val_fonction with
	   | Val_primitive fonction_primitive ->
	      fonction_primitive val_argument
	   | Val_fermeture fermeture ->
	      evalue_application fermeture.environnement
				 fermeture.definition val_argument
	   | _ ->
	      raise(Erreur "application d'une valeur non fonctionnelle")
     end
  | Let(definition, corps) ->
     evalue ( evalue_definition env definition) corps
  | Booleen b -> Val_booleenne b
  | Nombre n -> Val_nombre n
  | Paire(e1, e2) -> Val_paire( evalue env e1,  evalue env e2)
  | Nil -> Val_nil
  | Cons(e1, e2) -> Val_cons( evalue env e1,  evalue env e2)

and  evalue_application env liste_de_cas argument =
  match liste_de_cas with
  | [] -> raise(Erreur " echec du filtrage")
  | (motif, expr) :: autres_cas ->
     try
       let env_etendu = filtrage argument motif @ env in
       evalue env_etendu expr
     with Echec_filtrage ->
       evalue_application env autres_cas argument

and  evalue_definition env_courant def =
  match def.recursive with
  | false -> (def.nom,  evalue env_courant def.expr) :: env_courant
  | true ->
     match def.expr with
     | Fonction liste_de_cas ->
	let fermeture =
	  { definition = liste_de_cas; environnement = [] } in
	let env_etendu =
	  (def.nom, Val_fermeture fermeture) :: env_courant in
	fermeture.environnement <- env_etendu;
	env_etendu
     | _ -> raise(Erreur "let rec non fonctionnel");;

let rec imprime_valeur = function
  | Val_nombre n -> print_int n
  | Val_booleenne false -> print_string "false"
  | Val_booleenne true -> print_string "true"
  | Val_paire(v1, v2) ->
     print_string "("; imprime_valeur v1;
     print_string ", "; imprime_valeur v2;
     print_string ")"
  | Val_nil ->
     print_string "[]"
  | Val_cons(v1, v2) ->
     imprime_valeur v1;
     print_string "::"; imprime_valeur v2
  | Val_fermeture _ | Val_primitive _ ->
		       print_string "<fun>";;
