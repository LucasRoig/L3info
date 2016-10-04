let rec longueur = fun
    [] -> 0
                 |(_::tl) -> longueur(tl) + 1;;

let rec nEme = fun
    (0,h::t) -> h
             |(n,h::t) -> nEme(n-1,t)
             |_ -> failwith "Out of bounds";;

let rec zeros = fun
    (lst,0) -> lst
              |(lst,n) -> zeros(0::lst,n-1);;

let aligner = fun (lst1,lst2) ->
  let dif = longueur(lst1) - longueur(lst2) in
  if dif >= 0 then (lst1 , zeros (lst2,dif) )
  else (zeros(lst1, (-dif)), lst2);;
          
let couple = fun (lst1,lst2) ->
  let (lst1,lest2) = aligner(lst1,lst2) in
  let rec aux = fun
              ([],[]) -> []
              |((h1::t1),(h2::t2)) -> (h1,h2)::(aux(t1,t2)) in
  aux(lst1,lst2);;

let rec estCroissante = fun
  [] -> true
 |lst -> let aux = fun
                   [_] -> true
                 |(x::y::tl) -> x<=y & estCroissante(y::tl) in aux(lst);;

let rec fusion = fun
    ([],lst) -> lst
   |(lst,[]) -> lst
   |(h1::t1,h2::t2) -> if h1 < h2 then h1::(fusion(t1,h2::t2))
                       else h2::(fusion(h1::t1,t2));;

let rec derive = fun
    [] -> []
   |((x,y)::tl) -> (x-1,y*x)::derive(tl);;

  
