let f = fun (j,m,p,s) ->
  j + (48*m-1)/5 + p/4 + p +s/4 - 2*s;;

let decoupe = fun  a ->
  (a/100,a mod 100);;

let deuxMoisAvant = fun
                  (1,a) -> (11,a-1)
                  |(2,a) -> (12,a-1)
                  |(m,a) -> (m-2,a);;
let leJour = fun
            0 -> "Dimanche"
           |1 -> "Lundi"
           |2 -> "Mardi"
           |3 -> "Mercredi"
           |4 -> "Jeudi"
           |5 -> "Vendredi"
           |6 -> "Samedi"
           |x -> failwith (string_of_int(x) ^" n'est pas un jour valable");;
let modulo7 = fun n ->
  let x = n mod 7 in
  if x >= 0 then x else x +7;;

let quelJour = fun(j,m,a) ->
  let (m,a) = deuxMoisAvant(m,a) in
  let (s,p) = decoupe(a) in
  let k = f(j,m,p,s) in
  leJour(modulo7 k);;
