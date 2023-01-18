package examples.map;

import graph.*;
import graph.map.MapGraph;

import java.util.*;

/**
 *
 * @author DEI-ESINF
 *
 */
public class AirportNet {

    private static class Route {
        public final int passengers;
        public final double miles;

        public Route(int passengers, double miles) {
            this.passengers = passengers;
            this.miles = miles;
        }
    }

    final private Graph<String, Route> airports;

    public AirportNet(){
        airports=new MapGraph<>(true);
    }

    public void addAirport(String a){
        airports.addVertex(a);
    }

    public void addRoute(String a1, String a2, double miles, Integer passengers){
        airports.addEdge(a1,a2,new Route(passengers,miles));
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public int keyAirport(String airport){
        return airports.key(airport);
    }

    public String airportbyKey(int key){
        ArrayList<String> vertices= airports.vertices();
        if(key<0||key>=vertices.size()){
            return null;
        }
        return vertices.get(key);
    }

    public Integer trafficAirports(String airp1, String airp2){

        Integer pass=0;

        Edge<String,Route> edg1=airports.edge(airp1,airp2);
        Edge<String,Route> edg2=airports.edge(airp2,airp1);

        if(edg1!=null){
            pass=edg1.getWeight().passengers;
        }
        if(edg2!=null){
            pass=edg2.getWeight().passengers;
        }
        return pass;
    }

    public Double milesAirports(String airp1, String airp2){
        Edge<String,Route> edg1=airports.edge(airp1,airp2);
        if(edg1==null){
            return null;
        }
        return edg1.getWeight().miles;
    }

    public Map<String,Integer> nroutesAirport(){

        Map<String,Integer> m=new HashMap<>();

        for (String airp:airports.vertices()){
            int grau=airports.outDegree(airp)+airports.inDegree(airp);
            m.put(airp,grau);
        }
        return m;
    }

    public List<ArrayList<String>> airpMaxMiles( ){ //max value of all edges (not generic)

        //list of pair of airport and route
        List<ArrayList<String>> max= new ArrayList<>();
        double maxMiles=Double.MIN_VALUE;
        for (Edge<String,Route> edg:airports.edges()){
            if(maxMiles<=edg.getWeight().miles){
                if(maxMiles<edg.getWeight().miles){
                    maxMiles=edg.getWeight().miles;
                    max.clear();
                }
                max.add(new ArrayList<String>(Arrays.asList(edg.getVOrig(),String.valueOf(edg.getWeight().miles))));
            }
        }
        return max;

    }


    public Boolean connectAirports(String airport1, String airport2){//o algoritmo de caminho minimo entre dois pode ser utilizado

        if(!airports.validVertex(airport1) || !airports.validVertex(airport2)) return false;

        LinkedList<String> qairps=Algorithms.DepthFirstSearch(airports,airport1);
        return qairps.contains(airport2);
        
    }

    @Override
    public String toString() {
        return airports.toString();
    }
}