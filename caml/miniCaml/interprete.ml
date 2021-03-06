#open "syntaxe";;
#open "eval";;

  (*-------------------------
  load_object "syntaxe.zo";;
  load_object "eval.zo" ;;

  ------------------------*)

  
let code_nombre n = Val_nombre n
and decode_nombre = function
  | Val_nombre n -> n
  | _ -> raise (Erreur "entier attendu")
and code_booleen b = Val_booleenne b
and decode_booleen = function
  | Val_booleenne b -> b
  | _ -> raise (Erreur "booleen attendu");;

(* Pour transformer une fonction Caml en valeur fonctionnelle *)
let prim1 codeur calcul decodeur =
  Val_primitive(function val -> codeur(calcul(decodeur val)))
and prim2 codeur calcul decodeur1 decodeur2 =
  Val_primitive(function
		 | Val_paire(v1, v2) ->
		    codeur(calcul (decodeur1 v1) (decodeur2 v2))
		 | _ -> raise(Erreur "paire attendue"));;

  (* L environnement initial *)
let env_initial =
  ["+",  prim2 code_nombre  (prefix + ) decode_nombre decode_nombre;
   "-",  prim2 code_nombre  (prefix - ) decode_nombre decode_nombre;
   "*",  prim2 code_nombre  (prefix * ) decode_nombre decode_nombre;
   "/",  prim2 code_nombre  (prefix / ) decode_nombre decode_nombre;
   "=",  prim2 code_booleen (prefix = ) decode_nombre decode_nombre;
   "<>", prim2 code_booleen (prefix <>) decode_nombre decode_nombre;
   "<",  prim2 code_booleen (prefix < ) decode_nombre decode_nombre;
   ">",  prim2 code_booleen (prefix > ) decode_nombre decode_nombre;
   "<=", prim2 code_booleen (prefix <=) decode_nombre decode_nombre;
   ">=", prim2 code_booleen (prefix >=) decode_nombre decode_nombre;
   "not", prim1 code_booleen (prefix not) decode_booleen;
   "read_int", prim1 code_nombre
		     (fun x -> read_int ()) decode_nombre;
   "write_int", prim1 code_nombre
		      (fun x -> print_int x; print_newline (); 0)
		      decode_nombre];;

let handle_directive d env=
  match d.nom_dir with
  |"show_env" -> let rec string_of_valeur = function
		   |Val_nombre v -> string_of_int v
		   |Val_booleenne v -> string_of_bool v
		   |Val_paire (v1,v2) ->
		     "(" ^ string_of_valeur(v1) ^ "," ^ string_of_valeur(v2) ^ ")"
		   |Val_nil -> "[]"
		   |Val_cons(v1,v2) -> string_of_valeur(v1) ^ "::" ^ string_of_valeur(v2)
		   |Val_fermeture _ -> "<fun>"
		   |Val_primitive _ -> "<fun>" in 
		   do_list (function (s,v) -> print_string(s ^ " : " ^ string_of_valeur(v) ^ "\n")) env
  | s -> print_string("Directive inconnue : " ^ s ^ "\n");;
  

let boucle () =
  let env_global = ref env_initial in
  let flux_d'entree = stream_of_channel(std_in) in
  while true do
    print_string "# "; flush std_out;
    try
      print_string("x");
      match lire_phrase flux_d'entree with
      | Directive d -> handle_directive d !env_global
      | Expression expr ->
	 let res =  evalue !env_global expr in
	 print_string "- = "; imprime_valeur res;
	 print_newline ()
      | Definition def ->
	 let nouvel_env =  evalue_definition !env_global def in
	 begin match nouvel_env with
	       | (nom, val) :: _ ->
		  print_string nom; print_string " = ";
		  imprime_valeur val; print_newline ()
	 end;
	 env_global := nouvel_env
    with
    | Parse_error | Parse_failure ->
		     print_string "Erreur de syntaxe"; print_newline ()
    | Erreur msg ->
       print_string "Erreur a l'evaluation: "; print_string msg;
       print_newline ()
  done;;
  
  if sys__interactive then () else boucle ();;
