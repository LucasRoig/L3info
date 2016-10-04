include "TP2";;

  
let entier = fun
           0 -> "zero"
           |1 -> "un"
           |x -> if (x mod 2) = 0 then "pair" else "impair";;

let point = fun
          (0.,0.) -> "origine"
          |(0.,_) -> "axe des ordonees"
          |(_,0.) -> "axe des abscisses"
          |(x,_) -> if x > 0. then "point du demi-plan x > 0" else "point du demi-plan x < 0";;

let operation = fun
              (x,y,`+`) -> x+y
              |(x,y,`-`) -> x-y
              |(x,y,`*`) -> x*y
              |(x,0,`/`) -> failwith "Division par 0"
              |(x,y,`/`) -> x/y
              |_ -> failwith "Ce n'est pas une operation";;
  
let calculPrixTTC = fun (TTC,TVA) ->
  let taxe = TTC *. (TVA /. 100.) in
  TTC +. taxe;;

let prix = fun
          "pain" -> (1.05,5.5)
         |"conserve" -> (3.5,7.)
         |"disque" -> (12.3,18.6)
         |"bijou" -> (356.,33.)
         |_ -> failwith "Article indisponible";;
let sommeAPayer = fun (nom,q) ->
  arrondi2(float_of_int(q) *. calculPrixTTC(prix(nom)));;
