package fr.athome.jgraph;


import java.util.Collections;
import java.util.ArrayList;

/**
 * On redéfinit une classe liste à partir de la classe ArrayList existante pour
 * renommer nos primitives
 */
public class Liste {

	private ArrayList<Integer> L;

	/**
	 * Constructeur par d�faut � la liste vide
	 */
	public Liste() {
		L = new ArrayList<Integer>();
	}

	/**
	 * Constructeur � partir d'un tableau
	 */
	public Liste(int[] T) {
		L = new ArrayList<Integer>();
		for (int i = 0; i < T.length; i++) {
			L.add(T[i]);
		}
	}

	/**
	 * M�thodes
	 */
	public int taille() {
		return L.size();
	}

	public int tete() {
		return L.get(0);
	}

	public void ajoutFin(int a) {
		L.add(a);
	}

	public void ajoutTete(int a) {
		L.add(0, a);
	}

	public void reste(int a) {
		L.remove(0);
	}

	// L.concate(l2) concatene l2 à la liste L
	public void concate(Liste l2) {
		L.addAll(L.size(), l2.L);
	}

	public int elt(int i) {
		return L.get(i);
	}

	/**
	 * Indice de la premiere occurrence de a, -1 si a n'est pas dans la liste
	 * @param a - Element dont on cherche l'emplacement
	 * @return l'Indice de la première occurrence de a, -1 si a n'est pas dans la liste
	 */
	public int indice(int a) {
		return L.indexOf(a);
	}

	public boolean vide() {
		return L.isEmpty();
	}

	// Enleve l'�l�ment d'indice i
	public void enleveInd(int i) {
		L.remove(i);
	}

	// Enleve l'�l�ment i
	public void enleveElt(int i) {
		L.remove(this.indice(i));
	}

	// tri croissant
	public void tri() {
		Collections.sort(L);
	}

	public void affiche() {
		if (this.vide()) {
			System.out.print("[ ] ");
		} else {
			System.out.print("[" + L.get(0));
			for (int i = 1; i < L.size(); i++) {
				System.out.print(", " + L.get(i));
			}
			System.out.print("]");
		}

	}

}
