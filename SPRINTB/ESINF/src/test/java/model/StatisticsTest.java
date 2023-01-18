package model;
import fileUtils.Pair;
import fileUtils.StoreData;
import graph.Graph;
import model.business_entities.BusinessEntity;
import model.business_entities.Company;
import model.business_entities.Supplier;
import model.stats.BundleStat;
import model.stats.ClientStat;
import model.stats.HubStat;
import model.stats.SupplierStat;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;


import java.util.*;

import static model.stats.Statistics.*;
import static org.junit.jupiter.api.Assertions.*;

public class StatisticsTest {
    /*Company c;
    DailyStock ds;
    Bundle b;
    Product p;
    OrderItem o;
    TreeMap<Product,OrderItem> map;
    Supplier s;
    Location l;
    List<Bundle> lb=new ArrayList<>();
    HashMap<Integer,List<DailyStock>> lds=new HashMap<>();
    List<DailyStock> l1=new ArrayList<>();
    List<DailyStock> l2=new ArrayList<>();
    List<DailyStock> l3=new ArrayList<>();
    BundleStat bsExpected;

    ClientStat csExpected;
    SupplierStat ssExpected;
    HubStat hsExpected;
    List<BundleStat> listBSExpected=new ArrayList<>();

    List<ClientStat> listCSExpected=new ArrayList<>();

    List<SupplierStat> listSSExpected=new ArrayList<>();

    List<HubStat> listHSExpected=new ArrayList<>();

    @BeforeEach
    public void initializeBundles()
    {


        b=new Bundle("C1",3);

        c=new Company(l,"Hub1");
        map=new TreeMap<>();
        p=new Product("banana");
        l=new Location("CT1");
        s=new Supplier(l,"P1");
        b.setHub(c);
        o=new OrderItem(s,p,15f);
        o.setQuantityDelivered(15f);
        map.put(p,o);

        ds=new DailyStock(p,s.getEntityID(),17f,2);
        l2.add(ds);
        lds.put(2,l2);

        ssExpected=new SupplierStat(s);
        ssExpected.setNumDifHubs(1);
        ssExpected.setNumDifClients(2);
        ssExpected.addPartiallyDelivered();
        ssExpected.addPartiallyDelivered();

        listSSExpected.add(ssExpected);

        p=new Product("apple");
        l=new Location("CT2");
        s=new Supplier(l,"P2");
        o=new OrderItem(s,p,15f);
        o.setQuantityDelivered(12f);
        map.put(p,o);

        ds=new DailyStock(p,s.getEntityID(),12f,1);
        l1.add(ds);
        lds.put(1,l1);

        p=new Product("cajun");
        o=new OrderItem(s,p,15f);
        o.setQuantityDelivered(0f);
        map.put(p,o);

        ssExpected=new SupplierStat(s);
        ssExpected.setNumDifHubs(1);
        ssExpected.setNumDifClients(2);
        ssExpected.addSoldOutProduct();
        ssExpected.addSoldOutProduct();
        ssExpected.addSoldOutProduct();
        ssExpected.addSoldOutProduct();
        ssExpected.addPartiallyDelivered();
        ssExpected.addPartiallyDelivered();
        listSSExpected.add(ssExpected);

        p=new Product("pear");
        l=new Location("CT3");
        s=new Supplier(l,"P3");
        o=new OrderItem(s,p,15f);
        o.setQuantityDelivered(15f);
        map.put(p,o);

        ds=new DailyStock(p,s.getEntityID(),15f,3);
        l3.add(ds);
        lds.put(3,l3);

        b.setOrder(map);

        lb.add(b);

        ssExpected=new SupplierStat(s);
        ssExpected.setNumDifHubs(1);
        ssExpected.setNumDifClients(2);
        ssExpected.addSoldOutProduct();
        ssExpected.addSoldOutProduct();
        ssExpected.addPartiallyDelivered();
        ssExpected.addPartiallyDelivered();
        listSSExpected.add(ssExpected);



        bsExpected=new BundleStat(b);
        bsExpected.setNumSuppliers(3);
        bsExpected.setPercentDelivered(0.7f);
        bsExpected.addTotallyDelivered();
        bsExpected.addTotallyDelivered();
        bsExpected.addPartiallyDelivered();
        bsExpected.addNotDelivered();

        csExpected=new ClientStat("C1");
        csExpected.setNumSuppliers(3);
        csExpected.addPartiallyDelivered();

        hsExpected=new HubStat(c);
        hsExpected.setNumDifClients(2);
        hsExpected.setNumDifSuppliers(3);

        listBSExpected.add(bsExpected);
        listCSExpected.add(csExpected);
        listHSExpected.add(hsExpected);



        b=new Bundle("C2",3);

        map=new TreeMap<>();
        p=new Product("banana");
        l=new Location("CT1");
        s=new Supplier(l,"P1");
        b.setHub(c);
        o=new OrderItem(s,p,15f);
        o.setQuantityDelivered(15f);
        map.put(p,o);

        ds=new DailyStock(p,s.getEntityID(),17f,2);
        l2.add(ds);
        lds.put(2,l2);

        p=new Product("apple");
        l=new Location("CT2");
        s=new Supplier(l,"P2");
        o=new OrderItem(s,p,15f);
        o.setQuantityDelivered(12f);
        map.put(p,o);

        ds=new DailyStock(p,s.getEntityID(),12f,1);
        l1.add(ds);
        lds.put(1,l1);

        p=new Product("cajun");
        o=new OrderItem(s,p,15f);
        o.setQuantityDelivered(0f);
        map.put(p,o);

        p=new Product("pear");
        l=new Location("CT3");
        s=new Supplier(l,"P3");
        o=new OrderItem(s,p,15f);
        o.setQuantityDelivered(15f);
        map.put(p,o);

        ds=new DailyStock(p,s.getEntityID(),15f,3);
        l3.add(ds);
        lds.put(3,l3);

        b.setOrder(map);

        lb.add(b);

        bsExpected=new BundleStat(b);
        bsExpected.setNumSuppliers(3);
        bsExpected.setPercentDelivered(0.7f);
        bsExpected.addTotallyDelivered();
        bsExpected.addTotallyDelivered();
        bsExpected.addPartiallyDelivered();
        bsExpected.addNotDelivered();

        csExpected=new ClientStat("C2");
        csExpected.setNumSuppliers(3);
        csExpected.addPartiallyDelivered();
        listCSExpected.add(csExpected);

        listBSExpected.add(bsExpected);
    }*/

    @Test
    void testBundleStats() {

        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_mini_v2.csv", coordsMap);
        Graph<BusinessEntity, Integer> graph = StoreData.readGraphData("distancias_mini_v3.csv", map, coordsMap);

        Management.definingHubs(graph, 5);

        HashMap<Integer, List<Bundle>> bundles = new HashMap<>();

        // DailyStock by Supplier
        HashMap<Integer, List<DailyStock>> dailyStocks = new HashMap<>();

        String filename = "cabazes_mini_day4.csv";
        StoreData.readListBundles(filename,bundles,dailyStocks);

        HashMap<Integer, List<DailyStock>> originaldailyStocks=new HashMap<>();

        StoreData.readListBundles(filename,bundles,originaldailyStocks);

        List<Bundle> doneBundles = Management.expeditionListWithRestrictions(bundles, dailyStocks, graph, 4, 3);

        List<BundleStat> lbs=getBundleStats(doneBundles);

        assertEquals(5,lbs.get(0).getNotDelivered());
        assertEquals(2,lbs.get(0).getNumSuppliers());
        assertEquals(0,lbs.get(0).getPartDelivered());
        assertEquals(1,lbs.get(0).getPercentDelivered());
        assertEquals(7,lbs.get(0).getTotallyDelivered());

        assertEquals(1,lbs.get(1).getNotDelivered());
        assertEquals(2,lbs.get(1).getNumSuppliers());
        assertEquals(11,lbs.get(1).getPartDelivered());
        assertEquals(0.05625f,lbs.get(1).getPercentDelivered());
        assertEquals(0,lbs.get(1).getTotallyDelivered());

    }

    @Test
    void testClientStats() {

        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_mini_v2.csv", coordsMap);
        Graph<BusinessEntity, Integer> graph = StoreData.readGraphData("distancias_mini_v3.csv", map, coordsMap);

        Management.definingHubs(graph, 5);

        HashMap<Integer, List<Bundle>> bundles = new HashMap<>();

        // DailyStock by Supplier
        HashMap<Integer, List<DailyStock>> dailyStocks = new HashMap<>();

        String filename = "cabazes_mini_day4.csv";
        StoreData.readListBundles(filename,bundles,dailyStocks);

        HashMap<Integer, List<DailyStock>> originaldailyStocks=new HashMap<>();

        StoreData.readListBundles(filename,bundles,originaldailyStocks);

        List<Bundle> doneBundles = Management.expeditionListWithRestrictions(bundles, dailyStocks, graph, 4, 3);

        List<ClientStat> lcs=getClientStats(doneBundles);



        assertEquals(2,lcs.get(0).getNumDifSuppliers());
        assertEquals(0,lcs.get(0).getPartDeliveredBundles());
        assertEquals(1,lcs.get(0).getTotallyDeliveredBundles());

        assertEquals(2,lcs.get(1).getNumDifSuppliers());
        assertEquals(1,lcs.get(1).getPartDeliveredBundles());
        assertEquals(0,lcs.get(1).getTotallyDeliveredBundles());

    }

    @Test
    void testSupplierStats() {

        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_mini_v2.csv", coordsMap);
        Graph<BusinessEntity, Integer> graph = StoreData.readGraphData("distancias_mini_v3.csv", map, coordsMap);

        Management.definingHubs(graph, 5);

        HashMap<Integer, List<Bundle>> bundles = new HashMap<>();

        // DailyStock by Supplier
        HashMap<Integer, List<DailyStock>> dailyStocks = new HashMap<>();

        String filename = "cabazes_mini_day4.csv";
        StoreData.readListBundles(filename,bundles,dailyStocks);

        HashMap<Integer, List<DailyStock>> originaldailyStocks=new HashMap<>();

        StoreData.readListBundles(filename,bundles,originaldailyStocks);

        List<Bundle> doneBundles = Management.expeditionListWithRestrictions(bundles, dailyStocks, graph, 4, 3);

        List<SupplierStat> lss=getSupplierStats(doneBundles,originaldailyStocks,dailyStocks);


        assertEquals(0,lss.get(0).getTotallyDeliveredBundles());
        assertEquals(2,lss.get(0).getPartDeliveredBundles());
        assertEquals(2,lss.get(0).getNumDifClients());
        assertEquals(1,lss.get(0).getNumDifHubs());
        assertEquals(8,lss.get(0).getNumSoldOutProds());

        assertEquals(0,lss.get(1).getTotallyDeliveredBundles());
        assertEquals(2,lss.get(1).getPartDeliveredBundles());
        assertEquals(2,lss.get(1).getNumDifClients());
        assertEquals(1,lss.get(1).getNumDifHubs());
        assertEquals(6,lss.get(1).getNumSoldOutProds());

    }

    @Test
    void testHubStats() {

        TreeMap<String, Pair<Float, Float>> coordsMap = new TreeMap<>();
        TreeMap<Location, BusinessEntity> map = StoreData.readLocations("clientes-produtores_mini_v2.csv", coordsMap);
        Graph<BusinessEntity, Integer> graph = StoreData.readGraphData("distancias_mini_v3.csv", map, coordsMap);

        Management.definingHubs(graph, 5);

        HashMap<Integer, List<Bundle>> bundles = new HashMap<>();

        // DailyStock by Supplier
        HashMap<Integer, List<DailyStock>> dailyStocks = new HashMap<>();

        String filename = "cabazes_mini_day4.csv";
        StoreData.readListBundles(filename,bundles,dailyStocks);

        HashMap<Integer, List<DailyStock>> originaldailyStocks=new HashMap<>();

        StoreData.readListBundles(filename,bundles,originaldailyStocks);

        List<Bundle> doneBundles = Management.expeditionListWithRestrictions(bundles, dailyStocks, graph, 4, 3);


        List<HubStat> lhs=getHubStats(doneBundles);


        assertEquals(2,lhs.get(0).getNumDifClients());
        assertEquals(2,lhs.get(0).getNumDifSuppliers());

    }

}
