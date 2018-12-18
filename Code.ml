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
