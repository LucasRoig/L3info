let majuscule = fun x ->
  let i = int_of_char(x) in
  i >= 65 & i <= 90;;

let minuscule = fun x ->
  let i = int_of_char(x) in
  i>=97 & i<=122;;

let lettre = fun x ->
  minuscule x or majuscule x;;

let rec appartient = fun
                    ("",_) -> false;
                   |(s,c) -> if tetec s = c then true else
                               appartient(reste s, c);;

(* True si d est le debut de s *)
let rec debut = fun
           ("",_) -> true;
          |(d,"") -> false;
          |(d,s) -> if tetec d <> tetec s then false else
                      debut(reste d, reste s);;

(* Nb d'occurrences du caractere c dans s*)
let rec frequence = fun
                   ("",_) -> 0
                  |(s,c) -> if tetec s = c then frequence(reste s,c) + 1 else
                              frequence(reste s, c);;
(* vrai ssi d incluse dans s*)
let rec incluse = fun 
                 (d,"") -> false
                |(d,s) -> if debut(d,s) then true else
                            incluse(d,reste s);;
(* Elimine le caractere c de s*)
let rec elimine = fun 
                 ("",_) -> ""
                |(s,c) ->  if tetec s = c then elimine(reste s, c) else
                             (tetes s)^elimine(reste s, c);;

let rec renverse = fun
                  "" -> ""
                 |s -> renverse(reste s)^(tetes s);;
  
