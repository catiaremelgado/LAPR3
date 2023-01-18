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
                        if (!(destination instanceof Supplier || destination instanceof Client)) {
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
        while (i < N){
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
}
