package fileUtils;

import graph.Graph;
import graph.map.MapGraph;
import model.*;
import model.business_entities.BusinessEntity;
import model.business_entities.Client;
import model.business_entities.Company;
import model.business_entities.Supplier;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.*;

/**
 * @author alexandraipatova
 * source: annavasylyshyna (Projeto2)
 * Class that handles all file reading
 */
public class StoreData {

    private final static String SPLIT_CHAR = ",";

    public static void main(String[] args) {
        WateringConfiguration wc=readWateringConfiguration("rega.txt");
        TreeMap<WateringPlan,Integer> w;
        w=wc.isCurrentlyWatering(LocalDateTime.of(2003,4,2,8,32));

        TreeMap<String, Pair<Float,Float>> coordsMap = new TreeMap<>();
        long begin = System.nanoTime();
        //Starting the watch

        TreeMap<Location, BusinessEntity> map = readLocations("clientes-produtores_big.csv", coordsMap);
        Graph<BusinessEntity, Integer> graph = readGraphData("distancias_big.csv", map, coordsMap);
        long end = System.nanoTime();
        long time = end-begin;

        System.out.println(graph);
        System.out.println();
        System.out.println("Elapsed Time: "+time/1000000+"ms");
    }

    public static WateringConfiguration readWateringConfiguration(String filename){

        //Initializes the line that corresponds to a line of the file
        String line;

        //Path of the file
        String file = System.getProperty("user.dir") + File.separator + "files" + File.separator + filename;
        WateringConfiguration wc=new WateringConfiguration(30);
        ArrayList<LocalTime> wateringCycleHour=new ArrayList<>();
        ArrayList<WateringPlan> wateringPlans=new ArrayList<>();
        try {

            InputStream input = new FileInputStream(file);
            FastReader reader = new FastReader(input);
            String[] data;
            line = reader.nextLine(); //read watering cycle hours
            String split = ",";
            data = line.split(split);
            String[] time;
            int hour;
            int minute;

            for (int i = 0; i < data.length; i++) { //add each watering water
                time=data[i].split(":");
                if(verify(time)){
                    try{

                        hour=Integer.parseInt(time[0]);
                        minute=Integer.parseInt(time[1]);
                        wateringCycleHour.add(LocalTime.of(hour,minute));

                    }catch(IllegalArgumentException illegal){
                        System.out.println("There is something wrong with the watering time " + data[i] +
                                "\nThe data of this watering time will not be saved.\n\n\n");
                    }
                }

            }

            wc.setWateringCycleHour(wateringCycleHour);

            String field;
            Integer wateringDuration;
            char regularity;
            WateringPlan plan;

            //Cycle that will read each line from the file until it reaches the end
            while (line != null) {
                data = line.split(split);
                if (data.length == 3) {

                    //remove unnecessary spaces
                    for (int i = 0; i < data.length; i++) {
                        data[i] = data[i].trim();
                    }
                    if (verify(data)) { //verify if not empty
                        try {
                            field = data[0];
                            wateringDuration = Integer.parseInt(data[1]);
                            regularity=data[2].charAt(0);
                            plan=new WateringPlan(field,wateringDuration,regularity);

                            wateringPlans.add(plan);

                        } catch (IllegalArgumentException illegal) {
                            System.out.println("There is something wrong with the watering plan duration " + data[1] +
                                    "\nThe data of this watering plan will not be saved.\n\n\n");
                        }
                    }
                }
                line = reader.nextLine();
            }
        } catch (IOException e) {
            System.out.println("The file does not exist");
        }

        wc.setFieldWateringPlan(wateringPlans);

        return wc;
    }

    /**
     * reads for the location coordinates
     *
     * @param fileName  the file containing location coordinates
     * @param coordsMap the map of coordinates of the location to save
     * @return treemap with location objects and businessEntities
     */
    public static TreeMap<Location, BusinessEntity> readLocations(String fileName, TreeMap<String, Pair<Float, Float>> coordsMap) {
        //Initializes the line that corresponds to a line of the file
        String line;

        //Path of the file
        String file = System.getProperty("user.dir") + File.separator + "files" + File.separator + fileName;
        TreeMap<Location, BusinessEntity> map = new TreeMap<>();
        try {
            InputStream input = new FileInputStream(file);
            FastReader reader = new FastReader(input);
            //Skips the header line
            reader.nextLine();
            line = reader.nextLine();
            String split = ",";
            //Cycle that will read each line from the file until it reaches the end
            while (line != null) {
                String[] data;
                data = line.split(split);
                if (data.length == 4) {
                    //remove unnecessary spaces
                    for (int i = 0; i < data.length; i++) {
                        data[i] = data[i].trim();
                    }
                    if (verify(data)) { //verify if not empty
                        try {
                            String locID = data[0];
                            Float latitude = Float.parseFloat(data[1]);
                            Float longitude = Float.parseFloat(data[2]);
                            Location location = new Location(locID, latitude, longitude);
                            BusinessEntity entity = null;
                            switch (data[3].charAt(0)) {
                                case 'C':
                                    entity = new Client(location, data[3]);
                                    break;
                                case 'E':
                                    entity = new Company(location, data[3]);
                                    break;
                                case 'P':
                                    entity = new Supplier(location, data[3]);
                                    break;
                                default:
                                    throw new IllegalArgumentException();
                            }
                            if (entity != null) {
                                coordsMap.put(locID, new Pair<>(latitude, longitude));
                                map.put(location, entity);
                            }
                        } catch (IllegalArgumentException illegal) {
                            System.out.println("There is something wrong with the id of the business entity: " + data[3] +
                                    "\nThe data from business entity " + data[3] + " will not be saved.\n\n\n");
                        } catch (Exception e) {
                            System.out.println("There is something wrong with the longitude or latitude of location: " + data[0] +
                                    "\nThe data from location " + data[0] + " will not be saved.\n\n\n");
                        }
                    }
                }
                line = reader.nextLine();
            }
        } catch (IOException e) {
            System.out.println("The file does not exist");
        }
        if(map.isEmpty()){
            return null;
        }
        return map;
    }

    private static boolean verify(String[] data) {
        boolean flag = true;
        int i = 0;
        while (flag && i < data.length) {
            if (data[i] == null || data[i].isEmpty()) {
                flag = false;
            }
            i++;
        }
        return flag;
    }

    /**
     * read and stores connections between entities
     * @param fileName filename with associations
     * @param businessEntityMap map containg coordinates of vertices as key
     * @param coordsMap map containing actual x and y coordinates
     * @return
     */
    public static Graph<BusinessEntity,Integer> readGraphData(String fileName, TreeMap<Location,BusinessEntity> businessEntityMap, TreeMap<String,Pair<Float,Float>> coordsMap) {
        Graph<BusinessEntity, Integer> graph = new MapGraph<>(false);
        //Initializes the line that corresponds to a line of the file
        String line;
        //Path of the file
        String file = System.getProperty("user.dir") + File.separator + "files" + File.separator + fileName;
        ArrayList<String> origin = new ArrayList<>();
        ArrayList<String> destination = new ArrayList<>();
        ArrayList<Integer> distances = new ArrayList<>();
        try {
            InputStream input = new FileInputStream(file);
            FastReader reader = new FastReader(input);
            //Skips the header line
            reader.nextLine();
            line = reader.nextLine();
            String split = ",";
            //Cycle that will read each line from the file until it reaches the end
            while (line != null) {
                String[] data;
                data = line.split(split);
                if (data.length == 3) {
                    //remove unnecessary spaces
                    for (int i = 0; i < data.length; i++) {
                        data[i] = data[i].trim();
                    }
                    if (verify(data)) { //verify if not empty
                        try {
                            String locID1 = data[0];
                            String locID2 = data[1];
                            Integer distance = Integer.parseInt(data[2]);

                            origin.add(locID1);
                            destination.add(locID2);
                            distances.add(distance);
                        } catch (Exception e) {
                            System.out.println("There is something wrong with the distance of location between " + data[0] + " and " + data[0] +
                                    "\nThe data from locations " + data[0] + " and " + data[0] + " will not be saved.\n\n\n");
                        }
                    }
                }
                line = reader.nextLine();
            }
            buildGraph(graph, origin, destination, distances, businessEntityMap, coordsMap);
            if(graph.numVertices()==0){
                return null;
            }
            return graph;
        } catch (IOException e) {
            System.out.println("The file does not exist");
        }
        return null;
    }

    /**
     * builds a graph from a set of read data
     *
     * @param graph             graph that will be created
     * @param origin            origin of edges
     * @param destination       destination of edges
     * @param distances         weight of edges
     * @param businessEntityMap entities that exist
     * @param coordsMap         coordinates of locations
     */
    private static void buildGraph(
            Graph<BusinessEntity, Integer> graph,
            ArrayList<String> origin,
            ArrayList<String> destination,
            ArrayList<Integer> distances,
            TreeMap<Location, BusinessEntity> businessEntityMap,
            TreeMap<String, Pair<Float,Float>> coordsMap) {

        Location connectingLocation;
        int index = 0;
        String connectingLocationID;
        Float connectingLocationlatitude;
        Float connectingLocationlongitude;
        BusinessEntity vOrig;
        BusinessEntity vDest;

        if (businessEntityMap != null && coordsMap != null) {
            for (Map.Entry<Location, BusinessEntity> vert : businessEntityMap.entrySet()) {

                graph.addVertex(vert.getValue());
            }

            for (String originEntity : origin) {
                vOrig = businessEntityMap.get(
                        new Location(originEntity,
                                coordsMap.get(originEntity).getLeft(),
                                coordsMap.get(originEntity).getRight())
                );

                if (graph.validVertex(vOrig)) {

                    connectingLocationID = destination.get(index);
                    connectingLocationlatitude = coordsMap.get(destination.get(index)).getLeft();
                    connectingLocationlongitude = coordsMap.get(destination.get(index)).getRight();
                    connectingLocation = new Location(connectingLocationID, connectingLocationlatitude, connectingLocationlongitude);
                    vDest = businessEntityMap.get(connectingLocation);

                    if (vDest != null) {
                        graph.addEdge(vOrig, vDest, distances.get(index));
                    }
                }
                index++;
            }
        } else {
            graph = null;
        }
    }


    /**
     * Reads Bundles and Daily Stocks
     *
     * @param filename the file containing a List of Bundles and Daily Stocks
     */
    public static void readListBundles(String filename, HashMap<Integer, List<Bundle>> clientsOrders,  HashMap<Integer, List<DailyStock>> dailyStocks) {

        //Initializes the line that corresponds to a line of the file
        String line;
        //Path of the file
        String file = System.getProperty("user.dir") + File.separator + "files" + File.separator + filename;
        try {

            InputStream input = new FileInputStream(file);
            FastReader reader = new FastReader(input);

            // Get the products names.
            String[] products = reader.nextLine().replaceAll("\"","").split(SPLIT_CHAR);
            products = Arrays.copyOfRange(products, 2, products.length);

            //Cycle that will read each line from the file until it reaches the end
            while ((line = reader.nextLine()) != null) {
                String[] data;

                data = line.replaceAll("\"","").split(SPLIT_CHAR);

                //check if the line is valid (needs to have day, client and atleast one product)
                if (verify(data)) { //verify if not empty
                    if (data.length > 2) {

                        String origem = data[0].trim();
                        int day = Integer.parseInt(data[1].trim());

                        //remove unnecessary spaces
                        for (int i = 2; i < data.length; i++) {
                            float quantity = Float.parseFloat(data[i].trim());

                            switch (origem.charAt(0)) {
                                //Cliente / Empresa
                                case 'C': case 'E':
                                    if (clientsOrders.keySet().contains(day)) {  //check if day is already a key
                                        List<Bundle> bundles = clientsOrders.get(day);

                                        boolean found = false;

                                        for (Bundle b : bundles) {
                                            if (b.getClient().equals(origem)) { // add products to the bundle
                                                found = true;
                                                TreeMap<Product, OrderItem> treeMap = b.getOrder();
                                                Product product = new Product(products[i-2]);
                                                treeMap.put(product, new OrderItem(product, quantity));
                                            }
                                        }

                                        if (!found) {   //if client dont have a bundle
                                            Bundle bundle = new Bundle(origem, day);
                                            TreeMap<Product, OrderItem> treeMap = bundle.getOrder();
                                            Product product = new Product(products[i-2]);
                                            treeMap.put(product, new OrderItem(product, quantity));
                                            bundles.add(bundle);
                                        }
                                    } else { //if day isn't already a key
                                        Bundle bundle = new Bundle(origem, day);
                                        TreeMap<Product, OrderItem> treeMap = bundle.getOrder();
                                        Product product = new Product(products[i-2]);
                                        treeMap.put(product, new OrderItem(product, quantity));
                                        List<Bundle> bundles = new ArrayList<>();
                                        bundles.add(bundle);
                                        clientsOrders.put(day, bundles);
                                    }
                                    break;
                                    // Produtor
                                case 'P':
                                    if (dailyStocks.keySet().contains(day)) { //check if day is already a key
                                        List<DailyStock> list = dailyStocks.get(day);
                                        list.add(new DailyStock(new Product(products[i-2]), origem, quantity, day));
                                    } else {
                                        List<DailyStock> list = new ArrayList<>();
                                        list.add(new DailyStock(new Product(products[i-2]), origem, quantity, day));
                                        dailyStocks.put(day, list);
                                    }
                                    break;
                                default: break;
                            }

                        }
                    }
                }
            }
        }catch (IOException e) {
            System.out.println("The file does not exist");
        }
        }
    }