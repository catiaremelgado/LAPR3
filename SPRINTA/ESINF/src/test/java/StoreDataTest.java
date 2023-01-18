import fileUtils.Pair;
import fileUtils.StoreData;
import graph.Graph;
import model.Location;
import model.WateringConfiguration;
import model.WateringPlan;
import model.business_entities.BusinessEntity;
//import org.junit.jupiter.Test;
import org.junit.jupiter.api.Test;

import java.sql.SQLOutput;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.TreeMap;

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
}
