package fr.athome.jgraph;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.List;

import org.junit.Before;
import org.junit.Test;

public class TestGrapheOrienteList {

GrapheOriente g;

	
	@Before
	public void setUp(){
		int[][] listAdj = {{2,3,4},{4},{4,5},{3,5},{}};
		this.g = new GrapheOrienteList(listAdj);
	}
	
	@Test 
	public void testnbSommet(){
		assertEquals(5, this.g.nbSommets());
	}

	@Test 
	public void testnbArc(){
		assertEquals(8, this.g.nbArcs());
	}
	@Test 
	public void testdegresS(){
		assertEquals(3, this.g.degresS(1));
		assertEquals(1, this.g.degresS(2));
		assertEquals(2, this.g.degresS(3));
		assertEquals(2, this.g.degresS(4));
		assertEquals(0, this.g.degresS(5));
	}
	
	@Test 
	public void testdegresE(){
		assertEquals(0,this.g.degresE(1));
		assertEquals(1,this.g.degresE(2));
		assertEquals(2,this.g.degresE(3));
		assertEquals(3,this.g.degresE(4));
		assertEquals(2,this.g.degresE(5));
	}
	@Test 
	public void testdegE(){
		int[] degE = {0,0,1,2,3,2};
		assertArrayEquals(degE, this.g.degE());
	}
	
	@Test 
	public void testdegS(){
		int[] degS = {0,3,1,2,2,0};
		assertArrayEquals(degS, this.g.degS());
	}
	@Test
	public void testSucc(){
		List<Integer> succ = new ArrayList<>();
		succ.add(2);succ.add(3);succ.add(4);
		assertEquals(succ, g.succ(1));
		
		succ.clear();succ.add(4);
		assertEquals(succ, g.succ(2));
		
		succ.clear();succ.add(4);succ.add(5);
		assertEquals(succ, g.succ(3));
		
		succ.clear();succ.add(3);succ.add(5);
		assertEquals(succ, g.succ(4));
		
		succ.clear();
		assertEquals(succ, g.succ(5));
	}
	
	@Test
	public void testPred(){
		List<Integer> pred = new ArrayList<>();
		assertEquals(pred, g.pred(1));
		
		pred.clear();pred.add(1);
		assertEquals(pred, g.pred(2));
		
		pred.clear();pred.add(1);pred.add(4);
		assertEquals(pred, g.pred(3));
		
		pred.clear();pred.add(1);pred.add(2);pred.add(3);
		assertEquals(pred, g.pred(4));
		
		pred.clear();pred.add(3);pred.add(4);
		assertEquals(pred, g.pred(5));
	}
	@Test 
	public void testAjouterArc(){
		g.ajouterArc(2, 5);
		assertEquals(9, this.g.nbArcs());
		assertEquals(2, this.g.degresS(2));
		assertEquals(3,this.g.degresE(5));
		int[] degS = {0,3,2,2,2,0};
		assertArrayEquals(degS, this.g.degS());
		int[] degE = {0,0,1,2,3,3};
		assertArrayEquals(degE, this.g.degE());
		List<Integer> succ2 = new ArrayList<Integer>();
		succ2.add(4);
		succ2.add(5);
		assertEquals(succ2, this.g.succ(2));
	}
	@Test 
	public void testEnleverArc(){
		g.enleverArc(2, 4);
		assertEquals(7, this.g.nbArcs());
		assertEquals(0, this.g.degresS(2));
		assertEquals(2,this.g.degresE(4));
		int[] degS = {0,3,0,2,2,0};
		assertArrayEquals(degS, this.g.degS());
		int[] degE = {0,0,1,2,2,2};
		assertArrayEquals(degE, this.g.degE());
		List<Integer> succ2 = new ArrayList<Integer>();
		assertEquals(succ2, this.g.succ(2));
	}

}
