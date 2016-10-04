let rec length = fun
    [] -> 0
   |(x::tl) -> 1 + length tl;;

let tl = fun
    [] -> failwith "tl"
   |(x::l) -> l;;

let hd = fun
    [] -> failwith "hd : out of bounds"
   |(x::l) -> x;;

let rec map = fun f l ->
  match l with
    [] -> []
  | x::l -> (f x)::(map f l);;

let rec print_list_int = function
  [] -> ()
  | x::l -> begin print_int x;print_string " " end; (print_list_int l);;

let rec nth = fun
    ([],_) -> failwith "nth"
  | (x::l,0) -> x
  | (x::l,i) -> nth (l,(i-1));;

  
let rec merge_sort l =
  let rec divise = fun
  [] -> [],[]
  |(x::[]) -> [x],[]
  |(x::y::tl) -> let (l,l') = divise tl in x::l,y::l' and
  merge = fun
    ([],l) -> l
    | (l,[]) -> l
    |(h1::t1, h2::t2) -> if h1 < h2 then h1::merge (t1,h2::t2) else h2::merge (t2,h1::t1) in
  let n = length l in
  let (l',l'') = divise l in
  if n <= 1 then l else merge ((merge_sort (l')),(merge_sort (l'')));;
    
let rec insertion_sort l =
  let rec insert = fun
      ([],x) -> [x]
     |(y::l,x) -> if x > y then y::(insert (l,x)) else x::y::l in
  match l with
    [] -> []
  | x::l -> insert (insertion_sort l,x);;

let rec quick_sort = function
    [] -> []
   |x::l -> let rec divise = fun gauche droite x l ->
	      match l with
		[] -> (quick_sort gauche) @ (x::(quick_sort droite))
	      | hd::tl -> if x > hd then divise (hd::gauche) droite x tl else divise gauche (hd::droite) x tl in
	    divise [] [] x l;;

let somme l = fold (function (a,b) -> a+b) 0;;
