package fr.athome.jgraph;


public class Main {

	public static void main(String[] args) {
		int[][] testGraphe = {{},{5},{1,4},{2},{3},{2,4}};		
		GrapheOrienteMat g = new GrapheOrienteMat(testGraphe);
		g.affiche();
	}

}
