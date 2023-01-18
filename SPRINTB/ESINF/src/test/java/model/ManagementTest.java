package model;

import fileUtils.Pair;
import fileUtils.StoreData;
import graph.Algorithms;
import graph.Graph;
import graph.map.MapGraph;
import model.business_entities.BusinessEntity;
import model.business_entities.Client;
import model.business_entities.Company;
import model.business_entities.Supplier;
import org.junit.jupiter.api.Test;

import java.util.*;

import static model.Management.generateExpeditionList;
import static org.junit.jupiter.api.Assertions.*;

class ManagementTest {

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

        Management.definingHubs(graph, 8);

        BusinessEntity c1 = graph.vertex(4);


        Client client = new Client(new Location("CT1", 40.6389f, -8.6553f), "C1");

        Management.closestHub(graph, client);
        assertEquals(c1.getEntityID(), Management.closestHub(graph, client).getEntityID());

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

    @Test
    void getExpeditionList() {
        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_mini_v2.csv", coordsMap);
        Graph<BusinessEntity, Integer> graph = StoreData.readGraphData("distancias_mini_v3.csv", map, coordsMap);

        // this graph has 3 companies
        Management.definingHubs(graph, 3);

        ArrayList<BusinessEntity> hubs = graph.vertices();
        ArrayList<Company> hybies = new ArrayList<>();

        // Cria o grafo com os hubs e clientes
        HashMap<Integer, List<Bundle>> bundles = new HashMap<>();

        // DailyStock by Supplier
        HashMap<Integer, List<DailyStock>> dailyStocks = new HashMap<>();

        // Cria a lista de pedidos do cliente
        HashMap<Integer, List<Bundle>> clientsOrders = new HashMap<>();

        String filename = "cabazes_small.csv";
        StoreData.readListBundles(filename,clientsOrders,dailyStocks);

        ArrayList<Bundle> bundles2 = generateExpeditionList(1,clientsOrders,dailyStocks,graph);
        assertEquals(bundles2.get(0).getExpeditionDate(),1);
        assertEquals(bundles2.get(0).getHub().getEntityID().equals("E5"),true);
        assertEquals(bundles2.size(),12);

        assertEquals(bundles2.get(9).getExpeditionDate(),1);
        assertEquals(bundles2.get(9).getHub().getEntityID().equals("E4"),true);

        assertEquals(bundles2.get(10).getExpeditionDate(),1);
        assertEquals(bundles2.get(10).getHub().getEntityID().equals("E4"),true);

        assertEquals(bundles2.get(11).getExpeditionDate(),1);
        assertEquals(bundles2.get(11).getHub().getEntityID().equals("E3"),true);
    }

    @Test
    void findingSuppliersCloseToHubMini() {
        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_mini_v2.csv", coordsMap);
        Graph<BusinessEntity, Integer> graph = StoreData.readGraphData("distancias_mini_v3.csv", map, coordsMap);

        // this graph has 3 companies
        Management.definingHubs(graph, 3);

        ArrayList<BusinessEntity> hubs = graph.vertices();
        ArrayList<Company> hybies = new ArrayList<>();

        // remove all non Suppliers from list
        int i = 0;
        while (i < hubs.size()) {
            if ((hubs.get(i) instanceof Company)) {
                Company myHub = (Company) hubs.get(i);
                if (myHub.isHub()) {
                    hybies.add(myHub);
                }
            }
            i++;
        }

        assertEquals(3, hybies.size());

        /*
        System.out.println(hubs.get(0).getEntityID());
        System.out.println(hubs.get(1).getEntityID());
        System.out.println(hubs.get(2).getEntityID());

        The order is: E5, E3 and E4
         */

        ArrayList<Supplier> closestToE5 = Management.findingSuppliersCloseToHub(graph, hybies.get(0), 2);
        ArrayList<Supplier> closestToE3 = Management.findingSuppliersCloseToHub(graph, hybies.get(1), 2);
        ArrayList<Supplier> closestToE4 = Management.findingSuppliersCloseToHub(graph, hybies.get(2), 2);

        /*
        For E5 is expected P3 (CT10) and P2 (CT6)
        For E3 is expected P2 and P3
        For E4 is expected P3 and P2
         */

        assertEquals("P3", closestToE5.get(0).getEntityID());
        assertEquals("P2", closestToE5.get(1).getEntityID());
        assertEquals("P2", closestToE3.get(0).getEntityID());
        assertEquals("P3", closestToE3.get(1).getEntityID());
        assertEquals("P3", closestToE4.get(0).getEntityID());
        assertEquals("P2", closestToE4.get(1).getEntityID());

        // If asked more suppliers than existent:
        ArrayList<Supplier> closestToE5Exceded = Management.findingSuppliersCloseToHub(graph, hybies.get(0), 4);

        assertEquals(2, closestToE5Exceded.size());

        TreeMap<String, Pair<Float, Float>> coordsMap2 = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map2 = StoreData.readLocations("clientes-produtores_mini_v3.csv", coordsMap2);
        Graph<BusinessEntity, Integer> graph2 = StoreData.readGraphData("distancias_mini_v3.csv", map2, coordsMap2);

        Management.definingHubs(graph2, 5);
        ArrayList<BusinessEntity> hubs2 = graph2.vertices();
        i = 0;

        hybies.removeAll(hybies);
        while (i < hubs2.size()) {
            if ((hubs2.get(i) instanceof Company)) {
                Company myHub = (Company) hubs2.get(i);
                if (myHub.isHub()) {
                    hybies.add(myHub);
                }
            }
            i++;
        }
            assertEquals(5, hybies.size());

            assertNull(Management.findingSuppliersCloseToHub(graph2, hybies.get(0), 1));
            assertNull(Management.findingSuppliersCloseToHub(graph2, hybies.get(1), 20));
            assertNull(Management.findingSuppliersCloseToHub(graph2, hybies.get(2), 7));
            assertNull(Management.findingSuppliersCloseToHub(graph2, hybies.get(3), 3));
            assertNull(Management.findingSuppliersCloseToHub(graph2, hybies.get(4), 200));
    }

    @Test
    void shortestPathPossibleTestMiniv2() {
        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_mini_v2.csv", coordsMap);
        Graph<BusinessEntity, Integer> g = StoreData.readGraphData("distancias_mini_v2.csv", map, coordsMap);
        ArrayList<BusinessEntity> vertices = g.vertices();

        ArrayList<Integer> dist = new ArrayList<>();
        ArrayList<LinkedList<BusinessEntity>> path = new ArrayList<>();
        ArrayList<BusinessEntity> mustPass = new ArrayList<>();

        mustPass.add(vertices.get(1)); //P3
        mustPass.add(vertices.get(5)); //P2
        Management.shortestPathPossible(g, mustPass, path, dist);


        ArrayList<Integer> distExpected = new ArrayList<>();
        distExpected.add(67584);
        LinkedList<BusinessEntity> pat = new LinkedList<>();
        pat.add(0, vertices.get(1));
        pat.add(1, vertices.get(5));
        ArrayList<LinkedList<BusinessEntity>> pathExpected = new ArrayList<>();
        pathExpected.add(pat);

        assertEquals(pathExpected, path);
        assertEquals(distExpected, dist);
    }

    @Test
    void shortestPathPossibleTestSmall() {
        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_small.csv", coordsMap);
        Graph<BusinessEntity, Integer> g = StoreData.readGraphData("distancias_small.csv", map, coordsMap);
        ArrayList<BusinessEntity> vertices = g.vertices();

        ArrayList<Integer> dist = new ArrayList<>();
        ArrayList<LinkedList<BusinessEntity>> path = new ArrayList<>();
        ArrayList<BusinessEntity> mustPass = new ArrayList<>();

        mustPass.add(vertices.get(1)); //P3
        mustPass.add(vertices.get(8)); //P1
        mustPass.add(vertices.get(13)); //P2
        Management.shortestPathPossible(g, mustPass, path, dist);


        ArrayList<Integer> distExpected = new ArrayList<>(); //141412 = 67584+73828
        distExpected.add(0, 67584);
        distExpected.add(1, 73828);
        LinkedList<BusinessEntity> pat1 = new LinkedList<>();
        pat1.add(0, vertices.get(1));
        pat1.add(1, vertices.get(13));
        LinkedList<BusinessEntity> pat2 = new LinkedList<>();
        pat2.add(0, vertices.get(13));
        pat2.add(1, vertices.get(8));
        ArrayList<LinkedList<BusinessEntity>> pathExpected = new ArrayList<>(); //P3 P2 P1
        pathExpected.add(pat1);
        pathExpected.add(pat2);

        assertEquals(pathExpected, path);
        assertEquals(distExpected, dist);
    }

    @Test
    void shortestPathPossibleTestMiniv2Error() {
        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_mini_v2.csv", coordsMap);
        Graph<BusinessEntity, Integer> g = StoreData.readGraphData("distancias_mini_v2.csv", map, coordsMap);

        ArrayList<Integer> dist = new ArrayList<>();
        ArrayList<LinkedList<BusinessEntity>> path = new ArrayList<>();
        ArrayList<BusinessEntity> mustPass = new ArrayList<>();

        boolean result = Management.shortestPathPossible(g, mustPass, path, dist);

        assertFalse(result);
    }

    @Test
    void definitionDailyRoutTestMiniV2() {
        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_mini_v2.csv", coordsMap);
        Graph<BusinessEntity, Integer> g = StoreData.readGraphData("distancias_mini_v3.csv", map, coordsMap);
        ArrayList<BusinessEntity> vertices = g.vertices();

        Management.definingHubs(g, 5);

        HashMap<Integer, List<Bundle>> bundles = new HashMap<>();
        HashMap<Integer, List<DailyStock>> dailyStocks = new HashMap<>();

        LinkedList<BusinessEntity> pathExpected = new LinkedList<>();
        ArrayList<Integer> distExpected = new ArrayList<>();
        Integer totalDistanceExpected;
        ArrayList<Pair<BusinessEntity, Integer>> hubDeliveriesExpected = new ArrayList<>();

        pathExpected.add(vertices.get(1)); //P3
        pathExpected.add(vertices.get(5)); //P2
        pathExpected.add(vertices.get(1)); //P3
        pathExpected.add(vertices.get(3)); //E5
        distExpected.add(67584);
        distExpected.add(67584);
        distExpected.add(1);
        totalDistanceExpected = 135169;
        hubDeliveriesExpected.add(new Pair<>(vertices.get(3), 1));
        DeliveryRoute expectedResult = new DeliveryRoute(pathExpected,distExpected,totalDistanceExpected, hubDeliveriesExpected);

        String filename = "cabazes_too_mini.csv";
        StoreData.readListBundles(filename,bundles,dailyStocks);
        HashMap<Integer, List<DailyStock>> originaldailyStocks = new HashMap<>();
        StoreData.readListBundles(filename,bundles,originaldailyStocks);
        List<Bundle> dBundles = Management.expeditionListWithRestrictions(bundles, dailyStocks, g, 1, 3);

        DeliveryRoute result = Management.definitionDailyRout(g, dBundles);

        assertEquals(expectedResult.getPath(), result.getPath());
        assertEquals(expectedResult.getDist(), result.getDist());
        assertEquals(expectedResult.getTotalDistance(), result.getTotalDistance());
        assertEquals(expectedResult.getHubDeliveries().get(0).getLeft(), result.getHubDeliveries().get(0).getLeft());
        assertEquals(expectedResult.getHubDeliveries().get(0).getRight(), result.getHubDeliveries().get(0).getRight());
    }

    @Test
    void definitionDailyRoutTestMiniV2WithNoStock() {
        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_mini_v2.csv", coordsMap);
        Graph<BusinessEntity, Integer> g = StoreData.readGraphData("distancias_mini_v3.csv", map, coordsMap);

        Management.definingHubs(g, 5);

        HashMap<Integer, List<Bundle>> bundles = new HashMap<>();
        HashMap<Integer, List<DailyStock>> dailyStocks = new HashMap<>();


        String filename = "cabazes_too_mini_no_stock.csv";
        StoreData.readListBundles(filename,bundles,dailyStocks);
        HashMap<Integer, List<DailyStock>> originaldailyStocks = new HashMap<>();
        StoreData.readListBundles(filename,bundles,originaldailyStocks);
        List<Bundle> dBundles = Management.expeditionListWithRestrictions(bundles, dailyStocks, g, 1, 3);

        DeliveryRoute result = Management.definitionDailyRout(g, dBundles);

        assertNull(result);
    }

    @Test
    void definitionDailyRoutTestMiniV2WithNoBundle() {
        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_mini_v2.csv", coordsMap);
        Graph<BusinessEntity, Integer> g = StoreData.readGraphData("distancias_mini_v3.csv", map, coordsMap);

        Management.definingHubs(g, 5);

        List<Bundle> dBundles = new ArrayList<>();

        DeliveryRoute result = Management.definitionDailyRout(g, dBundles);

        assertNull(result);
    }

    @Test
    void definitionDailyRoutTestSmall() {
        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_small.csv", coordsMap);
        Graph<BusinessEntity, Integer> g = StoreData.readGraphData("distancias_small.csv", map, coordsMap);
        ArrayList<BusinessEntity> vertices = g.vertices();

        Management.definingHubs(g, 5);

        HashMap<Integer, List<Bundle>> bundles = new HashMap<>();
        HashMap<Integer, List<DailyStock>> dailyStocks = new HashMap<>();

        LinkedList<BusinessEntity> pathExpected = new LinkedList<>();
        ArrayList<Integer> distExpected = new ArrayList<>();
        Integer totalDistanceExpected;
        ArrayList<Pair<BusinessEntity, Integer>> hubDeliveriesExpected = new ArrayList<>();

        pathExpected.add(vertices.get(13)); //P2
        pathExpected.add(vertices.get(1));  //P3
        pathExpected.add(vertices.get(13)); //P2
        pathExpected.add(vertices.get(8));  //P1
        pathExpected.add(vertices.get(12)); //E3
        pathExpected.add(vertices.get(2));  //E2
        distExpected.add(67584);
        distExpected.add(67584);
        distExpected.add(73828);
        distExpected.add(111134);
        distExpected.add(62655);
        totalDistanceExpected = 382785;
        hubDeliveriesExpected.add(new Pair<>(vertices.get(2), 14));
        DeliveryRoute expectedResult = new DeliveryRoute(pathExpected,distExpected,totalDistanceExpected, hubDeliveriesExpected);

        String filename = "cabazes_small.csv";
        StoreData.readListBundles(filename,bundles,dailyStocks);
        HashMap<Integer, List<DailyStock>> originaldailyStocks = new HashMap<>();
        StoreData.readListBundles(filename,bundles,originaldailyStocks);
        List<Bundle> dBundles = Management.expeditionListWithRestrictions(bundles, dailyStocks, g, 2, 3);

        DeliveryRoute result = Management.definitionDailyRout(g, dBundles);

        assertEquals(expectedResult.getPath(), result.getPath());
        assertEquals(expectedResult.getDist(), result.getDist());
        assertEquals(expectedResult.getTotalDistance(), result.getTotalDistance());
        assertEquals(expectedResult.getHubDeliveries().get(0).getLeft(), result.getHubDeliveries().get(0).getLeft());
        assertEquals(expectedResult.getHubDeliveries().get(0).getRight(), result.getHubDeliveries().get(0).getRight());
    }


    @Test
    void findingClientClosestHubMini() {
        TreeMap<String, Pair<Float, Float>> coordsMap2 = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map2 = StoreData.readLocations("clientes-produtores_mini_v3.csv", coordsMap2);
        Graph<BusinessEntity, Integer> graph2 = StoreData.readGraphData("distancias_mini_v3.csv", map2, coordsMap2);

        Management.definingHubs(graph2, 5);
        ArrayList<BusinessEntity> hubs2 = graph2.vertices();

        int i = 0;
        ArrayList<Company> hybies = new ArrayList<>();
        ArrayList<Client> cc = new ArrayList<>();

        while (i < hubs2.size()) {
            if ((hubs2.get(i) instanceof Company)) {
                Company myHub = (Company) hubs2.get(i);
                if (myHub.isHub()) {
                    hybies.add(myHub);
                }
            }
            if ((hubs2.get(i) instanceof Client)) {
                cc.add((Client) hubs2.get(i));
            }
            i++;
        }
        assertEquals(5, hybies.size());

        /*for (i = 0; i < hybies.size(); i++){
            System.out.println(hybies.get(i).getEntityID());
        }

        System.out.println("\n\n\n\n");

        for (i = 0; i < cc.size(); i++){
            System.out.println(cc.get(i).getEntityID());
        }*/

        assertEquals(hybies.get(3), Management.findingClientClosestHub(graph2, cc.get(0)));
        assertEquals(hybies.get(0), Management.findingClientClosestHub(graph2, cc.get(1)));
        assertEquals(hybies.get(1), Management.findingClientClosestHub(graph2, cc.get(2)));
        assertEquals(hybies.get(1), Management.findingClientClosestHub(graph2, cc.get(3)));
        assertEquals(hybies.get(2), Management.findingClientClosestHub(graph2, cc.get(4)));
        assertEquals(hybies.get(3), Management.findingClientClosestHub(graph2, cc.get(5)));
        assertEquals(hybies.get(4), Management.findingClientClosestHub(graph2, cc.get(6)));
    }

    @Test
    void atLeastOneHubExistsMini() {
        TreeMap<String, Pair<Float, Float>> coordsMap2 = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map2 = StoreData.readLocations("clientes-produtores_mini_v3.csv", coordsMap2);
        Graph<BusinessEntity, Integer> graph2 = StoreData.readGraphData("distancias_mini_v3.csv", map2, coordsMap2);

        assertFalse(Management.atLeastOneHubExists(graph2));

        Management.definingHubs(graph2, 5);

        assertTrue(Management.atLeastOneHubExists(graph2));
    }

    @Test
    void expeditionListWithRestrictionsTooMini() {
        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_mini_v2.csv", coordsMap);
        Graph<BusinessEntity, Integer> graph = StoreData.readGraphData("distancias_mini_v3.csv", map, coordsMap);

        Management.definingHubs(graph, 5);

        HashMap<Integer, List<Bundle>> bundles = new HashMap<>();

        // DailyStock by Supplier
        HashMap<Integer, List<DailyStock>> dailyStocks = new HashMap<>();

        String filename = "cabazes_too_mini.csv";
        StoreData.readListBundles(filename,bundles,dailyStocks);

        List<Bundle> doneBundles = Management.expeditionListWithRestrictions(bundles, dailyStocks, graph, 1, 2);

        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod1")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod2")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod3")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod4")).getQuantityDelivered());
        assertEquals(4, doneBundles.get(0).getOrder().get(new Product("Prod5")).getQuantityDelivered());
        assertEquals(2, doneBundles.get(0).getOrder().get(new Product("Prod6")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod7")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod8")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod9")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod10")).getQuantityDelivered());
        assertEquals(2.5F, doneBundles.get(0).getOrder().get(new Product("Prod11")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod12")).getQuantityDelivered());

    }

    @Test
    void expeditionListWithRestrictionsTooMiniNoStock() {
        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_mini_v2.csv", coordsMap);
        Graph<BusinessEntity, Integer> graph = StoreData.readGraphData("distancias_mini_v3.csv", map, coordsMap);

        Management.definingHubs(graph, 5);

        HashMap<Integer, List<Bundle>> bundles = new HashMap<>();

        // DailyStock by Supplier
        HashMap<Integer, List<DailyStock>> dailyStocks = new HashMap<>();

        String filename = "cabazes_too_mini_no_stock.csv";
        StoreData.readListBundles(filename,bundles,dailyStocks);

        List<Bundle> doneBundles = Management.expeditionListWithRestrictions(bundles, dailyStocks, graph, 1, 2);

        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod1")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod2")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod3")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod4")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod5")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod6")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod7")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod8")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod9")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod10")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod11")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod12")).getQuantityDelivered());

    }

    @Test
    void expeditionListWithRestrictionsTooMiniDay3() {
        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_mini_v2.csv", coordsMap);
        Graph<BusinessEntity, Integer> graph = StoreData.readGraphData("distancias_mini_v3.csv", map, coordsMap);

        Management.definingHubs(graph, 5);

        HashMap<Integer, List<Bundle>> bundles = new HashMap<>();

        // DailyStock by Supplier
        HashMap<Integer, List<DailyStock>> dailyStocks = new HashMap<>();

        String filename = "cabazes_mini_day3.csv";
        StoreData.readListBundles(filename,bundles,dailyStocks);

        List<Bundle> doneBundles = Management.expeditionListWithRestrictions(bundles, dailyStocks, graph, 3, 3);

        assertEquals(8, doneBundles.get(0).getOrder().get(new Product("Prod1")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod2")).getQuantityDelivered());
        assertEquals(6, doneBundles.get(0).getOrder().get(new Product("Prod3")).getQuantityDelivered());
        assertEquals(2, doneBundles.get(0).getOrder().get(new Product("Prod4")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod5")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod6")).getQuantityDelivered());
        assertEquals(9, doneBundles.get(0).getOrder().get(new Product("Prod7")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod8")).getQuantityDelivered());
        assertEquals(2, doneBundles.get(0).getOrder().get(new Product("Prod9")).getQuantityDelivered());
        assertEquals(7.5F, doneBundles.get(0).getOrder().get(new Product("Prod10")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod11")).getQuantityDelivered());
        assertEquals(6, doneBundles.get(0).getOrder().get(new Product("Prod12")).getQuantityDelivered());

        assertEquals(0, doneBundles.get(1).getOrder().get(new Product("Prod1")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(1).getOrder().get(new Product("Prod2")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(1).getOrder().get(new Product("Prod3")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(1).getOrder().get(new Product("Prod4")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(1).getOrder().get(new Product("Prod5")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(1).getOrder().get(new Product("Prod6")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(1).getOrder().get(new Product("Prod7")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(1).getOrder().get(new Product("Prod8")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(1).getOrder().get(new Product("Prod9")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(1).getOrder().get(new Product("Prod10")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(1).getOrder().get(new Product("Prod11")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(1).getOrder().get(new Product("Prod12")).getQuantityDelivered());
    }

    @Test
    void expeditionListWithRestrictionsTooMiniDay4() {
        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_mini_v2.csv", coordsMap);
        Graph<BusinessEntity, Integer> graph = StoreData.readGraphData("distancias_mini_v3.csv", map, coordsMap);

        Management.definingHubs(graph, 5);

        HashMap<Integer, List<Bundle>> bundles = new HashMap<>();

        // DailyStock by Supplier
        HashMap<Integer, List<DailyStock>> dailyStocks = new HashMap<>();

        String filename = "cabazes_mini_day4.csv";
        StoreData.readListBundles(filename,bundles,dailyStocks);

        List<Bundle> doneBundles = Management.expeditionListWithRestrictions(bundles, dailyStocks, graph, 4, 3);

        assertEquals(8, doneBundles.get(0).getOrder().get(new Product("Prod1")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod2")).getQuantityDelivered());
        assertEquals(9.5F, doneBundles.get(0).getOrder().get(new Product("Prod3")).getQuantityDelivered());
        assertEquals(2, doneBundles.get(0).getOrder().get(new Product("Prod4")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod5")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod6")).getQuantityDelivered());
        assertEquals(9.5F, doneBundles.get(0).getOrder().get(new Product("Prod7")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod8")).getQuantityDelivered());
        assertEquals(2, doneBundles.get(0).getOrder().get(new Product("Prod9")).getQuantityDelivered());
        assertEquals(9.5F, doneBundles.get(0).getOrder().get(new Product("Prod10")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(0).getOrder().get(new Product("Prod11")).getQuantityDelivered());
        assertEquals(6, doneBundles.get(0).getOrder().get(new Product("Prod12")).getQuantityDelivered());

        assertEquals(7.5F, doneBundles.get(1).getOrder().get(new Product("Prod1")).getQuantityDelivered());
        assertEquals(0, doneBundles.get(1).getOrder().get(new Product("Prod2")).getQuantityDelivered());
        assertEquals(4.5F, doneBundles.get(1).getOrder().get(new Product("Prod3")).getQuantityDelivered());
        assertEquals(8.5F, doneBundles.get(1).getOrder().get(new Product("Prod4")).getQuantityDelivered());
        assertEquals(5F, doneBundles.get(1).getOrder().get(new Product("Prod5")).getQuantityDelivered());
        assertEquals(7.5F, doneBundles.get(1).getOrder().get(new Product("Prod6")).getQuantityDelivered());
        assertEquals(6F, doneBundles.get(1).getOrder().get(new Product("Prod7")).getQuantityDelivered());
        assertEquals(8.5F, doneBundles.get(1).getOrder().get(new Product("Prod8")).getQuantityDelivered());
        assertEquals(8.5F, doneBundles.get(1).getOrder().get(new Product("Prod9")).getQuantityDelivered());
        assertEquals(3.0F, doneBundles.get(1).getOrder().get(new Product("Prod10")).getQuantityDelivered());
        assertEquals(6.0F, doneBundles.get(1).getOrder().get(new Product("Prod11")).getQuantityDelivered());
        assertEquals(2.5F, doneBundles.get(1).getOrder().get(new Product("Prod12")).getQuantityDelivered());

        assertEquals(0, dailyStocks.get(2).get(0).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(2).get(1).getAvailableQuantity());
        assertEquals(2.5F, dailyStocks.get(2).get(2).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(2).get(3).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(2).get(4).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(2).get(5).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(2).get(6).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(2).get(7).getAvailableQuantity());
        assertEquals(1, dailyStocks.get(2).get(8).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(2).get(9).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(2).get(10).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(2).get(11).getAvailableQuantity());
        assertEquals(1.5F, dailyStocks.get(2).get(12).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(2).get(13).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(2).get(14).getAvailableQuantity());
        assertEquals(2.5F, dailyStocks.get(2).get(15).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(2).get(16).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(2).get(17).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(2).get(18).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(2).get(19).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(2).get(20).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(2).get(21).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(2).get(22).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(2).get(23).getAvailableQuantity());

        assertEquals(6F, dailyStocks.get(3).get(0).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(3).get(1).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(3).get(2).getAvailableQuantity());
        assertEquals(1.5F, dailyStocks.get(3).get(3).getAvailableQuantity());
        assertEquals(4F, dailyStocks.get(3).get(4).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(3).get(5).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(3).get(6).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(3).get(7).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(3).get(8).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(3).get(9).getAvailableQuantity());
        assertEquals(1.5F, dailyStocks.get(3).get(10).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(3).get(11).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(3).get(12).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(3).get(13).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(3).get(14).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(3).get(15).getAvailableQuantity());
        assertEquals(2.5F, dailyStocks.get(3).get(16).getAvailableQuantity());
        assertEquals(7F, dailyStocks.get(3).get(17).getAvailableQuantity());
        assertEquals(5F, dailyStocks.get(3).get(18).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(3).get(19).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(3).get(20).getAvailableQuantity());
        assertEquals(1F, dailyStocks.get(3).get(21).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(3).get(22).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(3).get(23).getAvailableQuantity());

        assertEquals(0, dailyStocks.get(4).get(0).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(4).get(1).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(4).get(2).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(4).get(3).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(4).get(4).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(4).get(5).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(4).get(6).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(4).get(7).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(4).get(8).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(4).get(9).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(4).get(10).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(4).get(11).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(4).get(12).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(4).get(13).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(4).get(14).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(4).get(15).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(4).get(16).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(4).get(17).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(4).get(18).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(4).get(19).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(4).get(20).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(4).get(21).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(4).get(22).getAvailableQuantity());
        assertEquals(0, dailyStocks.get(4).get(23).getAvailableQuantity());
    }

    //@Test
    /**void definingHubsMiniV1() {
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
     **/
}

