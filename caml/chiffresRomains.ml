let chiffre = fun
             `I` -> 1
            |`V` -> 5
            |`X` -> 10;;
 
let rec rom1 = fun
              "" -> 0
             |s -> chiffre(tetec s) + rom1(reste s);;

let valeurI = fun
             `X` -> 9
            |`V` -> 4
            |`I` -> 2;;

let rec romain = fun
    "" -> 0
           |"I" -> 1                     
           |s -> let hd = tetec s and tl = reste s in
             if hd  = `I` then valeurI(tetec(tl)) + romain(reste(tl))
                 else chiffre(hd) + romain(tl);; 
