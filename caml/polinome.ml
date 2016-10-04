let affiche_monome coeff degres =
  if degres = 0 then print_int coeff else
    if coeff <> 0 then
      begin
	print_string (" + ");
	print_int coeff;
	print_string "X";
	if degres <> 1 then begin print_string "^"; print_int degres;end;
      end;;
let affiche_polynome p =
  for i = 0 to Array.length p - 1 do
    affiche_monome p.(i) i done;;
let add_polynome a b =
  let p = Array.make (max (Array.length a) (Array.length b)) 0 in
  for i = 0 to Array.length a - 1 do
    p.(i) <- a.(i);
  done;
  for i = 0 to Array.length b - 1 do
    p.(i) <- p.(i) + b.(i);
  done;
  p;;

let mult_polynome a b=
  let p = Array.make (Array.length a + Array.length b -1) 0 in
  for i = 0 to Array.length a - 1 do
    for j = 0 to Array.length b - 1 do
      p.(i+j) <- a.(i) * b.(j) + p.(i+j);
    done;
  done;
  p;;
				  
	
