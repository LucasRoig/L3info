let rec puissance = fun
                   (x,0) -> 1.
                  |(x,n) -> x *. puissance(x,n-1);;
  
let rec repet = fun
              (_,0) -> failwith "impossible de repeter 0 fois un chiffre"
              |(x,1) -> x
              |(x,n) -> (repet(x,n-1)) * 10 + x;;

let rec unChiffre = fun (x,n) ->
  if x < 10 then x = n else ((x mod 10) = n) & unChiffre(x/10,n);;

let rec pgd = fun (n,d) ->
  if (n mod d) = 0 then d else pgd(n,d-1);;

let rec nbPairChif = fun (n) ->
  if (n < 10) & (n > -10)  then false
  else not nbPairChif(n/10);;

let rec multEgypt = fun
                   (1,p) -> p
                  |(n,p) -> if (n mod 2) = 0 then multEgypt(n/2,p+p)
                            else multEgypt(n-1,p) + p;;

let rec sChif = fun n ->
  if n < 10 then n else (n mod 10) + sChif(n/10);;

let rec somChif = fun n ->
  if n < 10 then n else somChif(sChif(n));;
