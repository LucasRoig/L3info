package fr.athome.jgraph;

import java.util.ArrayList;
import java.util.List;

public class GrapheOrienteList implements GrapheOriente{
	private int nbSommets = 0;
	private int nbArcs = 0;
	private List<List<Integer>> adjList = new ArrayList<List<Integer>>(); 
	private int[] degE;
	private int[] degS;

	public GrapheOrienteList(int i) {
		degE = new int[i+1];
		degS = new int[i+1];
		this.nbSommets = i;
		for (int j = 0; j < i; j++){
			adjList.add(new ArrayList<Integer>());
		}
	}
	
	public GrapheOrienteList(int[][] listAdj) {
		this.nbSommets = listAdj.length;
		degE = new int[this.nbSommets+1];
		degS = new int[this.nbSommets+1];
		for (int i = 0; i<this.nbSommets; i++){
			this.adjList.add(new ArrayList<Integer>());
			for (int j = 0; j < listAdj[i].length; j++){
				int k = listAdj[i][j];
				this.adjList.get(i).add(k);
				this.degS[i+1] += 1;
				this.degE[k] += 1;
				this.nbArcs += 1;
			}
		}
	}
	@Override
	public int nbSommets() {
		return this.nbSommets;
	}

	@Override
	public int nbArcs() {
		return this.nbArcs;
	}

	@Override
	public void ajouterArc(int i, int j) {
		if(!this.adjList.get(i-1).contains(j)){
			this.adjList.get(i-1).add(j);
			this.nbArcs += 1;
			this.degE[j] += 1;
			this.degS[i] += 1;
		}
	}

	@Override
	public void enleverArc(int i, int j) {
		if(this.adjList.get(i-1).contains(j)){
			this.adjList.get(i-1).removeIf(k -> k==j);
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
		return this.adjList.get(i-1);
	}

	@Override
	public List<Integer> pred(int i) {
		List<Integer> pred = new ArrayList<>();
		for (int j = 0; j < this.adjList.size();j++){
			if(this.adjList.get(j).contains(i)) 
				pred.add(j+1);
		}
		return pred;
	}

	@Override
	public void affiche() {
		// TODO Auto-generated method stub
		
	}

}
