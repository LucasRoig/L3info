package fr.athome.jgraph;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;


public class GrapheOrienteListTest {
	int[][] testGraphe = {{5},{1,4},{2},{3},{2,4}};
	GrapheOrienteList g;
	
	@Before
	public void setUp(){
		g = new GrapheOrienteList(testGraphe);
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
	public void testDegreE(){
		assertEquals(1, g.degreE(1));
		assertEquals(2,g.degreE(4));
	}

	@Test
	public void testDegreS() {
		assertEquals(1,g.degreS(1));
		assertEquals(2,g.degreS(5));
	}

	@Test
	public void testDegS() {
		int[] r = {0,1,2,1,1,2};
		assertArrayEquals(r, g.degS());
	}

	@Test
	public void testDegE() {
		int[] r = {0,1,2,1,2,1};
		assertArrayEquals(r, g.degE());
	}

	@Test
	public void testToMat() {
		fail("Not yet implemented");
	}

}
