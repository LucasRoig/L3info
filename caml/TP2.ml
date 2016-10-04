let troncature = int_of_float;;

let decimales = fun x -> 
  let dec = x -. float_of_int(troncature(x))in
  if x > 0. then dec else -.dec;;

let partie_entiere = fun x -> 
  let t =float_of_int(troncature x) in
  if x -. t >= 0. then t else t-.1.;;
  

let plus_proche_entier x = troncature(partie_entiere (x+.0.5));;

let arrondi2 = fun x ->  
  let dec = float_of_int(plus_proche_entier(decimales(x) *. 100.)) /. 100. and
  x = float_of_int(troncature x) in
  if x > 0. then x+.dec else x-.dec;;

let franc_en_euros = fun x ->
  arrondi2(x /. 6.55957);;

let quelle_heure_est_il = fun x-> (* Erreur ici : quelle_heure 14.45 -> 14h44
int_of_float(decimales 14.45 *. 100.) -> 44
Revoir la fonction minute
Solution : Utiliser l'arrondi au lieu de la troncature, pour du calcul on utilisera l'arrondi car la troncature amplifie les erreurs dues au codage des nombres en informatique. *)
  let heure = troncature and minute = fun x -> plus_proche_entier((decimales x) *. 100.) in
  let (x,y) = (heure x, minute x) in
  if y = 0 then
    if x = 12 then
      "Il est midi pile" else if x = 24 or x = 0 then "Il est minuit pile" else
      "Il est " ^ string_of_int(x) ^ " heure pile."
  else "Il est " ^ string_of_int(x) ^ " heure " ^ string_of_int(y);;

let reel = fun (a,b,x) ->
  let m = float_of_int(max a b) and dec = decimales(x) in
  if m>0. then m +. dec else m -. dec;;

let chiffre = fun x ->
  abs(x mod 10);;
  
let bool1 = fun (a,b,c) -> (*vrai ssi a b c ont la meme valeur*)
  a = b & b = c;;

let bool2 = fun (a,b,c) -> (*vrai ssi a et b sont egaux mais differents de c*)
  a = b & b <> c;;

let bool3 = fun (a,b,c) -> (*vrai ssi au moins deux valeurs sont identiques*)
  a = b or b = c or a = c;;

let bool4 = fun (a,b,c) -> (*vrai ssi deux valeurs exactement sont identiques*)
  bool3(a,b,c) & (not(bool1(a,b,c)));;

let bool5 = fun (a,b,c) -> (*vrai ssi au plus deux valeurs sont identiques*)
  bool4(a,b,c) or (not(bool1(a,b,c)));;

let bool6 = fun (a,b,c) -> (*vrai ssi la valeur de b est strictement comprise entre a et c*)
  ((a<b) & (b<c)) or ((c<b) & (b<a));; 

let echange = fun (n,p) -> 
  let n' = if n >= 0 then n - chiffre(n) else n + chiffre(n) in
  if n >= 0 then n' + chiffre(p) else n' - chiffre(p);;

let nb_sol = fun (a,b,c) ->
  let delta = (b*b)-4*a*c in
  if delta = 0 then 1 else
    if delta > 0 then 2 else 0;;
