import fileUtils.Pair;
import fileUtils.StoreData;
import graph.Algorithms;
import graph.Graph;
import model.*;
import model.business_entities.BusinessEntity;
//import org.junit.jupiter.Test;
import model.business_entities.Supplier;
import org.junit.jupiter.api.Test;

import java.sql.SQLOutput;
import java.time.LocalTime;
import java.util.*;

//import static org.junit.Assert.*;
import static fileUtils.StoreData.readWateringConfiguration;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;

public class StoreDataTest {

    @Test
    public void testReadWateringConfiguration(){

        ArrayList<LocalTime> wateringCycleHour=new ArrayList<>();
        ArrayList<WateringPlan> wateringPlans=new ArrayList<>();
        wateringCycleHour.add(LocalTime.of(8,30));
        wateringCycleHour.add(LocalTime.of(17,0));
        WateringPlan plan=new WateringPlan("a",10,'t');
        wateringPlans.add(plan);
        plan=new WateringPlan("b",12,'p');
        wateringPlans.add(plan);
        plan=new WateringPlan("c",12,'i');
        wateringPlans.add(plan);
        plan=new WateringPlan("d",5,'t');
        wateringPlans.add(plan);
        plan=new WateringPlan("e",8,'i');
        wateringPlans.add(plan);
        WateringConfiguration wcExpected=new WateringConfiguration(30,wateringPlans,wateringCycleHour);
        WateringConfiguration wcActual = readWateringConfiguration("rega.txt");

        assertEquals(wcExpected,wcActual);

    }

    @Test
    public void testReadLocations(){
        TreeMap<String, Pair<Float,Float>> coordsMap = new TreeMap<>();

        long begin = System.nanoTime();
        //Starting the watch
        TreeMap<Location, BusinessEntity> map = new TreeMap<>();
        System.out.println("Filename null");
        map= StoreData.readLocations(null, coordsMap);
        assertNull(map);
        System.out.println();

        System.out.println("Non existing file");
        map=StoreData.readLocations("123.csv", coordsMap);
        assertNull(map);
        System.out.println();

        System.out.println("file with some wrong data");
        map=StoreData.readLocations("clientes-produtores_small-wrongdata.csv", coordsMap);
        assertEquals(12, map.size(), "Should keep just 12 registers");
        System.out.println();

        System.out.println("file with no data");
        map=StoreData.readLocations("clientes-produtores_small-nodata.csv", coordsMap);
        assertNull(map);
        System.out.println();
        //Graph<BusinessEntity, Integer> graph = StoreData.readGraphData("distancias_big.csv", map, coordsMap);
        long end = System.nanoTime();
        long time = end-begin;
    }

    @Test
    public void testReadGraphData(){
        TreeMap<String, Pair<Float,Float>> coordsMap = new TreeMap<>();

        long begin = System.nanoTime();
        //Starting the watch
        TreeMap<Location, BusinessEntity> map = new TreeMap<>();
        Graph<BusinessEntity, Integer> graph = null;


        map=null;
        System.out.println("Entity map is null");
        graph=StoreData.readGraphData("distancias_small.csv",map,coordsMap);
        assertNull(graph);
        System.out.println();


        map=StoreData.readLocations("clientes-produtores_small.csv", coordsMap);
        coordsMap=null;
        System.out.println("Coordinates map is null");
        graph=StoreData.readGraphData("distancias_small.csv",map,coordsMap);
        assertNull(graph);
        System.out.println();

        coordsMap=new TreeMap<>();
        map=StoreData.readLocations("clientes-produtores_small.csv", coordsMap);
        System.out.println("Filename null");
        graph=StoreData.readGraphData(null,map,coordsMap);
        assertNull(graph);
        System.out.println();

        map=StoreData.readLocations("clientes-produtores_small.csv", coordsMap);
        System.out.println("Some wrong data in file");
        graph=StoreData.readGraphData("distancias_small_wrongdata.csv",map,coordsMap);
        assertEquals(52,graph.numEdges(),"Should be 52 edges in the graph");
        assertEquals(17,graph.numVertices(),"Should be 17 vertices in the graph");

        System.out.println();
        //Graph<BusinessEntity, Integer> graph = StoreData.readGraphData("distancias_big.csv", map, coordsMap);
        long end = System.nanoTime();
        long time = end-begin;
    }

    @Test
    public void testReadBundlesSmall() {
        HashMap<Integer, List<Bundle>> bundles = new HashMap<>();

        // DailyStock by Supplier
        HashMap<Integer, List<DailyStock>> dailyStocks = new HashMap<>();


        String filename = "cabazes_small.csv";
        StoreData.readListBundles(filename,bundles,dailyStocks);


        assertEquals(dailyStocks.keySet().contains(1), true);
        assertEquals(dailyStocks.keySet().contains(2), true);
        assertEquals(dailyStocks.keySet().contains(3), true);
        assertEquals(dailyStocks.keySet().contains(4), true);
        assertEquals(dailyStocks.keySet().contains(5), true);
        assertEquals(bundles.size()==5,true);
        assertEquals(bundles.get(1).size()==14,true);
        assertEquals(bundles.get(2).size()==14,true);
        assertEquals(bundles.get(3).size()==14,true);
        assertEquals(bundles.get(4).size()==14,true);
        assertEquals(bundles.get(5).size()==14,true);
        }

    @Test
    public void testReadBundlesBig() {
        HashMap<Integer, List<Bundle>> bundles = new HashMap<>();

        // DailyStock by Supplier
        HashMap<Integer, List<DailyStock>> dailyStocks = new HashMap<>();


        String filename = "cabazes_big.csv";
        StoreData.readListBundles(filename,bundles,dailyStocks);



        assertEquals(dailyStocks.keySet().contains(1), true);
        assertEquals(dailyStocks.get(1).get(0).getSupplier().equals("P1"),true);
        assertEquals(dailyStocks.keySet().contains(2), true);
        assertEquals(dailyStocks.get(2).get(1).getSupplier().equals("P1"),true);
        assertEquals(dailyStocks.keySet().contains(3), true);
        assertEquals(dailyStocks.get(3).get(2).getSupplier().equals("P1"),true);
        assertEquals(dailyStocks.keySet().contains(4), true);
        assertEquals(dailyStocks.get(4).get(3).getSupplier().equals("P1"),true);
        assertEquals(dailyStocks.keySet().contains(5), true);
        assertEquals(dailyStocks.get(5).get(4).getSupplier().equals("P1"),true);
        assertEquals(bundles.size()==5,true);
        assertEquals(bundles.get(1).get(0).getClient().equals("C1"),true);
        assertEquals(bundles.get(2).get(1).getClient().equals("C2"),true);
        assertEquals(bundles.get(3).get(2).getClient().equals("C3"),true);
        assertEquals(bundles.get(4).get(3).getClient().equals("C4"),true);
        assertEquals(bundles.get(5).get(4).getClient().equals("C5"),true);
    }

    }

