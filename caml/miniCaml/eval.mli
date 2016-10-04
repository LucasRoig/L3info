#open "syntaxe";;

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

value evalue: environnement -> expression -> valeur
  and evalue_definition: environnement -> definition ->
		       environnement
  and imprime_valeur: valeur -> unit;;


exception Erreur of string;;
