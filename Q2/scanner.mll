(* Ocamllex scanner for floating point *)

(* basic components *)
let digit = ['0'-'9']
let exp_sign = ['e' 'E']
let sign = ['-' '+']

(* handle exp *)
let exp_part =((exp_sign) (sign) ? (digit+))

let floating_ponit =
	((digit+) ('.')) |
	((digit*) ('.') (digit+) (exp_part?)) |
	((digit+) (exp_part))

rule lex_float = parse
	floating_ponit as flit { string_of_float(float_of_string flit) }
	| _ {raise (Failure("invalid input"))}

{
	let buf = Lexing.from_channel stdin in
	let f = lex_float buf in
	print_endline f
}
