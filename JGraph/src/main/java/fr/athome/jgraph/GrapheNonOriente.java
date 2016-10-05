package fr.athome.jgraph;

import java.util.List;

public interface GrapheNonOriente {
	public int nbSommets();
	public int nbArete();
	public void ajouterArete(int i, int j);
	public void enleverArete(int i, int j);
	public int degre(int i);
	public int[] vectDegre();
	public List<Integer> voisin(int i);
}
