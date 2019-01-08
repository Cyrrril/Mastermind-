module Code : 
	sig	
		(** Le type d'un pion *)
		type pion = Couleur of string

		
		(** Le type d'un code *)
		type t = pion list 

		(** Nombre de pions par code *)
		val nombre_pions : int 

		(** Liste des couleurs possibles *)
		val couleurs_possibles : pion list

		(** Compare deux codes
* @param code1 premier code a comparer
* @param code2 second code a comparer
* @return 0 si les deux codes sont identiques,
un entier positif si [code1] est strictement plus grand que [code2]
un entier negatif si [code1] est strictement plus petit que [code2]
*)
		val compare : t -> t -> int


		(** Conversion code vers chaine de caracteres (pour affichage)
* @param code code a convertir
* @return la representation en chaine de caracteres de [code]
*)		
		val string_of_code : t -> string

		(** contient
*@param liste1
*@param liste2
*@return vrai ou faux selon si la liste 2 contient des élements de la liste 1
*)		
		val contient : t -> t -> bool
		
		val code_of_string_bis : string -> t

		(** Conversion chaine de caracteres vers code (pour saisie)
* @param string chaine de caractere saisie
* @return le code correspondant a la saisie si la conversion est possible
[None] si la conversion n'est pas possible
*)
		val code_of_string : string -> t -> t option


		(** supprimer un élément d'une liste
	@param un élément de n'importe quel type
	@param une liste de n'importe quel type
	@return la liste sans l'élément donné en 1er paramètre
*)
		val supprime_un : 'a -> 'a list -> 'a list

		val param_couleur_bis : int -> pion list

		(** créer une liste de n couleurs
	@param un entier n entre 0 et 6 
	@return une liste de n couleurs donné aléatoirement
*)
		val param_couleurs: int -> pion list
      
		(** créer une liste de n+1 entiers
	@param un entier n 
	@return une liste de n+1 entiers démarrant de 0 jusqu'au nombre n
*)
		val make_liste : int -> int list

		(** créer une liste de couples
	@param une liste de n'importe quel type 
	@return une liste de couples contenant tous les couples possibles de la liste
*)
		val combi : 'a list -> ('a * 'a) list

		(** La liste de toutes les reponses possibles *)
		val liste_reponse : int -> (int * int) list

		(** créer une liste de couples
	@param une liste1 de n'importe quel type 
	@param une liste2 de n'importe quel type 
	@return une liste de couples contenant les couples des valeurs identiques entre les 2 listes 
*)
		val bonne_rep : 'a list -> 'a list -> ('a * 'a) list

		(** créer une liste de couples
	@param une liste1 de n'importe quel type 
	@param une liste2 de n'importe quel type 
	@return une liste de couples contenant les couples de valeurs différentes entre les 2 listes
*)	
		val mauvaise_rep : 'a list -> 'a list -> ('a * 'a) list

		(** Calcule la reponse d'un code par rapport au code cache
* @param code le code propose
* @param vrai_code le code cache
* @return un couple (nombre de pions bien places, nombre de pions mal places)
[None] si la reponse ne peut etre calculee
*)
		val reponse_tot : t -> t -> (int * int) option

		(** créer une chaîne de carcatère à partir d'un couple
	@param un couple d'entier
	@return une chaîne de caractère donnant le nombre de pions bien placé et le nombre de pions mal placé 
*)
		val tuple_to_string : (int * int) option -> string

		(** créer une liste de couples
	@param un entier
	@param un couple d'entier
	@return vrai ou faux si la réponse proposé correspond ou non au code de base
*)
		
		val reponse_correcte : int -> (int * int) option -> bool

		(** entrer une proposition de code
* @param liste des couleurs
* @param un entier entre 1 et 6
* @return une liste des couleurs que l'on propose
*)
		val saisie : t -> int -> pion list

	
		val decision_final : int -> int -> t -> t -> bool 

		(*val tous : t list;;

		val toutes_reponses : (int*int) list ;;

		val reponse : t -> t -> (int*int) option;;*)
	
	end =

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
			|Some((b,c)) -> ((string_of_int b)^" bien place, "^(string_of_int c)^" mal placé. ")
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

let generation_codeSec taillecode couleur_possible = 
	let rec aux acc taillecode = match taillecode with
		|0-> acc
		|n when n<0 -> raise (Invalid_argument "generation_codeSec")
		|n -> aux ((List.nth couleur_possible (Random.int (List.length couleur_possible)))::acc) (taillecode-1) in aux [] taillecode;;


 
	end;;
	
let joueur_devine tentativeMax tailleCode couleur_pos = let codeOrdi = generation_codeSec tailleCode couleur_pos in decision_final tentativeMax tailleCode couleur_pos codeOrdi;;





