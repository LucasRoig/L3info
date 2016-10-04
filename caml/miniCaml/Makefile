interprete: lexuniv.zo syntaxe.zo eval.zo interprete.zo
	camlc -o interprete lexuniv.zo syntaxe.zo eval.zo interprete.zo

lexuniv.zi: lexuniv.mli
	camlc -c lexuniv.mli

lexuniv.zo: lexuniv.zi lexuniv.ml
	camlc -c lexuniv.ml

syntaxe.zi: syntaxe.mli lexuniv.zo
	camlc -c syntaxe.mli

syntaxe.zo: syntaxe.zi syntaxe.ml
	camlc -c syntaxe.ml

eval.zi: eval.mli syntaxe.zi syntaxe.zo
	camlc -c eval.mli

eval.zo: eval.zi eval.ml syntaxe.zi
	camlc -c eval.ml

interprete.zo: interprete.ml eval.zo
	camlc -c interprete.ml












