package fr.athome.jgraph;

/**
 * Graphe orient� repr�sent� par sa matrice d'adjacence
 */
public class GrapheOrienteMat {
	private int n; // le nombre de sommets
	private int m; // Le nombre d'arcs
	private int[][] mat; // La matrice d'adjacence

	/**
	 * Constructeur du graphe (par d�faut, construction d'un graphe sans arc � n
	 * sommets)
	 */
	public GrapheOrienteMat(int nb) {
		n = nb;
		m = 0;
		mat = new int[n + 1][n + 1];
	}

	/**
	 * Constructeur du graphe (a partir des listes d'adjacence, sous forme d'un
	 * tableau a deux dimension{{succ de 1},{succ de 2},..,{succ de n}}) On en
	 * profite pour calculer les degres sortants et entrant stockes en mat[i,0]
	 * et mat[0,i]
	 * 
	 * Test : {{5},{1,4},{2},{3},{2,4}}
	 */
	public GrapheOrienteMat(int[][] T) {
		this.n = T.length;
		this.mat = new int[T.length+1][T.length+1];
		for (int i = 0; i<T.length;i++){
			for(int succ : T[i]){
				mat[i+1][succ] = 1; //Si je veux des multi-graphe : += 1
				mat[0][succ] += 1; //Calcul deg entrants
				m += 1;
			}
			mat[i+1][0] = T[i].length;//Calcul deg sortants
		}
	}

	/**
	 * M�thodes associ�es
	 */

	public int nbSommets() {
		return n;
	}

	public int nbArcs() {
		return m;
	}

	public void affiche() {
		for (int i = 1; i < this.mat.length; i++){
			System.out.print("[");
			for(int j = 1; j < this.mat.length - 1; j++){
				System.out.print(this.mat[i][j] + " , ");
			}
			System.out.println(this.mat[i][this.mat.length - 1]+"]");
		}
	}

	public int degreS(int i) {
		return mat[i][0];
	}

	public int degreE(int i) {
		return mat[0][i];
	}

	public int[] degS() {
		int[] deg = new int[this.mat.length - 1];
		for (int i = 1; i < this.mat.length; i++){
			deg [i-1] = mat[i][0];
		}
		return deg;
	}

	public int[] degE() {
		int[] deg = new int[this.mat.length - 1];
		for(int i = 1; i< this.mat.length;i++){
			deg[i-1] = this.mat[0][i];
		}
		return deg;
	}

	/**
	 * Mutateur : Ajout et suppression d'un arc
	 */
	public void ajoutArc(int i, int j) {
		this.mat[i][j] = 1; //Si Multi-graphe : += 1;
		this.mat[i][0] += 1;
		this.mat[0][j] += 1;
	}

	public void enleveArc(int i, int j) {
		this.mat[i][j] = 0; //Si Multi-graphe : -= 1;
		this.mat[i][0] -= 1;
		this.mat[0][j] -= 1;
	}

	// conversion en GrapheList
	/*public GrapheOrienteList toList() {
		
	}*/

}
