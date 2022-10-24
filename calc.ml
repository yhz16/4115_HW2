open Ast

let vmap = Hashtbl.create 100

let rec eval = function 
    Lit(x) -> x
  | Binop(e1, op, e2) -> (
		let v1  = eval e1 in
		let v2 = eval e2 in (
			match op with
				Add -> v1 + v2
			| Sub -> v1 - v2
			| Mul -> v1 * v2
			| Div -> v1 / v2
		)
	)
	| Seq(e1, e2) -> (
		ignore (eval e1);
		let num = eval e2 in (
			num
		)
	)
	| Asn(var, e) -> (
		let num = eval e in
		if Hashtbl.mem vmap var then (
			Hashtbl.replace vmap var num;
			num
		)
		else (
			Hashtbl.add vmap var num;
			num
		)
	)
	| Var(var) -> Hashtbl.find vmap var


let _ =
  let lexbuf = Lexing.from_channel stdin in
  let expr = Parser.expr Scanner.tokenize lexbuf in
  let result = eval expr in
  print_endline (string_of_int result)
