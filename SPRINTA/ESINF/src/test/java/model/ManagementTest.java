package model;

import fileUtils.Pair;
import fileUtils.StoreData;
import graph.Algorithms;
import graph.Graph;
import graph.map.MapGraph;
import model.business_entities.BusinessEntity;
import model.business_entities.Client;
import model.business_entities.Company;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

import static org.junit.jupiter.api.Assertions.*;

class ManagementTest {

    @Test
    void definingHubsMiniV1() {
        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_mini_v1.csv", coordsMap);
        Graph<BusinessEntity, Integer> graph = StoreData.readGraphData("distancias_mini_v1.csv", map, coordsMap);

        Management.definingHubs(graph, 1);
        BusinessEntity c1 = graph.vertex(5);
        boolean expected1 = ((Company) c1).isHub();
        BusinessEntity c2 = graph.vertex(9);
        boolean expected2 = ((Company) c2).isHub();
        BusinessEntity c3 = graph.vertex(4);
        boolean expected3 = ((Company) c3).isHub();
        assertTrue(expected1);
        assertFalse(expected2);
        assertFalse(expected3);

        Management.definingHubs(graph, 2);
        expected1 = ((Company) c1).isHub();
        expected2 = ((Company) c2).isHub();
        expected3 = ((Company) c3).isHub();
        assertTrue(expected1);
        assertTrue(expected2);
        assertFalse(expected3);

        Management.definingHubs(graph, 3);
        expected1 = ((Company) c1).isHub();
        expected2 = ((Company) c2).isHub();
        expected3 = ((Company) c3).isHub();
        assertTrue(expected1);
        assertTrue(expected2);
        assertTrue(expected3);

    }

    @Test
    void definingHubsMiniV2() {
        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_mini_v2.csv", coordsMap);
        Graph<BusinessEntity, Integer> graph = StoreData.readGraphData("distancias_mini_v2.csv", map, coordsMap);

        Management.definingHubs(graph, 1);

        BusinessEntity c1 = graph.vertex(4);
        boolean expected1 = ((Company) c1).isHub();
        BusinessEntity c2 = graph.vertex(3);
        boolean expected2 = ((Company) c2).isHub();
        BusinessEntity c3 = graph.vertex(6);
        boolean expected3 = ((Company) c3).isHub();
        assertTrue(expected1);
        assertFalse(expected2);
        assertFalse(expected3);

        Management.definingHubs(graph, 2);
        expected1 = ((Company) c1).isHub();
        expected2 = ((Company) c2).isHub();
        expected3 = ((Company) c3).isHub();
        assertTrue(expected1);
        assertFalse(expected2);
        assertTrue(expected3);


        Management.definingHubs(graph, 3);
        expected1 = ((Company) c1).isHub();
        expected2 = ((Company) c2).isHub();
        expected3 = ((Company) c3).isHub();
        assertTrue(expected1);
        assertTrue(expected2);
        assertTrue(expected3);

    }

    @Test
    void definingHubsSmall() {
        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_small.csv", coordsMap);
        Graph<BusinessEntity, Integer> graph = StoreData.readGraphData("distancias_small.csv", map, coordsMap);

        ArrayList<BusinessEntity> vertices = graph.vertices();
        Management.definingHubs(graph, 2);

        BusinessEntity c1 = graph.vertex(12);
        boolean expected1 = ((Company) c1).isHub();
        BusinessEntity c2 = graph.vertex(16);
        boolean expected2 = ((Company) c2).isHub();
        BusinessEntity c3 = graph.vertex(2);
        boolean expected3 = ((Company) c3).isHub();
        BusinessEntity c4 = graph.vertex(5);
        boolean expected4 = ((Company) c4).isHub();
        BusinessEntity c5 = graph.vertex(11);
        boolean expected5 = ((Company) c5).isHub();
        assertTrue(expected1);
        assertTrue(expected2);
        assertFalse(expected3);
        assertFalse(expected4);
        assertFalse(expected5);
    }

    @Test
    void graphIsConnected() {
        //Non connected graph
        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_mini_v1.csv", coordsMap);
        Graph<BusinessEntity, Integer> graph = StoreData.readGraphData("distancias_mini_v1.csv", map, coordsMap);

        boolean expected = Management.graphIsConnected(graph);

        assertFalse(expected);

        //Connected graph
        TreeMap<String, Pair<Float, Float>> coordsMap2 = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map2 = StoreData.readLocations("clientes-produtores_mini_v2.csv", coordsMap2);
        Graph<BusinessEntity, Integer> graph2 = StoreData.readGraphData("distancias_mini_v2.csv", map2, coordsMap2);

        boolean expected2 = Management.graphIsConnected(graph2);

        assertTrue(expected2);
    }

    @Test
    void networkThatConnectsAll() {
        //Non connected graph
        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_mini_v1.csv", coordsMap);
        Graph<BusinessEntity, Integer> graph = StoreData.readGraphData("distancias_mini_v1.csv", map, coordsMap);

        Graph<BusinessEntity, Integer> expected = Management.networkThatConnectsAll(graph);

        assertNull(expected);


        //Connected graph mini file
        TreeMap<String, Pair<Float, Float>> coordsMap2 = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map2 = StoreData.readLocations("clientes-produtores_mini_v2.csv", coordsMap2);
        Graph<BusinessEntity, Integer> graph2 = StoreData.readGraphData("distancias_mini_v2.csv", map2, coordsMap2);

        TreeMap<String, Pair<Float, Float>> coordsMap3 = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map3 = StoreData.readLocations("clientes-produtores_mini_v2.csv", coordsMap3);
        Graph<BusinessEntity, Integer> expected2 = StoreData.readGraphData("distancias_mini_v2_mst.csv", map3, coordsMap3);

        Graph<BusinessEntity, Integer> real2 = Management.networkThatConnectsAll(graph2);

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

        Graph<BusinessEntity, Integer> real5 = Management.networkThatConnectsAll(graph4);

        MapGraph<BusinessEntity, Integer> e5 = (MapGraph<BusinessEntity, Integer>) expected5;
        MapGraph<BusinessEntity, Integer> r5 = (MapGraph<BusinessEntity, Integer>) real5;

        assertTrue(e5.equals(r5));


        //Big File
        TreeMap<String, Pair<Float, Float>> coordsMapBig = new TreeMap<>();
        TreeMap<Location, BusinessEntity> mapBig = StoreData.readLocations("clientes-produtores_big.csv", coordsMapBig);
        Graph<BusinessEntity, Integer> graphBig = StoreData.readGraphData("distancias_big.csv", mapBig, coordsMapBig);
        Graph<BusinessEntity, Integer> bigMST = Management.networkThatConnectsAll(graphBig);

        //Both graphs must have the same number of vertices
        assertEquals(bigMST.vertices().size(), graphBig.vertices().size());
        //The mst graph must have the number of vertices - 1 has the total number of edges
        //(the number of edges is divided by 2 because the graph is non directed, so it returns the double of edges)
        assertEquals(bigMST.vertices().size() - 1, bigMST.edges().size() / 2);
    }

    @Test
    void closestHub() {
        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_mini_v2.csv", coordsMap);
        Graph<BusinessEntity, Integer> graph = StoreData.readGraphData("distancias_mini_v2.csv", map, coordsMap);

        Management.definingHubs(graph, 1);

        BusinessEntity c1 = graph.vertex(4);


        Client client = new Client(new Location("CT1", 40.6389f, -8.6553f), "C1");

        Management.closestHub(graph, client);
        assertEquals(c1, Management.closestHub(graph, client));

    }

    @Test
    void closestClientsHubsMini() {
        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_small.csv", coordsMap);
        Graph<BusinessEntity, Integer> graph = StoreData.readGraphData("distancias_small.csv", map, coordsMap);

        Management.definingHubs(graph, 1);

        BusinessEntity c1 = graph.vertex(4);

        Map<Client, Company> ret = Management.closestClientsHubs(graph);

        Client client1 = new Client(new Location("CT1", 40.6389f, -8.6553f), "C1");
        Client client2 = new Client(new Location("CT5", 39.823f, -7.4931f), "E3");
        Client client3 = new Client(new Location("CT9", 40.5364f, -7.2683f), "E4");
        Client client4 = new Client(new Location("CT3", 41.5333f, -8.4167f), "C3");
        Client client5 = new Client(new Location("CT4", 41.8f, -6.75f), "E5");

       assertTrue(ret.containsKey(client1));
       assertTrue(ret.containsKey(client2));
       assertTrue(ret.containsKey(client3));
       assertTrue(ret.containsKey(client4));
       assertTrue(ret.containsKey(client5));


    }


    @Test
    void closestClientsHubsSmall() {
        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_small.csv", coordsMap);
        Graph<BusinessEntity, Integer> graph = StoreData.readGraphData("distancias_small.csv", map, coordsMap);

        ArrayList<BusinessEntity> vertices = graph.vertices();
        Management.definingHubs(graph, 2);

        Map<Client, Company> ret = Management.closestClientsHubs(graph);

        Client client1 = new Client(new Location("CT1", 40.6389f, -8.6553f), "C1");
        Client client2 = new Client(new Location("CT5", 39.823f, -7.4931f), "E3");
        Client client3 = new Client(new Location("CT9", 40.5364f, -7.2683f), "E4");
        Client client4 = new Client(new Location("CT3", 41.5333f, -8.4167f), "C3");
        Client client5 = new Client(new Location("CT4", 41.8f, -6.75f), "E5");

        assertTrue(ret.containsKey(client1));
        assertTrue(ret.containsKey(client2));
        assertTrue(ret.containsKey(client3));
        assertTrue(ret.containsKey(client4));
        assertTrue(ret.containsKey(client5));


    }

}

