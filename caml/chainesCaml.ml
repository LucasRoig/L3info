(* Bibloth�que pour les cha�nes de caract�res 

1) Tout doit �tre ex�cutable, le reste est comment�
2) le fichier doit avoir l'extension .ml
3) On le charge avec la commande include du menu file de caml
*)



(********************
Longueur d'une cha�ne
*********************)
let longChaine= fun s->
    string_length s;;

(*  longChaine : 'a -> int = <fun>
#longChaine("bonjour");;
- : int = 7  *)

(***************************
s�lection du ni�me caract�re
****************************)
let niemeCar = fun (n,s)-> 
   nth_char s (n-1);;
(* niemeCar : int * string -> char = <fun>
#niemeCar (3,"bonjour");;
- : char = `n`  *)

(****************************************************
selection de la sous chaine entre les indices n et m
****************************************************)
let sousChaine = fun (s,n,m) -> 
if m<n then ""
else sub_string s (n-1) (m-n+1);;
(*  sousChaine : string * int * int -> string = <fun>  *)


(****************************************************** 
tetec donne l'initiale d'un mot sous forme de caract�re
*******************************************************)
let tetec= fun 
""-> failwith "La chaine est vide"
| s-> niemeCar(1,s);;

(*tetec : string -> char = <fun>
tetec "bonjour";;
- : char = `b`
#
tetec "b";;
- : char = `b`
#
tetec "";;
 Exception non rattrap�e: Failure "La chaine est vide" *)

(****************************************************** 
tetes donne l'initiale d'un mot sous forme de chaine
*******************************************************)
let tetes= fun s-> string_of_char(tetec(s));;

(* tetes : string -> string = <fun>
#tetes "bonjour";;
- : string = "b"
#tetes "b";;
- : string = "b"
#tetes "";;
Exception non rattrap�e: Failure "La chaine est vide" *)


(***************************************
 reste supprime l'initiale d'une chaine
 ***************************************)
let reste = fun 
""-> failwith"La chaine est vide"
| s-> sousChaine (s,2,longChaine(s));;

(*reste : string -> string = <fun>
#reste "bonjour";;
- : string = "onjour"
#reste "b";;
- : string = ""
#reste "";;
Exception non rattrap�e: Failure "La chaine est vide"*)



let minus = fun c->
  if c<=`z`& c>=`a` then true else false;;
  
  
let majus = fun c->
  c<=`Z`& c>=`A` ;;
let lettre = fun c-> minus(c) or majus(c);;

(***************************
Fonction bool�enne d�terminant les symboles de poncuation
****************************)
let ponct = fun 
`.`-> true
|`,`-> true
|`;`-> true
|`:`-> true
| `!`-> true
|`?`-> true
|_-> false;;

(*************
Ponctuation ou espaces 
****************)

let sep = fun 
 ` ` -> true
|`'` -> true
|`-` -> true
| c-> ponct(c);;

(**************************
Transformer les caract�res accentu�s en caract�res non accentu�s
***************************)

let sansAccent = fun 
   `�`->`e`
|  `�`->`e`
|  `�`->`e`
|  `�`->`e`
|  `�`->`a`
|  `�`->`u`
|  `�`->`u`
|  `�`->`u`
|  `�`->`i`
|  `�`->`i`
|  `�`->`o`
|  `�`->`c`
|   c->c;;
(* sansAccent : char -> char = <fun> *)

(* Enleve les majuscules *)
let sansMaj = fun c->
    if majus(c) then char_of_int(int_of_char(c)+32)
    else c;;

(* enleve s�parateurs, accents et majuscules d'un texte *)
let rec simplifie = fun 
""->""
| s-> let c = sansMaj(tetec(s)) in
          if sep(tetec(s)) then   simplifie(reste(s))
          else string_of_char(c)^simplifie(reste(s));;

(*simplifie "Bonjour, joyeux No�l et bonnes f�tes!";;
simplifie : string -> string = <fun>
#- : string = "bonjourjoyeuxnoeletbonnesfetes"*)		  
		  






