struct 	
		(*#load "str.cma";;*)		
	
		
		type pion = Couleur of string;;

		type t = pion list ;;

		let nombre_pions = 4;;

		let couleurs_possibles = [Couleur("bleu") ; Couleur("rouge") ; Couleur("vert") ; Couleur("jaune"); Couleur("noir") ; Couleur("orange")] ;;

		let compare code1 code2 = if (code1:t) = (code2:t) then 0
					else if (code1:t) > (code2:t) then 1
					else -1;;

		let string_of_code code1 = 
				let rec aux acc = function
					| [] -> acc
					| Couleur(s)::t -> aux (s^" "^acc) t in aux "" (code1:t);;
		let contient l1 l2 = match l2 with
			(l :t )-> List.for_all ( fun a -> (List.mem a (l1 : t))) l2 ;;
		
		let split_string s = (Str.split (Str.regexp (" ")) s);; 

		let code_of_string_bis stringCode = 
			let ls = (Str.split (Str.regexp " ") stringCode ) in
				let rec aux acc ls = match ls with
						| [] -> acc
						| h::t -> aux ((Couleur(h)::acc): t) t in aux [] ls;;

		let code_of_string s couleur_possible = 
			if (((code_of_string_bis s)<>[] ) && (contient couleur_possible (code_of_string_bis s)))
				then Some(code_of_string_bis s)
			else None;;

		let rec supprime_un a l = match l with
			| [] -> l
			| h :: t when a = h -> t
			| h :: k :: t when a = k -> h :: t 
			| h :: t -> h :: supprime_un a t;;


		let param_couleur_bis n = 
			let rec aux acc n coul = match n with
				| 0 -> acc
				| a when a<7 -> let i = (Random.int(List.length(coul))) in aux ((List.nth (coul) i)::acc) (n-1) (supprime_un (List.nth (coul) i) coul)
				| _-> raise (Failure "nombre trop grand" ) in aux [] n couleurs_possibles;;
		
		let rec param_couleurs n = try (param_couleur_bis n) with
				| Failure "nombre trop grand" -> print_string ("Nombre Incorrect -> Saisir un nombre entre 0 et 6 :\n"); let i= read_int() in param_couleurs i;;


(*let liste_code_possible n lcoul = if (n=2) then (code2 lcoul) else if (n=3) then (code3 lcoul) else (code4 lcoul);; *)


		let make_liste n = 
			let rec aux acc n = match (n+1) with
				|0->acc
				|_-> aux (n::acc) (n-1) in aux [] n;;

		let combi l = 
			let res = List.fold_left (fun acc x -> List.fold_left (fun acc y -> (x,y) :: acc) acc l) [] l in List.rev res;;


		let liste_reponse n = List.filter (fun (b,c)->(b+c)=n) (combi(make_liste n));;


		let bonne_rep c1 c2 = List.filter (fun (a,b) -> a=b ) (List.combine c1 c2);;

		let mauvaise_rep c1 c2 = List.filter (fun (a,b) -> a<>b) (List.combine c1 c2);;

		let reponse_tot c1 c2 = try (Some (List.length (bonne_rep (c1 : t) (c2 : t)),List.length (mauvaise_rep (c1 : t) (c2 : t)))) with
		| Invalid_argument "List.combine" -> None;;


		let tuple_to_string a = match a with
			|Some((b,c)) -> ((string_of_int b)^" bien place, "^(string_of_int c)^" mauvais pion. ")
			|None -> "";;

		let reponse_correcte n = function
			|Some((m,0)) when m=(n+0) -> true
			|_-> false;;



		
	
		let rec saisie couleur_possible tailleCode = print_string("Entrer une proposition de code : "); 
		let s=read_line () in let codeEntre=(code_of_string s couleur_possible) in 
		if ((codeEntre)=None) then (print_string("Saisie incorrecte (Tout écrire en minuscule ou couleurs non définies) : "); saisie couleur_possible tailleCode)
 		else if ((List.length (code_of_string_bis s))>tailleCode)  then (print_string("Saisie incorrecte (Code trop grand) : "); saisie couleur_possible tailleCode)
		else if ((List.length (code_of_string_bis s))<tailleCode) then (print_string("Saisie incorrecte (Code trop petit) : "); saisie couleur_possible tailleCode)
		else List.rev (code_of_string_bis s);;


	let decision_final tentativeMax tailleCode couleur_possible codeSecret =   
try
	Sys.command "clear";	
	let rappel = ref "\n" in 
	for i = 0 to (tentativeMax-1) do
		let entree = saisie couleur_possible tailleCode in entree ;
		rappel := !rappel^"\n"^(string_of_code entree); 		
	match (reponse_correcte tailleCode (reponse_tot codeSecret entree)) with
			|true -> raise Exit
			|false -> print_string ( "Mauvaise réponse -> "^(tuple_to_string (reponse_tot codeSecret entree)));
		Sys.command "clear"

	done;
		false
  
with Exit -> true;;
 
	end;;

