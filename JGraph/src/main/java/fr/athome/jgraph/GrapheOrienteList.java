package fr.athome.jgraph;

/**
 * Graphe orient� repr�sent� par ses listes d'adjacence
 */
public class GrapheOrienteList {
	// instance variables - replace the example below with your own
	private int n; // le nombre de sommets
	private int m; // Le nombre d'arcs
	private Liste[] G; // Le vecteur des liste d'adjacence

	/**
	 * Constructeur du graphe (par d�faut, construction d'un graphe sans arc � n
	 * sommets)
	 */
	public GrapheOrienteList(int nb) {
		n = nb;
		m = 0;
		G = new Liste[n + 1];
		for (int i = 1; i <= n; i++) {
			G[i] = new Liste();
		}
	}

	/**
	 * Constructeur du graphe (a partir des listes d'adjacence, sous forme d'un
	 * tableau a deux dimension{{succ de 1},{succ de 2},..,{succ de n}})
	 * 
	 * Test : {{5},{1,4},{2},{3},{2,4}}
	 */
	public GrapheOrienteList(int[][] T) {
		n = T.length;
		G = new Liste[T.length+1];
		G[0] = new Liste();
		for(int i = 0; i < T.length; i++){
			G[i+1] = new Liste();
			for(int succ : T[i]){
				G[i+1].ajoutFin(succ);
			}
		}
	}

	/**
	 * Mutateurs : ajout et suppression d'un arc
	 */
	public void ajoutArc(int i, int j){// vraie valeur indexees a partir de 1
		G[i].ajoutFin(j);
	}

	public void enleveArc(int i, int j){// vraie valeur index�s � partir de 1
		G[i].enleveElt(j);
	}

	/**
	 * Methodes
	 */
	public void affiche() {
		for(Liste l : G){
			l.affiche();
		}
	}
	
	public int degreE(int i){
		int deg = 0;
		for(Liste l : G){
			if(l.indice(i) != -1)
				deg++;
		}
		return deg;
	}
	public int degreS(int i) {
		return G[i].taille();
	}

	public int[] degS() {
		int[] deg = new int[n+1];
		for(int i = 1; i < G.length; i++){
			deg[i] = degreS(i);
		}
		return deg;
	}

	public int[] degE() {
		int[] deg = new int[n+1];
		for(int i = 1; i < G.length; i++){
			deg[i] = degreE(i);
		}
		return deg;
	}

	// conversion en GrapheMat
	public GrapheOrienteMat toMat() {
		int[][] tab = new int[n][];
		for (int i = 1; i < G.length; i++){
			tab[i-1] = new int[G[i].taille()];
			for(int j = 0; j < G[i].taille();j++){
				tab[i-1][j] = G[i].elt(j);
			}
		}
		return new GrapheOrienteMat(tab);
	}

}
