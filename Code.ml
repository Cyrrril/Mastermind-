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
*@param c1, premier code a comparer
*@param c2, second code a comparer
*@return 0 si les deux codes sont identiques,
un entier positif si [c1] est strictement plus grand que [c2]
un entier negatif si [c1] est strictement plus petit que [c2]
*)
		val compare : t -> t -> int


		(** Conversion code vers chaine de caracteres (pour affichage)
*@param c1, code a convertir
*@return la representation en chaine de caracteres de [code]
*)		
		val string_of_code : t -> string

		(** contient
*@param l1,
*@param l2,
*@return vrai ou faux selon si la liste 2 contient des élements de la liste 1
*)		
		val contient : t -> t -> bool
		
		(** Conversion chaine de caracteres vers code (pour saisie)
*@param s, chaine de caractere saisie
*@return couleur_probable, le code correspondant a la saisie si la conversion est possible
[None] si la conversion n'est pas possible
*)
		val code_of_string : string -> t -> t option

		(** 


*)
		val liste_code_possible : int -> 'a list -> 'a list list 


		(** supprimer un élément d'une liste (fait en td)
*@param a, un élément de n'importe quel type
*@param l, une liste de n'importe quel type
*@return la liste sans l'élément donné en 1er paramètre
*)
		val supprime_un : 'a -> 'a list -> 'a list

		(** créer une liste de n couleurs
*@param n, un entier n entre 0 et 6 
*@return une liste de n couleurs donné aléatoirement
*)
		val createListCoul: int -> pion list
      
		(** créer une liste de n+1 entiers
*@param n, un entier 
*@return une liste de n+1 entiers démarrant de 0 jusqu'au nombre n
*)
		val createListEnt : int -> int list

		(** créer une liste de couples
*@param l, une liste de n'importe quel type 
*@return une liste de couples contenant tous les couples possibles de la liste
*)
		val combinaison : 'a list -> ('a * 'a) list

		(** La liste de toutes les reponses possibles 
*@param n, un entier
*@return un couple d'entier
*)
		val liste_reponse : int -> (int * int) list

		(** créer une liste de couples
*@param une liste de n'importe quel type 
*@param une liste de n'importe quel type 
*@return une liste de couples contenant les couples des valeurs identiques entre les 2 listes 
*)
		val bonne_reponse : 'a list -> 'a list -> ('a * 'a) list

		(** créer une liste de couples
*@param une liste de n'importe quel type 
*@param une liste de n'importe quel type 
*@return une liste de couples contenant les couples de valeurs différentes entre les 2 listes
*)	
		val mauvaise_reponse : 'a list -> 'a list -> ('a * 'a) list

		(** Calcule la reponse d'un code par rapport au code cache
*@param code le code propose
*@param vrai_code le code cache
*@return un couple (nombre de pions bien places, nombre de pions mal places)
[None] si la reponse ne peut etre calculee
*)
		val reponse : t -> t -> (int * int) option

		(** créer une chaîne de carcatère à partir d'un couple 			*@param a, un couple d'entier
*@return une chaîne de caractère donnant le nombre de pions bien placé et le nombre de pions mal placé 
*)
		val tuple_to_string : (int * int) option -> string

		(** créer une liste de couples
*@param n, un entier
*@param a, un couple d'entier
*@return vrai ou faux si la réponse proposé correspond ou non au code de base
*)
		
		val reponse_correcte : int -> (int * int) option -> bool

		(** entrer une proposition de code
*@param couleur_probable, liste des couleurs
*@param taille_code, un entier entre 1 et 6
*(return une liste des couleurs que l'on propose
*)
		val saisie_code : t -> int -> pion list

		(** récupère le code saisie par l'utilisateur
*@param tentativeMax, un entier
*@param taille_code, un entier
*@param couleur_probable, une liste de couleur
*@param code_secret, une liste de couleur
*@return la liste de pion saise  
*)
		val decision_final : int -> int -> t -> t -> bool

		(** Génère un code secret
*@param taille_code, un entier
*@param couleur_probable, un entier
*@return vrai ou faux si
*) 
		val generation_code_secret : int -> 'a list -> 'a list

		(** Le joueur devine le code
*@param un entier
*@param une liste de couleur
*@param un entier
*@return vrai ou faux si
*)
		
		val joueur_cherche : int -> int -> t -> bool

		(** Réponse automatique du joueur (pas de vérification)
*@param type générique
*@return un couple d'entier
*)

		
		val reponse_automatique_joueur : int -> t -> int -> bool

		(** Le joueur saisie le nombre de pions bien placés et mal placés 
*@param un pointeur sur le string
*@param un entier 
*@param un couple d'entier
*@return 
*)

		val saisie_rep_manuel : int -> (int*int) option

		(** entrer 
*@param entier
*@param une liste de couleur
*@param un entier
*@return 
*)
	
		val bon_faux : string ref -> int -> (int*int) option -> unit

		(** Réponse finale du joueur 
*@param un entier
*@return un entier
*)

		val reponse_manuel_joueur : int -> t -> int -> bool 

		(** entrer 
*@param une chaine de caractère
*@param une liste de couleur
*@param un entier
*@param un entier
*@param un type générique
*@param un type générique
*@return vrai ou faux
*)

		val est_toujours_pair : int  -> int


		(** détermine qui commence de manière automatique 
*@param une chaine de caractère
*@param une liste de couleur
*@param un entier
*@param un entier
*@param un type générique
*@param un type générique
*@return vrai ou faux
*)

		val qui_commence_auto : string -> t -> int -> int -> 'a -> 'a -> bool

		(** détermine qui commence de manière manuel 
*@param une chaine de caractère
*@param une liste de couleur
*@param un entier
*@param un entier
*@param un type générique
*@param un type générique
*@return vrai ou faux
*)
		val qui_commence_manuel : string -> t -> int -> int -> 'a -> 'a -> bool

		(** entrer 
*@param un entier
*@param une liste de couleur
*@param un entier
*@param un entier
*@param vrai ou faux si 
*@return un couple d'entier
*)

		val qui_commence : string -> t -> int -> int -> 'a -> 'a  -> bool -> bool

		(** Permet d'alterner le joueur qui va commencer entre chaque partie 
*@param nom_joueur, une chaine de caractère
*@param nbPartie, un entier
*@param couleurProbable, une liste de couleur
*@param taille_code, un entier
*@param tentativeMax, un entier
*@param joueur, vrai ou faux si
*@param autom, 
*@return 
*)

		val alternance : string -> int -> t -> int -> int -> int -> bool -> int*int


		(** Détermine qui a gagné 
*@param une chaine de caractère
*@param un entier
*@param un entier
*@param vrai ou faux si
*@return 
*)
		val victoire : string -> int -> t -> int -> int -> int -> bool -> unit 



		val mastermind : string -> int -> int -> bool -> unit
	end =

struct 	

		
		type pion = Couleur of string;;

		type t = pion list ;;

		let nombre_pions = 4;;

		let couleurs_possibles = [Couleur("bleu") ; Couleur("rouge") ; Couleur("vert") ; Couleur("jaune"); Couleur("noir") ; Couleur("orange")] ;;

		let clscreen b = print_string "";;

		

		let compare c1 c2 = if (c1:t) = (c2:t) then 0
					else if (c1:t) > (c2:t) then 1
					else -1;;

		let string_of_code c1 = 
				let rec aux acc = function
					| [] -> acc
					| Couleur(s)::t -> aux (s^" "^acc) t in aux "" (c1:t);;
		let contient l1 l2 = match l2 with
			(l :t )-> List.for_all ( fun a -> (List.mem a (l1 : t))) l2 ;;
		
		let split_string s = (Str.split (Str.regexp (" ")) s);; 

		let code_of_string_bis stringCode = 
			let ls = (Str.split (Str.regexp " ") stringCode ) in
				let rec aux acc ls = match ls with
						| [] -> acc
						| h::t -> aux ((Couleur(h)::acc): t) t in aux [] ls;;

		let code_of_string s couleur_probable = 
			if (((code_of_string_bis s)<>[] ) && (contient couleur_probable (code_of_string_bis s)))
				then Some(code_of_string_bis s)
			else None;;


		let code_2 l1 = 
   			let res = List.fold_left (fun acc x -> List.fold_left (fun acc 					y -> (x::y::[]) :: acc) acc l1) [] l1 in List.rev res;;

		let code_3 l1 =
	 		let res = List.fold_left (fun acc x ->
     				List.fold_left (fun acc y -> List.fold_left (fun acc z -> (x::y::z::[]) :: acc) acc l1) acc l1) [] l1 in List.rev res;;

		let code_4 l1 =
			let res = List.fold_left (fun acc x ->
     				List.fold_left (fun acc y -> 
					List.fold_left (fun acc z ->List.fold_left (fun acc t -> (x::y::z::t::[]) :: acc) acc l1) acc l1) acc l1) [] l1  in List.rev res;;

let liste_code_possible n lcoul = if (n=2) then (code_2 lcoul) else if (n=3) then (code_3 lcoul) else (code_4 lcoul);;



		let rec supprime_un a l = match l with
			| [] -> l
			| h :: t when a = h -> t
			| h :: k :: t when a = k -> h :: t 
			| h :: t -> h :: supprime_un a t;;


		let createListCoul_bis n = 
			let rec aux acc n coul = match n with
				| 0 -> acc
				| a when a<7 -> let i = (Random.int(List.length(coul))) in aux ((List.nth (coul) i)::acc) (n-1) (supprime_un (List.nth (coul) i) coul)
				| _-> raise (Failure "nombre trop grand" ) in aux [] n couleurs_possibles;;
		
		let rec createListCoul n = try (createListCoul_bis n) with
				| Failure "nombre trop grand" -> print_string ("Nombre Incorrect -> Saisir un nombre entre 0 et 6 :\n"); let i= read_int() in createListCoul i;;


		let createListEnt n = 
			let rec aux acc n = match (n+1) with
				|0->acc
				|_-> aux (n::acc) (n-1) in aux [] n;;

		let combinaison l = 
			let res = List.fold_left (fun acc x -> List.fold_left (fun acc y -> (x,y) :: acc) acc l) [] l in List.rev res;;


		let liste_reponse n = List.filter (fun (b,c)->(b+c)=n) (combinaison(createListEnt n));;


		let bonne_reponse c1 c2 = List.filter (fun (a,b) -> a=b ) (List.combine c1 c2);;

		let mauvaise_reponse c1 c2 = List.filter (fun (a,b) -> a<>b) (List.combine c1 c2);;

		let reponse c1 c2 = try (Some (List.length (bonne_reponse (c1 : t) (c2 : t)),List.length (mauvaise_reponse (c1 : t) (c2 : t)))) with
		| Invalid_argument "List.combine" -> None;;


		let tuple_to_string a = match a with
			|Some((b,c)) -> ((string_of_int b)^" bien place, "^(string_of_int c)^" mal placé. ")
			|None -> "";;

		let reponse_correcte n = function
			|Some((m,0)) when m=(n+0) -> true
			|_-> false;;
	
	
		let rec saisie_code couleur_probable taille_code = print_string("Entrer une proposition de code : "); 
		let s=read_line () in let codeEntre=(code_of_string s couleur_probable) in 
		if ((codeEntre)=None) then (print_string("Saisie incorrecte (Tout écrire en minuscule ou couleurs non définies) : "); saisie_code couleur_probable taille_code)
 		else if ((List.length (code_of_string_bis s))>taille_code)  then (print_string("Saisie incorrecte (Code trop grand) : "); saisie_code couleur_probable taille_code)
		else if ((List.length (code_of_string_bis s))<taille_code) then (print_string("Saisie incorrecte (Code trop petit) : "); saisie_code couleur_probable taille_code)
		else List.rev (code_of_string_bis s);;

let rec print_list = function
	|[] -> ()
	|(Couleur(h))::t -> print_string h ; print_string " "; print_list t;;



	let decision_final tentativeMax taille_code couleur_probable code_secret =   
try
	Sys.command "clear";	
	let rappel = ref "\n" in 
	for i = 0 to (tentativeMax-1) do
		let entree = saisie_code couleur_probable taille_code in entree ;
		rappel := !rappel^"\n"^(string_of_code entree); 		
	match (reponse_correcte taille_code (reponse code_secret entree)) with
			|true -> raise Exit
			|false -> print_string ( "Mauvaise réponse -> "^(tuple_to_string (reponse code_secret entree)));
		Sys.command "clear"

	done;
		false
  
with Exit -> true;;

let generation_code_secret taillecode couleur_probable = 
	let rec aux acc taillecode = match taillecode with
		|0-> acc
		|n when n<0 -> raise (Invalid_argument "generation_code_secret")
		|n -> aux ((List.nth couleur_probable (Random.int (List.length couleur_probable)))::acc) (taillecode-1) in aux [] taillecode;;


 
	
let joueur_cherche tentativeMax taille_code couleur_prob = let codeOrdi = generation_code_secret taille_code couleur_prob in decision_final tentativeMax taille_code couleur_prob codeOrdi;;

let reponse_automatique_joueur taille_code couleur_prob tentativeMax = 
try
print_string "Liste de couleur possible: "; print_list couleur_prob; print_string "\n";
let rappel = ref "\n" in
let entree = saisie_code couleur_prob taille_code in 
	for i = 0 to (tentativeMax-1) do
		let ()=clscreen (Sys.command "clear") in
			let ()=print_string "Entrer pour continuer" in
				let ()=print_string (read_line ()) in
					let codeOrdi = generation_code_secret taille_code couleur_prob in 
						let ()= (rappel := !rappel^"\n"^(string_of_code (List.rev codeOrdi))) in
							match (reponse_correcte taille_code (reponse entree codeOrdi)) with
								|true -> raise Exit
								|false -> print_string ( (!rappel)^"\n"^"\n"^("Mauvaise réponse -> ")^(tuple_to_string (reponse entree codeOrdi))^"\n") 
	done;
	false
  
with Exit -> true;;


let saisie_rep_manuel2 n= let ()=print_string "Verifiez le code: \n(Nb bon et bien placé) \n" in 
			let a=read_int () in 
				let ()=print_string "(Nb bon mais mal placé) \n" in 
					let b=read_int () in 
						let rep_manu=Some (a,b) in rep_manu;;

let rec saisie_rep_manuel n = try (saisie_rep_manuel2 0 ) with
				|Failure "int_of_string" -> saisie_rep_manuel 0;;


exception Exit3;;

let bon_faux rappel taille_code rep_manu = match (reponse_correcte taille_code rep_manu) with
	|false -> print_string ( (!rappel)^"\n"^"\n"^("Mauvaise réponse -> ")^(tuple_to_string rep_manu)^"\n")
	|true -> raise Exit3;;

let reponse_manuel_joueur taille_code couleur_prob tentativeMax = 
try
print_string "Liste de couleur possible: "; print_list couleur_prob; print_string "\n";
let entree = saisie_code couleur_prob taille_code in let rappel = ref "\n" in
	for i = 0 to (tentativeMax-1) do
	let ()=clscreen (Sys.command "clear") in
		let codeOrdi = generation_code_secret taille_code couleur_prob in let ()= print_string "Code ordi : " in let ()=print_list codeOrdi in let ()=print_string "\n" in
			let rep_manu = saisie_rep_manuel 0 in
				let ()= (rappel := !rappel^"\n"^(string_of_code (List.rev codeOrdi))) in
					match (rep_manu = (reponse entree codeOrdi)) with 
						|true -> bon_faux rappel taille_code rep_manu
						|false -> raise Exit			
	done;
	false
  
with |Exit -> let ()=print_string "Vous avez tricher !\n" in true
     |Exit3 -> true;;



let est_toujours_pair n = match (n mod 2) with
	|0 -> n
	|a -> n+1 ;;

let qui_commence_auto nom_joueur couleur_prob taille_code tentativeMax joueur n= let ()=clscreen (Sys.command "clear") in if (joueur=n) then (print_string ("\n"^nom_joueur^" créé le code \n");( reponse_automatique_joueur taille_code couleur_prob tentativeMax )) else (print_string "L'ordi créé le code \n";(joueur_cherche tentativeMax taille_code couleur_prob));;

let qui_commence_manuel nom_joueur couleur_prob taille_code tentativeMax joueur n= let ()=clscreen (Sys.command "clear") in if (joueur=n) then (print_string ("\n"^nom_joueur^" créé le code \n");( reponse_manuel_joueur taille_code couleur_prob tentativeMax )) else (print_string "L'ordi créé le code \n";(joueur_cherche tentativeMax taille_code couleur_prob));;

let qui_commence nom_joueur couleur_prob taille_code tentativeMax joueur n autom= match autom with
	|true -> qui_commence_auto nom_joueur couleur_prob taille_code tentativeMax joueur n
	|false -> qui_commence_manuel nom_joueur couleur_prob taille_code tentativeMax joueur n;;

let alternance nom_joueur nbPartie couleur_prob taille_code tentativeMax joueur autom=  
let rec alternance_bis nom_joueur nbPartie couleur_prob taille_code tentativeMax joueur autom score =let ((x,y))=score in match nbPartie with
	|0 -> score
	|a when ((a mod 2)=0) -> let b=(qui_commence nom_joueur couleur_prob taille_code tentativeMax joueur 0 autom) in if ((not b ) && (joueur =0)) then 
		 			alternance_bis nom_joueur (nbPartie-1) couleur_prob taille_code tentativeMax joueur autom (x+1,y)
				 else if ((not b) && (joueur =1)) then
					alternance_bis nom_joueur (nbPartie-1) couleur_prob taille_code tentativeMax joueur autom ((x,y+1))
				 else if ((b) && (joueur =0)) then
					alternance_bis nom_joueur (nbPartie-1) couleur_prob taille_code tentativeMax joueur autom (x,y+1)
				 else alternance_bis nom_joueur (nbPartie-1) couleur_prob taille_code tentativeMax joueur autom (x+1,y)
	|a  -> let c=(qui_commence nom_joueur couleur_prob taille_code tentativeMax joueur 1 autom) in (if ((not c) && (joueur =1)) then 
		 			alternance_bis nom_joueur (nbPartie-1) couleur_prob taille_code tentativeMax joueur autom (x+1,y)
				 else if ((not c) && (joueur =0)) then
					alternance_bis nom_joueur (nbPartie-1) couleur_prob taille_code tentativeMax joueur autom (x,y+1)
				 else if ((c) && (joueur =1)) then
					alternance_bis nom_joueur (nbPartie-1) couleur_prob taille_code tentativeMax joueur autom (x,y+1)
				 else alternance_bis nom_joueur (nbPartie-1) couleur_prob taille_code tentativeMax joueur autom (x+1,y)) in alternance_bis nom_joueur nbPartie couleur_prob taille_code tentativeMax joueur autom (0,0);;

let victoire nom_joueur nbPartie couleur_prob tailleCode tentativeMax joueur autom = let result = alternance nom_joueur nbPartie couleur_prob tailleCode tentativeMax joueur autom in match result with
	|(a,b) when a>b -> print_string (nom_joueur^" gagne")
	|(a,b) when a=b -> print_string "Egalite"
	|_->print_string "Ordi gagne";;
		

let mastermind nom_joueur tentativeMax nbPartie autom = let ()=clscreen (Sys.command "clear") in 
	let npart = est_toujours_pair nbPartie in 
		let ()=print_string "Combien de couleur souhaitez vous ? (max 6) " in 
			let nbCouleur = read_int () in 
				let couleur_prob = createListCoul nbCouleur in 
					let () = print_string "Quelle taille de code ? (max 4) " in 
						let tailleCode=read_int () in 
							let joueur=Random.int 2 
								in victoire nom_joueur npart couleur_prob tailleCode tentativeMax joueur autom;;

end;;



