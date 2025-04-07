open Printf

let memory = ref []
let acc = ref 0
let program = ref []

let hex_to_int hex =
  try int_of_string hex with
  | _ -> failwith (" ! NO > " ^ hex)

let parse_command cmd =
  match String.lowercase_ascii cmd with
  | "hlt" -> 0x00
  | "out" -> 0x01
  | "asc" -> 0x02
  | "inp" -> 0x03
  | "ld"  -> 0x04
  | "st"  -> 0x05
  | "inc" -> 0x06
  | "dec" -> 0x07
  | "res" -> 0x08
  | _ -> failwith (" ! NO > " ^ cmd)

let load_program input =
  let lines = String.split_on_char '\n' input in
  program := List.flatten (List.map (fun line ->
    let words = String.split_on_char ' ' line in
    List.map (fun word ->
      if String.starts_with ~prefix:"0x" word then
        hex_to_int (String.sub word 2 (String.length word - 2))
      else
        parse_command word
    ) words
  ) lines)

let push value = memory := value :: !memory
let pop () = match !memory with
  | [] -> failwith " ! NO > Stack underflow"
  | v :: rest -> memory := rest; v

let execute () =
  let rec exec_loop () =
    if !program <> [] then
      let op = List.hd !program in
      program := List.tl !program;

      match op with
      | 0x00 -> exit 0
      | 0x01 -> printf " > %d\n" !acc; exec_loop ()
      | 0x02 -> printf " > %c\n" (Char.chr !acc); exec_loop ()
      | 0x03 -> printf " < "; 
        let input = read_int () in acc := input; exec_loop ()
      | 0x04 -> acc := pop (); exec_loop ()
      | 0x05 -> push !acc; exec_loop ()
      | 0x06 -> acc := !acc + 1; exec_loop ()
      | 0x07 -> acc := !acc - 1; exec_loop ()
      | 0x0A -> acc := 0; exec_loop ()
      | _ -> printf " ! NO > %d\n" op; exec_loop ()
    else ()
  in
  exec_loop ()

let rec print_prompt () =
  let rec print_lines () =
    printf " ψ | ";  
    let input = read_line () in
    if input = "" then
      print_prompt ()
    else (
      load_program input;
      execute ();
      print_lines ()
    )
  in
  print_lines ()

let () =
  printf "Welcome to the OSPA interpreter!\n";
  print_prompt ()
