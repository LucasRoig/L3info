package fr.athome.jgraph;

import java.util.List;

public class GrapheNonOrienteMat implements GrapheNonOriente{
	public GrapheOriente g;
	
	public GrapheNonOrienteMat(int n) {
		g = new GrapheOrienteMat(n);
	}
	
	public GrapheNonOrienteMat(int[][] listSucc) {
		g = new GrapheOrienteMat(listSucc.length);
		for (int i = 0;i<listSucc.length;i++){
			for (int j : listSucc[i]){
				g.ajouterArc(i+1, j);
			}
		}
	}
	
	@Override
	public int nbSommets() {
		return g.nbSommets();
	}

	@Override
	public int nbArete() {
		return g.nbArcs()/2;
	}

	@Override
	public void ajouterArete(int i, int j) {
		g.ajouterArc(i, j);
		g.ajouterArc(j, i);
		
	}

	@Override
	public void enleverArete(int i, int j) {
		g.enleverArc(i, j);
		g.enleverArc(j, i);
		
	}

	@Override
	public int degre(int i) {
		return g.degresS(i);
	}

	@Override
	public int[] vectDegre() {
		return g.degS();
	}

	@Override
	public List<Integer> voisin(int i) {
		return g.succ(i);
 	}
	
}
