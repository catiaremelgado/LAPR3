package model;

import graph.Graph;
import model.business_entities.BusinessEntity;
import model.business_entities.Client;
import model.business_entities.Company;

import java.util.*;

import graph.Algorithms;

import java.util.ArrayList;

import fileUtils.* ;
import model.business_entities.Supplier;

import static graph.Algorithms.shortestPaths;

/**
 * This class has all the methods related to managing the information in the graph
 * and meet the requirements of the US's
 *
 * @author Diana Cardoso
 */
public class Management {

    /**
     * This method is responsible to define N hubs, with the concept of hub being a Company that has
     * paths to suppliers and clients, and the medium of the distances of those paths is the
     * smallest compared to the rest of the Companies
     *
     * @param g graph that is being worked on
     * @param N number og hubs that are going to be defined
     */
    public static void definingHubs(Graph<BusinessEntity,Integer> g, int N) {

        ArrayList<Pair<BusinessEntity,Integer>> selectedCompanies = new ArrayList<>();
        ArrayList<BusinessEntity> companies = new ArrayList<>();
        ArrayList<BusinessEntity> vertices = g.vertices();

        int i = 0;
        while (i < vertices.size()) {
            if (vertices.get(i) instanceof Company) {
                companies.add(vertices.get(i));
            }
            i++;
        }

        int j = 0;
        while (j < companies.size()) {
            ArrayList<LinkedList<BusinessEntity>> paths = new ArrayList<>();
            ArrayList<Integer> dists = new ArrayList<>();

            if (shortestPaths(g, companies.get(j), Integer::compare, Integer::sum, 0, paths, dists)) {
                i = 0;
                Integer mean = 0;
                Integer sum = 0;
                while (i < paths.size()) {
                    if (paths.get(i).size() != 0) {
                        BusinessEntity destination = paths.get(i).getLast();
                        if (!(destination instanceof Company)) {
                            paths.remove(i);
                            dists.remove(i);
                        } else {
                            i++;
                        }
                    }else{
                        i++;
                    }
                }

                i = 0;
                while (i < dists.size()) {
                    if(dists.get(i) != null) {
                        sum = sum + dists.get(i);
                    }
                    i++;
                }
                mean = sum / i;
                Pair<BusinessEntity,Integer> data = new Pair<>(companies.get(j), mean);
                selectedCompanies.add(data);
            }
            j++;
        }

        selectedCompanies.sort(new Pair.RightComparator<>());

        i = 0;
        while (i < N && i < selectedCompanies.size()){
            Pair<BusinessEntity, Integer> p  = selectedCompanies.get(i);
            BusinessEntity comp = p.getLeft();
            ((Company) comp).setHub(true);
            i++;
        }
    }

    public static boolean graphIsConnected(Graph<BusinessEntity,Integer> graph) {
        return Algorithms.isConnected(graph);
    }

    public static Graph<BusinessEntity, Integer> networkThatConnectsAll(Graph<BusinessEntity, Integer> graph){
        return Algorithms.kruskalAlgorithm(graph);
    }

    public static Company closestHub(Graph<BusinessEntity, Integer> graph,Client client) {

        BusinessEntity last = null;
        BusinessEntity ret =null;
        ArrayList<LinkedList<BusinessEntity>> paths = new ArrayList<>();
        ArrayList<Integer> dists = new ArrayList<>();


        Boolean result = Algorithms.shortestPaths(graph, client,Integer::compare,Integer::sum,0,paths,dists);

        if (result) {

            LinkedList<BusinessEntity> path = null;
            int min = -1;

            for (int i = 0; i < paths.size(); i++) {

                if (dists.get(i) != null) {

                    LinkedList<BusinessEntity> p = paths.get(i);
                    last = p.getLast();

                    if (last instanceof Company ) {
                        if(((Company) last).isHub()){
                            if (min == -1 || min == 0) {
                                min = dists.get(i).intValue();
                                path = paths.get(i);
                                ret=last;
                            } else {
                                if (min > dists.get(i).intValue()) {
                                    min = dists.get(i).intValue();
                                    path = paths.get(i);
                                    ret = paths.get(i).getLast();
                                }
                            }
                        }
                    }
                }
            }
        }
        return (Company) ret;
    }

    public static Map<Client,Company> closestClientsHubs(Graph<BusinessEntity, Integer> graph){
        Map<Client,Company> ret = new HashMap<>();
        Company company;
        Client client;
        for (int i = 0; i < graph.numVertices(); i++) {
            if (graph.vertices().get(i) instanceof Client) {
                client = (Client) graph.vertices().get(i);
                company = closestHub(graph, (Client) graph.vertices().get(i));
                if (company != null) {
                    if (company instanceof Company || company.isHub()) {
                        ret.put((Client) graph.vertices().get(i), company);
                    }
                }
            }
        }
        return ret;
    }

    /**
     *
     * @param day
     * @param clientsOrders
     * @param dailyStocks
     * @param graph
     * @return
     */
    public static ArrayList<Bundle> generateExpeditionList(int day, HashMap<Integer, List<Bundle>> clientsOrders, HashMap<Integer, List<DailyStock>> dailyStocks, Graph<BusinessEntity, Integer> graph) {
        ArrayList<Bundle> bundles = new ArrayList<>();

        // Obtém o mapa de clientes e hubs mais próximos
        Map<Client,Company> closestHubs = closestClientsHubs(graph);

        // Adiciona os pedidos de cliente à lista de expedição
        if (clientsOrders.containsKey(day)) {
            for (Bundle b : clientsOrders.get(day)) {
                String client = b.getClient();
                Company hub = null;
                // Procura o hub mais próximo para o cliente
                for (Map.Entry<Client, Company> entry : closestHubs.entrySet()) {
                    if (entry.getKey().getEntityID().equals(client)) {
                        hub = entry.getValue();
                        break;

                    }
                }
                b.setHub(hub);

                // Verifica se o produto desejado está disponível no stock
                boolean productAvailable = false;
                // Verifica se o produto está disponível nos dois dias anteriores à expedição
                for (int i = day - 2; i <= day; i++) {
                    if (dailyStocks.containsKey(i)) {
                        for (Map.Entry<Product, OrderItem> entry : b.getOrder().entrySet()) {
                            Product product = entry.getKey();
                            Float quantity = entry.getValue().getQuantityOrdered();
                            for (DailyStock ds : dailyStocks.get(i)) {
                                if (ds.getProduct().equals(product) && ds.getAvailableQuantity() >= quantity) {
                                    productAvailable = true;
                                    break;
                                }
                            }
                            if (!productAvailable) {
                                break;
                            }
                        }
                    }
                }
                if(productAvailable){
                    bundles.add(b);
                }
            }
        }
        return bundles;
    }






    //se quiseres Anna era esta a minha ideia para ambas termos uma forma de arranjar o hub de entrega, but tell me something :))
    /*public static BusinessEntity deliveryHub(){
        BusinessEntity mustPassHub = null;

        return mustPassHub;
    }*/

    public Management() {
        super();
    }

    /**
     * Method responsible for defining a daily path for the deliveries based on a daily expeditionList
     *
     * @param graph graph that is being worked on
     * @param expeditionList list of expeditions for a day
     * @return object tha contains the path, distance between each vertices of the path, total distance and number of deliveries of each hub
     */
    public static DeliveryRoute definitionDailyRout(Graph<BusinessEntity, Integer> graph, List<Bundle> expeditionList){

        TreeMap<Product,OrderItem> order;
        ArrayList<LinkedList<BusinessEntity>> pathsSup = new ArrayList<>();
        ArrayList<Integer> dists = new ArrayList<>();
        ArrayList<LinkedList<BusinessEntity>> pathsHub = new ArrayList<>();
        ArrayList<Integer> distsHub = new ArrayList<>();

        ArrayList<BusinessEntity> mustPassSup = new ArrayList<>();
        ArrayList<BusinessEntity> mustPassHub = new ArrayList<>();
        int flag = 0;

        //variables tha will have the final result information
        LinkedList<BusinessEntity> path = new LinkedList<>();
        Integer totalDist = 0;
        DeliveryRoute rout;
        ArrayList<Integer> weights = new ArrayList<>();
        ArrayList<Pair<BusinessEntity, Integer>> hubDeliv = new ArrayList<>();

        if(expeditionList.size() != 0) {
            //process of acquiring all the suppliers that the path must pass by
            int i = 0;
            int n;
            while (i < expeditionList.size()) {
                //selection of the clients hub and the clients order
                Company deliveryHub = expeditionList.get(i).getHub();
                flag = 0;

                for (int p = 0; p < hubDeliv.size(); p++) {
                    if (hubDeliv.get(p).getLeft() == deliveryHub) {
                        n = hubDeliv.get(p).getRight();
                        n = n + 1;
                        hubDeliv.get(p).setRight(n);
                        flag = 1;
                    }
                }

                if (flag == 0) {
                    n = 1;
                    hubDeliv.add(new Pair(deliveryHub, n));
                }

                order = expeditionList.get(i).getOrder();

                if (!mustPassHub.contains(deliveryHub)) {
                    mustPassHub.add(deliveryHub);
                }
                for (Map.Entry<Product, OrderItem> orders : order.entrySet()) {
                    Supplier sup = orders.getValue().getSupplier();
                    if (!mustPassSup.contains(sup) && sup != null) {
                        mustPassSup.add(sup);
                    }
                }
                i++;
            }
            //Selection of the weights
            if(mustPassSup.size() != 0 && mustPassHub.size() != 0) {
                shortestPathPossible(graph, mustPassSup, pathsSup, dists);
                i = 0;
                while (i < pathsSup.size()) {
                    int j = 0;
                    while (j < pathsSup.get(i).size() && j + 1 < pathsSup.get(i).size()) {
                        BusinessEntity vert1 = pathsSup.get(i).get(j);
                        BusinessEntity vert2 = pathsSup.get(i).get(j + 1);
                        weights.add(graph.edge(vert1, vert2).getWeight());
                        j++;
                    }
                    i++;
                }

                mustPassHub.add(0, pathsSup.get(pathsSup.size() - 1).getLast());
                Algorithms.shortestPathWithMustPass(graph, mustPassHub, Integer::compare, Integer::sum, 0, pathsHub, distsHub);
                i = 0;
                //Selection of the weights
                while (i < pathsHub.size()) {
                    int j = 0;
                    while (j < pathsHub.get(i).size() && j + 1 < pathsHub.get(i).size()) {
                        BusinessEntity vert1 = pathsHub.get(i).get(j);
                        BusinessEntity vert2 = pathsHub.get(i).get(j + 1);
                        weights.add(graph.edge(vert1, vert2).getWeight());
                        j++;
                    }
                    i++;
                }

                //Condenses the paths in one list
                i = 0;
                while (i < pathsHub.size()) {
                    pathsSup.add(pathsHub.get(i));
                    i++;
                }

                //Makes the path one single list
                i = 0;
                while (i < pathsSup.size() - 1) {
                    pathsSup.get(i).removeLast();
                    path.addAll(pathsSup.get(i));
                    i++;
                }

                path.addAll(pathsSup.get(i));

                //Calculating the total distance
                i = 0;
                while (i < weights.size()) {
                    totalDist = totalDist + weights.get(i);
                    i++;
                }

                rout = new DeliveryRoute(path, weights, totalDist, hubDeliv);
                return rout;
            }
            return null;
        }
        return null;
    }

    /**
     * Method to find the shortests paths within a list that passes by all the vertices in the list
     *
     * @param g graph
     * @param pass list of must pass vertices
     * @param paths list of the paths
     * @param dists list of the distances
     */
    public static boolean shortestPathPossible(Graph<BusinessEntity, Integer> g, ArrayList<BusinessEntity> pass, ArrayList<LinkedList<BusinessEntity>> paths, ArrayList<Integer> dists){

            int flag = 0;
            ArrayList<Integer> dist = new ArrayList<>();
            ArrayList<LinkedList<BusinessEntity>> path = new ArrayList<>();

            int mindist = 0;
            int totalDist = 0;

            if (pass.size() > 0) {
                BusinessEntity original = pass.get(0);
                BusinessEntity orige = original;
                while (flag == 0) {
                    dist.clear();
                    path.clear();
                    //definition of the shortest path that passes through all the suppliers
                    Algorithms.shortestPathWithMustPass(g, pass, Integer::compare, Integer::sum, 0, path, dist);

                    int i = 0;
                    while (i < dist.size()) {
                        totalDist = totalDist + dist.get(i);
                        i++;
                    }

                    if (mindist == 0 || mindist > totalDist) {
                        mindist = totalDist;
                        paths.removeAll(paths);
                        paths.addAll(path);
                        dists.removeAll(dists);
                        dists.addAll(dist);
                    }

                    pass.add(pass.size(), orige);
                    pass.remove(0);
                    orige = pass.get(0);

                    if (orige == original) {
                        flag = 1;
                    }
                }
                return true;
            }
            return false;
    }

    /**
     * Method to find the N closest Suppliers to a certain Hub
     * @param graph given graph
     * @param hub given hub to seek closest suppliers
     * @param N total number of closest suppliers to find
     * @return an Array List will the N closest Suppliers to a certain Hub
     */
    public static ArrayList<Supplier> findingSuppliersCloseToHub(Graph<BusinessEntity,Integer> graph, Company hub, int N) {

        // array list that will have all suppliers and their distance to the hub
        ArrayList<Pair<BusinessEntity,Integer>> selectedSuppliers = new ArrayList<>();
        // list that will have all suppliers
        ArrayList<BusinessEntity> suppliers = graph.vertices();

        // remove all non Suppliers from list
        int i = 0;
        while (i < suppliers.size()) {
            if (!(suppliers.get(i) instanceof Supplier)) {
                suppliers.remove(suppliers.get(i));
                i--;
            }
            i++;
        }

        int j = 0;
        while (j < suppliers.size()) {
            ArrayList<LinkedList<BusinessEntity>> paths = new ArrayList<>();
            ArrayList<Integer> dists = new ArrayList<>();

            if (shortestPaths(graph, suppliers.get(j), Integer::compare, Integer::sum, 0, paths, dists)) {
                i = 0;
                Integer sum = 0;
                while (i < paths.size()) {
                    if (paths.get(i).size() != 0) {
                        BusinessEntity destination = paths.get(i).getLast();
                        if (destination != hub) {
                            paths.remove(i);
                            dists.remove(i);
                        } else {
                            i++;
                        }
                    }else{
                        i++;
                    }
                }

                i = 0;
                while (i < dists.size()) {
                    if(dists.get(i) != null) {
                        sum = sum + dists.get(i);
                    }
                    i++;
                }
                Pair<BusinessEntity,Integer> data = new Pair<>(suppliers.get(j), sum);
                selectedSuppliers.add(data);
            }
            j++;
        }

        selectedSuppliers.sort(new Pair.RightComparator<>());

        i = 0;
        ArrayList<Supplier> finalSuppliers = new ArrayList<>();
        if (selectedSuppliers.size() != 0) {

            if (N > selectedSuppliers.size()){
                System.out.println("Existem menos produtores que o pretendido (pretendido = " + N + ", existentes = " + selectedSuppliers.size() + "), por isso serão considerados apenas os existentes.");
            }

            while (i < N && i < selectedSuppliers.size()) {
                finalSuppliers.add((Supplier) selectedSuppliers.get(i).getLeft());
                i++;
            }

            return finalSuppliers;
        } else {
            System.out.println("Não existem produtores.");
            return null;
        }
    }

    /**
     * Method to find the closest Hub to a certain Client
     * @param graph given graph
     * @param client given Client to seek closest Hub
     * @return The closest Hub to the Client or Null if there are no Hubs in the graph
     */
    public static Company findingClientClosestHub(Graph<BusinessEntity,Integer> graph, Client client) {

        // array list that will have all hubs and their distance to the hub
        ArrayList<Pair<BusinessEntity, Integer>> selectedSuppliers = new ArrayList<>();
        // list that will have all hubs
        ArrayList<BusinessEntity> hubs = graph.vertices();

        // remove all non hubs from list
        int i = 0;
        while (i < hubs.size()) {
            BusinessEntity current = hubs.get(i);
            if (!(current instanceof Company)) {
                hubs.remove(current);
                i--;
            } else {
                Company myHub = (Company) hubs.get(i);
                if (!myHub.isHub()) {
                    hubs.remove(myHub);
                    i--;
                }
            }
            i++;
        }

        int j = 0;
        while (j < hubs.size()) {
            ArrayList<LinkedList<BusinessEntity>> paths = new ArrayList<>();
            ArrayList<Integer> dists = new ArrayList<>();

            if (shortestPaths(graph, hubs.get(j), Integer::compare, Integer::sum, 0, paths, dists)) {
                i = 0;
                Integer sum = 0;
                while (i < paths.size()) {
                    if (paths.get(i).size() != 0) {
                        BusinessEntity destination = paths.get(i).getLast();
                        if (destination != client) {
                            paths.remove(i);
                            dists.remove(i);
                        } else {
                            i++;
                        }

                    } else {
                        i++;
                    }
                }

                i = 0;
                while (i < dists.size()) {
                    if (dists.get(i) != null) {
                        sum = sum + dists.get(i);
                    }
                    i++;
                }
                Pair<BusinessEntity, Integer> data = new Pair<>(hubs.get(j), sum);
                selectedSuppliers.add(data);
            }
            j++;
        }

        if (selectedSuppliers.size() != 0) {

            selectedSuppliers.sort(new Pair.RightComparator<>());
            return (Company) selectedSuppliers.get(0).getLeft();

        } else {
            System.out.println("Não existem hubs.");
            return null;
        }
    }

    /**
     * Method to see ia a graph has at least one Hub
     * @param graph given graph to analise
     * @return true if there's at least one Hub or false otherwise
     */
    public static boolean atLeastOneHubExists (Graph<BusinessEntity,Integer> graph) {
        ArrayList<BusinessEntity> hubs = graph.vertices();
        int i = 0;
        while (i < hubs.size()) {
            BusinessEntity current = hubs.get(i);
            if (!(current instanceof Company)) {
                hubs.remove(current);
                i--;
            } else {
                Company myHub = (Company) hubs.get(i);
                if (!myHub.isHub()) {
                    hubs.remove(myHub);
                    i--;
                }
            }
            i++;
        }

        return hubs.size() > 0;
    }

    public static List<Bundle> expeditionListWithRestrictions(HashMap<Integer, List<Bundle>> clientsOrders, HashMap<Integer, List<DailyStock>> dailyStocks, Graph<BusinessEntity, Integer> graph, Integer day, Integer N) {
        List<Bundle> currentDayList = clientsOrders.get(day);

        if (currentDayList != null) {
            if (atLeastOneHubExists(graph)) {
                // verify if pretended day has orders
                if (currentDayList == null) {
                    System.out.println("Não há pedidos para o dia " + day + ".");
                    return null;
                }

                // verify if at least day, day-1 or day-2 has stock registered
                if (!(dailyStocks.containsKey(day) || dailyStocks.containsKey(day - 1) || dailyStocks.containsKey(day - 2))) {
                    System.out.println("There are no stocks to do an expedition list for the day " + day + ".");
                    return currentDayList; //will return list with all deliveries at 0
                }

                //start to fill the deliveries
                for (int i = 0; i < currentDayList.size(); i++) {
                    Bundle currentBundle = currentDayList.get(i);
                    Client currentClient = new Client(new Location("0", 0.0F, 0.0F), currentBundle.getClient());
                    Company clientsHub = findingClientClosestHub(graph, currentClient);
                    currentDayList.get(i).setHub(clientsHub);

                    ArrayList<Supplier> autorizedSuppliers = findingSuppliersCloseToHub(graph, clientsHub, N);
                    if (autorizedSuppliers != null) {
                        DailyStock bestStock = new DailyStock();

                        int j = day - 2;
                        int positonInDailyStock = 888;
                        List<OrderItem> currentOrderList = new ArrayList<>(currentBundle.getOrder().values());

                        for (int z = 0; z < currentOrderList.size(); z++) {
                            OrderItem currentOrder = currentOrderList.get(z);
                            Float quantityOrdered = currentOrder.getQuantityOrdered();
                            Float quantityFound = 0.0F;
                            Product product = currentOrder.getProduct();
                            while (j <= day) {
                                List<DailyStock> stockDay = dailyStocks.get(j);
                                if (stockDay != null) {
                                    for (int a = 0; a < stockDay.size(); a++) {
                                        DailyStock verifyingStock = stockDay.get(a);
                                        for (int b = 0; b < autorizedSuppliers.size(); b++) {
                                            if (autorizedSuppliers.get(b).getEntityID().equals(verifyingStock.getSupplier())) {
                                                if (verifyingStock.getProduct().equals(product)) {
                                                    if (quantityFound < verifyingStock.getAvailableQuantity() && quantityOrdered != 0.0F) {
                                                        quantityFound = verifyingStock.getAvailableQuantity();
                                                        bestStock = verifyingStock;
                                                        positonInDailyStock = a;
                                                        if (quantityFound >= quantityOrdered) {
                                                            j = 20;
                                                            a = stockDay.size() + 1;
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                j++;
                            }

                            if (bestStock.getProduct() != null) {
                                if (currentDayList.get(i).getOrder().get(product).getQuantityOrdered() < bestStock.getAvailableQuantity()) {
                                    currentDayList.get(i).getOrder().get(product).setQuantityDelivered(currentDayList.get(i).getOrder().get(product).getQuantityOrdered());
                                    currentDayList.get(i).getOrder().get(product).setSupplier(new Supplier(new Location("0", 0.0F, 0.0F), bestStock.getSupplier()));
                                    dailyStocks.get(bestStock.getDay()).get(positonInDailyStock).setAvailableQuantity(bestStock.getAvailableQuantity() - currentDayList.get(i).getOrder().get(product).getQuantityDelivered());

                                } else {
                                    currentDayList.get(i).getOrder().get(product).setQuantityDelivered(bestStock.getAvailableQuantity());
                                    currentDayList.get(i).getOrder().get(product).setSupplier(new Supplier(new Location("0", 0.0F, 0.0F), bestStock.getSupplier()));
                                    dailyStocks.get(bestStock.getDay()).get(positonInDailyStock).setAvailableQuantity(0.0F);

                                }
                            }
                            j = day - 2;
                        }
                    }
                }
                return currentDayList;
            } else {
                System.out.println("Não existem hubs, impossível fazer entregas.");
                return null;
            }
        } else {
            System.out.println("Não existem pedidos para o dia pedido.");
            return null;
        }
    }
}
