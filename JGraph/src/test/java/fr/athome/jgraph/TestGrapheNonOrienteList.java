package fr.athome.jgraph;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.List;

import org.junit.Before;
import org.junit.Test;

public class TestGrapheNonOrienteList {

	GrapheNonOriente g;

	
	@Before
	public void setUp(){
		int[][] listAdj = {{2,3,4},{1,4},{1,4,5},{1,2,3,5},{3,4}};
		this.g = new GrapheNonOrienteList(listAdj);
	}
	
	@Test 
	public void testnbSommet(){
		assertEquals(5, this.g.nbSommets());
	}

	@Test 
	public void testnbArete(){
		assertEquals(7, this.g.nbArete());
	}
	
	@Test
	public void testDegre(){
		assertEquals(3,g.degre(1));
		assertEquals(2,g.degre(2));
		assertEquals(3,g.degre(3));
		assertEquals(4,g.degre(4));
		assertEquals(2,g.degre(5));
	}
	
	@Test
	public void testVectDegre(){
		int[] deg = {0,3,2,3,4,2};
		assertArrayEquals(deg, g.vectDegre());
	}
	
	@Test
	public void testVoisins(){
		List<Integer> voisins = new ArrayList<Integer>();
	}
	
}
