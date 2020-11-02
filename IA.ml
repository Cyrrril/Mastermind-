
module IA :
sig
	(** Nombre d'algorithmes developpes *)
	val nombre_methodes : int
	(** le code de l'algorithme naif
*@param code_length ,un entier
*@param couleur_probable ,une liste de couleur
*@return ce que l'IA a trouvé
*)
	val algo_naif : int -> Code.t -> Code.pion list
	(** Choisit un code a proposer
*@param strat, les différentes stratégies
*@param essais, la liste des codes deja proposes
*@param l_code_poss, la liste des codes possibles
*@return le prochain code a essayer
*)
	val choix : int -> Code.t list -> Code.t -> int -> Code.t
	(** donner l'indice d'un élément d'une liste
*@param e, une variable de type générique
*@param l, une liste de type générique
*@return l'indice de l'élément recherché dans la liste
*)
	val indice : 'a -> 'a list -> int
	(** applique la fonction reponse (du module Code) a la liste des codes possibles
*@param code_secret ,un code
*@param l_code_secret ,  une liste de code
*@return la liste a laquelle on a appliquer la fonction réponse
*)
	val app_tous : Code.t -> Code.t list -> (int * int) option list

	(** algorithme de knuth
*@param ((c : t), ans), un tuple 
*@param l_code_poss , une liste de code
*@return
*)
	val algo_knuth : Code.t list -> Code.t
	(** utilisé pour la fonction filtre
*@param (c : t) , un code
*@param l_code_poss, une liste de code
*@return le code que l'IA a trouvé via l'algorithme de knuth
*)	
(** utilisé pour la fonction filtre
*@param (c : t) , un code
*@param l_code_poss, une liste de code
*@return le code que l'IA a trouvé via l'algorithme de knuth
*)	
	val filtre_algo_knuth : Code.t -> (int * int) -> Code.t list -> Code.t list

	(** Filtre les codes possibles
*@param strat, les différentes stratégies
*@param ((c : t), ans), le code essaye et la reponse correspondante
*@param l_code_poss, la liste de courante de codes possibles
*@return la nouvelle liste de codes possibles
*)
	val filtre_algo_naif : Code.t -> Code.t list -> Code.t list
	(** Filtre les codes possibles
*@param strat, les différentes stratégies
*@param ((c : t), ans), le code essaye et la reponse correspondante
*@param l_code_poss, la liste de courante de codes possibles
*@return la nouvelle liste de codes possibles
*)
	val filtre : int -> Code.t * (int * int) option -> Code.t list -> Code.t list
	
	end = 

struct


open Code


    let nombre_methodes = 2;;

    
    let algo_naif code_length couleur_probable = 
	    let rec aux acc code_length = match code_length with
	        	|0-> acc
	        	|n when n<0 -> raise (Invalid_argument "generation_code_secret")
	        	|n -> aux ((List.nth couleur_probable (Random.int (List.length couleur_probable)))::acc) (code_length-1) in aux [] code_length;;


    let rec choix strat essais l_code_poss code_length = match strat with
	            |1 -> let (prop : t) = algo_naif code_length l_code_poss in (prop : t)
	            |0 -> let (prop : t) = algo_naif code_length l_code_poss in if (List.mem (prop : t) essais) then choix strat essais l_code_poss code_length else prop
	            |_-> failwith "Error";;

    let indice e l =
	        let rec aux i = function
		        | [] -> raise Not_found
		        | h ::t  -> if h = e then i else aux (i+1) t 
        	in aux 0 l ;;
    
    
    let app_tous code_secret  l_code_poss = List.map (fun a -> reponse code_secret a)  l_code_poss;;
	
    let algo_knuth l_code_poss = let (l_codesresult, _) = List.fold_left (fun (acccode, accscore) y -> (match (
																											List.fold_left (fun minimumhit (b, w) -> 
																													let valeur = (
																														List.fold_left (fun compteur proposition -> (match (reponse proposition y) with
																																	| Some (b2, w2) when b2 <> b || w2 <> w -> compteur + 1
																																	| _ -> compteur)) 0 l_code_poss
																													) in 
																														if (minimumhit > valeur) then valeur else minimumhit 
																												) (List.length l_code_poss) (Code.liste_reponse 4)
																											) with
																									| scorey when scorey > accscore -> ([y],scorey)
																									| scorey when scorey < accscore -> (acccode,accscore) 
																									| scorey when scorey = accscore -> (y :: acccode ,accscore)
																									)) ([], 0) l_code_poss in try List.find (fun x -> List.exists (fun y -> (compare x y) = 0) l_code_poss) l_codesresult with _ -> List.nth l_codesresult 0;;



    
    let filtre_algo_naif (c : t) l_code_poss = supprime_un c l_code_poss;;


	let filtre_algo_knuth code (b, w) l_code_poss = List.filter (fun x -> let (result2) = reponse code x in match result2 with
																									| Some (b2, w2) -> b2=b && w2=w
																									| None -> false) l_code_poss;;


	let rec filtre strat ((c : t), ans) l_code_poss = match strat with 
			|0 -> filtre_algo_naif (c : t) l_code_poss
			|1 -> (match ans with
				Some (x, y) -> filtre_algo_knuth c (x,y) l_code_poss
				| None -> l_code_poss)
			|_-> let ()= print_string "1 ou 0" in filtre strat ((c : t), ans) l_code_poss;;
end;;