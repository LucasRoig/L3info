package fr.athome.jgraph;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

public class GrapheOrienteMatTest {
	int[][] testGraphe = {{5},{1,4},{2},{3},{2,4}};
	GrapheOrienteMat g;
	
	@Before
	public void setUp(){
		g = new GrapheOrienteMat(testGraphe);
	}
	
	@Test
	public void testNbSommets() {
		assertEquals(5,g.nbSommets());
	}

	@Test
	public void testNbArcs() {
		assertEquals(7,g.nbArcs());
	}

	@Test
	public void testDegreS() {
		assertEquals(1,g.degreS(1));
		assertEquals(2,g.degreS(5));
	}

	@Test
	public void testDegreE() {
		assertEquals(2,g.degreE(4));
		assertEquals(1,g.degreE(1));
	}

	@Test
	public void testDegS() {
		int[] r = {1,2,1,1,2};
		assertArrayEquals(r, g.degS());
	}

	@Test
	public void testDegE() {
		int[] r = {1,2,1,2,1};
		assertArrayEquals(r, g.degE());
	}

	@Test
	public void testAjoutArc() {
		g.ajoutArc(4, 5);
		assertEquals(2, g.degreS(4));
		assertEquals(2,g.degreE(5));
	}

	@Test
	public void testEnleveArc() {
		g.enleveArc(5, 4);
		assertEquals(1,g.degreE(4));
		assertEquals(1,g.degreS(5));
	}

	@Test
	public void testToList() {
		fail("Not yet implemented");
	}

}
