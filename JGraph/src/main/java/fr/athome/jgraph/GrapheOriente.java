package fr.athome.jgraph;

import java.util.List;

public interface GrapheOriente {
	public int nbSommets();
	public int nbArcs();
	public void ajouterArc(int i, int j);
	public void enleverArc(int i, int j);
	public int degresS(int i);
	public int degresE(int i);
	public int[] degE();
	public int[] degS();
	public List<Integer> succ(int i);
	public List<Integer> pred(int i);
	public void affiche();
}
