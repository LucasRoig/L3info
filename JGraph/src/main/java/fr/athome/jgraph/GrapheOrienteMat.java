package fr.athome.jgraph;

import java.util.ArrayList;
import java.util.List;

public class GrapheOrienteMat implements GrapheOriente{
	int[][] matrice;
	int nbSommets = 0;
	int nbArcs = 0;
	int[] degS;
	int[] degE;
	
	//construit un graphe ayant n sommets;
	public GrapheOrienteMat(int i) {
		this.matrice = new int[i][i];
		this.nbSommets = 0;
		degE = new int[i+1];
		degS = new int[i+1];
	}
	
	public GrapheOrienteMat(int[][] listeAdj) {
		this.nbSommets = listeAdj.length;
		degE = new int[nbSommets + 1];
		degS = new int[nbSommets + 1];
		this.matrice = new int[nbSommets][nbSommets];
		for(int i = 0; i < listeAdj.length; i++){
			for(int j = 0; j < listeAdj[i].length; j++){
				int k = listeAdj[i][j];
				this.matrice[i][k-1] = 1; 
				this.degE[k] += 1;
				this.degS[i+1] += 1;
				this.nbArcs += 1;
			}
		}
	}
	@Override
	public int nbSommets() {
		return nbSommets;
	}
	@Override
	public int nbArcs() {
		return nbArcs;
	}
	@Override
	public void ajouterArc(int i, int j) {
		if(this.matrice[i-1][j-1] == 0){
			this.matrice[i-1][j-1] = 1;
			this.nbArcs += 1;
			this.degE[j] += 1;
			this.degS[i] += 1;
		}
	}
	@Override
	public void enleverArc(int i, int j) {
		if(this.matrice[i-1][j-1] == 1){
			this.matrice[i-1][j-1] = 0;
			this.nbArcs -= 1;
			this.degE[j] -= 1;
			this.degS[i] -= 1;
		}
		
	}
	@Override
	public int degresS(int i) {
		return this.degS[i];
	}
	@Override
	public int degresE(int i) {
		return this.degE[i];
	}
	@Override
	public int[] degE() {
		return this.degE;
	}
	@Override
	public int[] degS() {
		return this.degS;
	}
	@Override
	public List<Integer> succ(int i) {
		List<Integer> succ = new ArrayList<>();
		for (int j = 0; j < this.nbSommets;j++){
			if(this.matrice[i-1][j] == 1){
				succ.add(j+1);
			}
		}
		return succ;
	}
	@Override
	public List<Integer> pred(int i) {
		List<Integer> pred = new ArrayList<>();
		for(int j = 0; j < this.nbSommets; j++){
			if(this.matrice[j][i-1] == 1){
				pred.add(j+1);
			}
		}
		return pred;
	}
	@Override
	public void affiche() {
		// TODO Auto-generated method stub
		
	}
	
	
	
}
