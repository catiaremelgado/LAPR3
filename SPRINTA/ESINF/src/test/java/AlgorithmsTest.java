import fileUtils.Pair;
import fileUtils.StoreData;
import graph.Algorithms;
import graph.Edge;
import graph.Graph;
import graph.map.MapGraph;
import model.Location;
import model.business_entities.BusinessEntity;
import org.junit.jupiter.api.Test;

import java.util.*;

import static org.junit.jupiter.api.Assertions.*;

class AlgorithmsTest {

    @Test
    void isConnected() {
        //Non connected graph
        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_mini_v1.csv", coordsMap);
        Graph<BusinessEntity, Integer> graph = StoreData.readGraphData("distancias_mini_v1.csv", map, coordsMap);

        boolean expected = Algorithms.isConnected(graph);

        assertFalse(expected);

        //Connected graph
        TreeMap<String, Pair<Float, Float>> coordsMap2 = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map2 = StoreData.readLocations("clientes-produtores_mini_v2.csv", coordsMap2);
        Graph<BusinessEntity, Integer> graph2 = StoreData.readGraphData("distancias_mini_v2.csv", map2, coordsMap2);

        boolean expected2 = Algorithms.isConnected(graph2);

        assertTrue(expected2);
    }

    @Test
    void kruskalAlgorithm() {
        //Non connected graph
        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_mini_v1.csv", coordsMap);
        Graph<BusinessEntity, Integer> graph = StoreData.readGraphData("distancias_mini_v1.csv", map, coordsMap);

        Graph<BusinessEntity, Integer> expected = Algorithms.kruskalAlgorithm(graph);

        assertNull(expected);


        //Connected graph mini file
        TreeMap<String, Pair<Float, Float>> coordsMap2 = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map2 = StoreData.readLocations("clientes-produtores_mini_v2.csv", coordsMap2);
        Graph<BusinessEntity, Integer> graph2 = StoreData.readGraphData("distancias_mini_v2.csv", map2, coordsMap2);

        TreeMap<String, Pair<Float, Float>> coordsMap3 = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map3 = StoreData.readLocations("clientes-produtores_mini_v2.csv", coordsMap3);
        Graph<BusinessEntity, Integer> expected2 = StoreData.readGraphData("distancias_mini_v2_mst.csv", map3, coordsMap3);

        Graph<BusinessEntity, Integer> real2 = Algorithms.kruskalAlgorithm(graph2);

        MapGraph<BusinessEntity, Integer> e2 = (MapGraph<BusinessEntity, Integer>) expected2;
        MapGraph<BusinessEntity, Integer> r2 = (MapGraph<BusinessEntity, Integer>) real2;

        assertTrue(e2.equals(r2));


        //Connected graph small file
        TreeMap<String, Pair<Float, Float>> coordsMap4 = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map4 = StoreData.readLocations("clientes-produtores_small.csv", coordsMap4);
        Graph<BusinessEntity, Integer> graph4 = StoreData.readGraphData("distancias_small.csv", map4, coordsMap4);

        TreeMap<String, Pair<Float, Float>> coordsMap5 = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map5 = StoreData.readLocations("clientes-produtores_small.csv", coordsMap5);
        Graph<BusinessEntity, Integer> expected5 = StoreData.readGraphData("distancias_small_mst.csv", map5, coordsMap5);

        Graph<BusinessEntity, Integer> real5 = Algorithms.kruskalAlgorithm(graph4);

        MapGraph<BusinessEntity, Integer> e5 = (MapGraph<BusinessEntity, Integer>) expected5;
        MapGraph<BusinessEntity, Integer> r5 = (MapGraph<BusinessEntity, Integer>) real5;

        assertTrue(e5.equals(r5));


        //Big File
        TreeMap<String, Pair<Float, Float>> coordsMapBig = new TreeMap<>();
        TreeMap<Location, BusinessEntity> mapBig = StoreData.readLocations("clientes-produtores_big.csv", coordsMapBig);
        Graph<BusinessEntity, Integer> graphBig = StoreData.readGraphData("distancias_big.csv", mapBig, coordsMapBig);
        Graph<BusinessEntity, Integer> bigMST = Algorithms.kruskalAlgorithm(graphBig);

        //Both graphs must have the same number of vertices
        assertEquals(bigMST.vertices().size(), graphBig.vertices().size());
        //The mst graph must have the number of vertices - 1 has the total number of edges
        //(the number of edges is divided by 2 because the graph is non directed, so it returns the double of edges)
        assertEquals(bigMST.vertices().size()-1,bigMST.edges().size()/2);
    }


    @Test
    void kruskalAlgorithmSimple() {

        //not connected graph
        MapGraph<String, Integer> myGraphNo = new MapGraph<>(false);
        myGraphNo.addVertex("A");
        myGraphNo.addVertex("B");
        myGraphNo.addVertex("C");
        myGraphNo.addVertex("D");
        myGraphNo.addVertex("E");
        myGraphNo.addVertex("F");
        myGraphNo.addVertex("G");
        myGraphNo.addVertex("H");

        myGraphNo.addEdge("A", "C", 56717);
        myGraphNo.addEdge("C", "D", 100563);
        myGraphNo.addEdge("B", "C", 67584);
        myGraphNo.addEdge("D", "E", 90186);
        myGraphNo.addEdge("E", "F", 162527);
        myGraphNo.addEdge("F", "G", 157223);
        myGraphNo.addEdge("A", "B", 110848);
        myGraphNo.addEdge("B", "D", 125041);

        assertNull(Algorithms.kruskalAlgorithm(myGraphNo));

        //Connected graph
        MapGraph<String, Integer> myGraph = new MapGraph<>(false);
        myGraph.addVertex("A");
        myGraph.addVertex("B");
        myGraph.addVertex("C");
        myGraph.addVertex("D");
        myGraph.addVertex("E");
        myGraph.addVertex("F");
        myGraph.addVertex("G");


        myGraph.addEdge("A", "C", 56717);
        myGraph.addEdge("C", "D", 100563);
        myGraph.addEdge("B", "C", 67584);
        myGraph.addEdge("D", "E", 90186);
        myGraph.addEdge("E", "F", 162527);
        myGraph.addEdge("F", "G", 157223);

        MapGraph<String, Integer> expectedGraphMST = myGraph.clone();

        myGraph.addEdge("A", "B", 110848);
        myGraph.addEdge("B", "D", 125041);

        Graph<String, Integer> ralGraphMST = Algorithms.kruskalAlgorithm(myGraph);
        MapGraph<String, Integer> realMST = (MapGraph<String, Integer>) ralGraphMST;

        //when it's cloned from the original
        assertTrue(expectedGraphMST.equals(realMST));

        MapGraph<String, Integer> expectedGraphMST2 = new MapGraph<>(false);

        expectedGraphMST2.addVertex("A");
        expectedGraphMST2.addVertex("B");
        expectedGraphMST2.addVertex("C");
        expectedGraphMST2.addVertex("D");
        expectedGraphMST2.addVertex("E");
        expectedGraphMST2.addVertex("F");
        expectedGraphMST2.addVertex("G");

        expectedGraphMST2.addEdge("A", "C", 56717);
        expectedGraphMST2.addEdge("C", "D", 100563);
        expectedGraphMST2.addEdge("B", "C", 67584);
        expectedGraphMST2.addEdge("D", "E", 90186);
        expectedGraphMST2.addEdge("E", "F", 162527);
        expectedGraphMST2.addEdge("F", "G", 157223);


        MapGraph<String, Integer> myGraph2 = new MapGraph<>(false);
        myGraph2.addVertex("A");
        myGraph2.addVertex("B");
        myGraph2.addVertex("C");
        myGraph2.addVertex("D");
        myGraph2.addVertex("E");
        myGraph2.addVertex("F");
        myGraph2.addVertex("G");


        myGraph2.addEdge("A", "C", 56717);
        myGraph2.addEdge("C", "D", 100563);
        myGraph2.addEdge("B", "C", 67584);
        myGraph2.addEdge("A", "B", 110848);
        myGraph2.addEdge("B", "D", 125041);
        myGraph2.addEdge("D", "E", 90186);
        myGraph2.addEdge("E", "F", 162527);
        myGraph2.addEdge("F", "G", 157223);

        Graph<String, Integer> ralGraphMST2 = Algorithms.kruskalAlgorithm(myGraph2);
        MapGraph<String, Integer> realMST2 = (MapGraph<String, Integer>) ralGraphMST2;

        //not cloned from the original
        assertTrue(expectedGraphMST2.equals(realMST2));
    }

    @Test
    void Sort() {
        MapGraph<String, Integer> myGraph2 = new MapGraph<>(false);
        myGraph2.addVertex("A");
        myGraph2.addVertex("B");
        myGraph2.addVertex("C");
        myGraph2.addVertex("D");
        myGraph2.addVertex("E");
        myGraph2.addVertex("F");
        myGraph2.addVertex("G");


        myGraph2.addEdge("A", "C", 56717);
        myGraph2.addEdge("C", "D", 100563);
        myGraph2.addEdge("B", "C", 67584);
        myGraph2.addEdge("A", "B", 110848);
        myGraph2.addEdge("B", "D", 125041);
        myGraph2.addEdge("D", "E", 90186);
        myGraph2.addEdge("E", "F", 162527);
        myGraph2.addEdge("F", "G", 157223);

        List<Edge<String, Integer>> allEdgesNonSorted = (List<Edge<String, Integer>>) myGraph2.edges();

        Collections.sort(allEdgesNonSorted, new Edge.weightComparator());

        String sorted = "";

        for (Edge e: allEdgesNonSorted) {
            sorted = sorted+String.valueOf(e.getWeight())+" ";
        }

        String expected = "56717 56717 67584 67584 90186 90186 100563 100563 110848 110848 125041 125041 157223 157223 162527 162527";

        assertTrue(expected.trim().equals(sorted.trim()));
    }
}