package graph;

import graph.map.MapGraph;
import model.business_entities.Company;
import model.business_entities.PrivateEntity;
import graph.matrix.MatrixGraph;

import java.lang.reflect.Array;
import java.util.*;
import java.util.function.BinaryOperator;

/**
 * @author DEI-ISEP
 */
public class Algorithms {

    /**
     * Performs breadth-first search of a Graph starting in a vertex
     *
     * @param g    Graph instance
     * @param vert vertex that will be the source of the search
     * @return a LinkedList with the vertices of breadth-first search
     */
    public static <V,E> LinkedList<V> BreadthFirstSearch(Graph<V,E> g, V vert) {

        LinkedList<V> result = new LinkedList<>();
        Queue<V> aux = new ArrayDeque<>();
        ArrayList<V> notVisited = g.vertices();
        Collection<V> adjacentVertices;

        if (g.validVertex(vert)) {
            result.add(vert);
            aux.add(vert);
            notVisited.remove(vert);
            while (!aux.isEmpty()) {
                vert = aux.remove();
                adjacentVertices = g.adjVertices(vert);
                if (adjacentVertices != null) {
                    for (V adjVert : adjacentVertices)
                        if (notVisited.contains(adjVert)) {
                            result.add(adjVert);
                            aux.add(adjVert);
                            notVisited.remove(adjVert);
                        }
                }
            }
            return result;
        }
        return null;
    }

    /**
     * Performs depth-first search starting in a vertex
     *
     * @param g          Graph instance
     * @param vOrig      vertex of graph g that will be the source of the search
     * @param notVisited set of unvisited vertices
     * @param qdfs       return LinkedList with vertices of depth-first search
     */
    private static <V,E> void DepthFirstSearch(Graph<V,E> g, V vOrig, ArrayList<V> notVisited, LinkedList<V> qdfs) {

        Collection<V> adjacentVertices;

        if (g.validVertex(vOrig)) {
            if (!notVisited.contains(vOrig)) {
                return;
            }
            qdfs.add(vOrig);
            notVisited.remove(vOrig);
            adjacentVertices = g.adjVertices(vOrig);
            if (adjacentVertices != null) {
                for (V adjVert : adjacentVertices) {
                    DepthFirstSearch(g, adjVert, notVisited, qdfs);
                }
            }
        }
    }

    /**
     * Performs depth-first search starting in a vertex
     *
     * @param g    Graph instance
     * @param vert vertex of graph g that will be the source of the search
     * @return a LinkedList with the vertices of depth-first search
     */
    public static <V,E> LinkedList<V> DepthFirstSearch(Graph<V,E> g, V vert) {
        ArrayList<V> notVisited = g.vertices();
        LinkedList<V> qdfs = new LinkedList<>();
        DepthFirstSearch(g, vert, notVisited, qdfs);
        if (qdfs.isEmpty()) {
            return null;
        }
        return qdfs;
    }

    /**
     * Returns all paths from vOrig to vDest
     *
     * @param g       Graph instance
     * @param vOrig   Vertex that will be the source of the path
     * @param vDest   Vertex that will be the end of the path
     * @param visited set of discovered vertices
     * @param path    stack with vertices of the current path (the path is in reverse order)
     * @param paths   ArrayList with all the paths (in correct order)
     */
    private static <V,E> void allPaths(Graph<V,E> g, V vOrig, V vDest, boolean[] visited,
                                        LinkedList<V> path, ArrayList<LinkedList<V>> paths) {

        ArrayList<V> listVertices = g.vertices();
        Collection<V> adjacentVertices;
        int counter = 0;
        if (g.validVertex(vOrig)) {
            path.addFirst(vOrig);
            visited[listVertices.indexOf(vOrig)] = true;
            adjacentVertices = g.adjVertices(vOrig);
            if (adjacentVertices != null) {
                for (V vAdj : adjacentVertices) {
                    if (vAdj.equals(vDest)) {
                        path.addFirst(vDest);
                        paths.add((LinkedList<V>) path.clone());
                        path.pop();
                    } else if (!visited[listVertices.indexOf(vAdj)])
                        allPaths(g, vAdj, vDest, visited, path, paths);
                }
                path.pop();
            }
        }
    }

    /**
     * Returns all paths from vOrig to vDest
     *
     * @param g     Graph instance
     * @param vOrig information of the Vertex origin
     * @param vDest information of the Vertex destination
     * @return paths ArrayList with all paths from vOrig to vDest
     */
    public static <V,E> ArrayList<LinkedList<V>> allPaths(Graph<V,E> g, V vOrig, V vDest) {

        boolean[] visited = new boolean[g.numVertices()];
        LinkedList<V> path = new LinkedList<>();
        ArrayList<LinkedList<V>> paths = new ArrayList<>();
        ArrayList<V> listVertices = g.vertices();
        int counter = 0;

        for (V vert : listVertices) {
            visited[counter] = false;
            counter++;
        }
        allPaths(g, vOrig, vDest, visited, path, paths);
        if (paths.isEmpty()) {
            return null;
        }
        return paths;
    }

    /**
     * Since it uses a greedy design, the solution may not always be optimal
     * Computes shortest-path distance from a source vertex to all reachable
     * vertices of a graph g with non-negative edge weights
     * This implementation uses Dijkstra's algorithm
     *
     * @param g        Graph instance
     * @param vOrig    Vertex that will be the source of the path
     * @param visited  set of previously visited vertices
     * @param pathKeys minimum path vertices keys
     * @param dist     minimum distances
     */
    public static <V,E> void shortestPathDijkstra(Graph<V,E> g, V vOrig,
                                                   Comparator<E> ce, BinaryOperator<E> sum, E zero,
                                                   boolean[] visited, V[] pathKeys, E[] dist) {

        ArrayList<V> listVertices = g.vertices();
        Collection<V> adjacentVertices;
        int counter = 0;

        E infinit = zero;

        for (Edge<V, E> edge : g.edges()) {
            infinit = sum.apply(infinit, edge.getWeight());
        }
        for (V vert : listVertices) {
            dist[counter] = infinit;
            pathKeys[counter] = null;
            visited[counter] = false;
            counter++;
        }
        dist[listVertices.indexOf(vOrig)] = zero;
        if (g.validVertex(vOrig)) {


            while (vOrig != null) {

                visited[listVertices.indexOf(vOrig)] = true;
                adjacentVertices = g.adjVertices(vOrig);

                for (V vAdj : adjacentVertices) {
                    Edge<V, E> edge = g.edge(vOrig, vAdj);
                    if (!visited[listVertices.indexOf(vAdj)] && (ce.compare(sum.apply(dist[listVertices.indexOf(vOrig)], edge.getWeight()), dist[listVertices.indexOf(vAdj)]) < 0)) {
                        dist[listVertices.indexOf(vAdj)] = sum.apply(dist[listVertices.indexOf(vOrig)], edge.getWeight());
                        pathKeys[listVertices.indexOf(vAdj)] = vOrig;
                    }
                }
                try {
                    vOrig = getVertMinDist(visited, dist, ce, listVertices, infinit);
                } catch (IndexOutOfBoundsException e) {
                    vOrig = null;
                }
            }
        }
    }


    /**
     * Shortest-path between two vertices
     *
     * @param g         graph
     * @param vOrig     origin vertex
     * @param vDest     destination vertex
     * @param ce        comparator between elements of type E
     * @param sum       sum two elements of type E
     * @param zero      neutral element of the sum in elements of type E
     * @param shortPath returns the vertices which make the shortest path
     * @return returns the Length of the shortest-path
     */
    public static <V,E> E shortestPath(Graph<V,E> g, V vOrig, V vDest,
                                        Comparator<E> ce, BinaryOperator<E> sum, E zero,
                                        LinkedList<V> shortPath) {

        shortPath.clear();                                 //clear the last shortPath
        boolean[] visited = new boolean[g.numVertices()];

        V[] pathKeys;
        E[] dist;
        if(vOrig instanceof Company || vOrig instanceof PrivateEntity){
            pathKeys = (V[]) Array.newInstance(vOrig.getClass().getSuperclass().getSuperclass(), g.numVertices());
            dist = (E[]) Array.newInstance(zero.getClass().getSuperclass().getSuperclass(), g.numVertices());
        }else  {
            pathKeys = (V[]) Array.newInstance(vOrig.getClass().getSuperclass(), g.numVertices());
            dist = (E[]) Array.newInstance(zero.getClass().getSuperclass(), g.numVertices());
        }
        E distance = null;

        shortestPathDijkstra(g, vOrig, ce, sum, zero, visited, pathKeys, dist);

        int keyDest = g.key(vDest);

        if (keyDest != -1 && visited[keyDest]) {
            getPath(g, vOrig, vDest, pathKeys, shortPath);
            distance = dist[keyDest];
        }
        return distance;
    }

    /**
     * Shortest-paths between a vertex and all other vertices
     *
     * @param g     graph
     * @param vOrig start vertex
     * @param ce    comparator between elements of type E
     * @param sum   sum two elements of type E
     * @param zero  neutral element of the sum in elements of type E
     * @param paths returns all the minimum paths
     * @param dists returns the corresponding minimum distances
     * @return if vOrig exists in the graph true, false otherwise
     */
    public static <V,E> boolean shortestPaths(Graph<V,E> g, V vOrig, Comparator<E> ce, BinaryOperator<E> sum, E zero, ArrayList<LinkedList<V>> paths, ArrayList<E> dists) {

        if (g.validVertex(vOrig)) {
            ArrayList<V> verticies = g.vertices();
            for (int i = 0; i < verticies.size(); i++) {
                E dist;
                LinkedList<V> path = new LinkedList<>();
                dist = shortestPath(g, vOrig, verticies.get(i), ce, sum, zero, path);
                paths.add(g.key(verticies.get(i)), path);
                dists.add(g.key(verticies.get(i)), dist);
            }
            return true;
        }
        return false;
    }

    /**
     * Method to find the shortest path that passes through certain vertices.
     *
     * @param g graph
     * @param pass list of the vertices that the path must pass
     * @param ce comparator between elements of type E
     * @param sum sum two elements of type E
     * @param zero neutral element of the sum in elements of type E
     * @param paths returns all the minimum paths
     * @param dists returns the corresponding minimum distances
     * @return if the process is completed returns true
     */
    public static <V,E> boolean shortestPathWithMustPass(Graph<V,E> g, ArrayList<V> pass, Comparator<E> ce, BinaryOperator<E> sum, E zero, ArrayList<LinkedList<V>> paths, ArrayList<E> dists) {

        ArrayList<V> mustPass = (ArrayList<V>) pass.clone();
        int j = 0;
        V vOrig = mustPass.get(j);
        mustPass.remove(0);

        while(mustPass.size() > 0) {
            E minDist = null;
            LinkedList<V> minPath = new LinkedList<>();
            E dist;

            for (int i = 0; i < mustPass.size(); i++) {
                LinkedList<V> path = new LinkedList<>();

                if (g.validVertex(vOrig)) {
                    dist = shortestPath(g, vOrig, mustPass.get(i), ce, sum, zero, path);
                    if (minDist == null || ce.compare(dist, minDist) < 0) {
                        minDist = dist;
                        minPath = path;
                    }

                } else {
                    return false;
                }
            }

            paths.add(minPath);
            dists.add(minDist);

            vOrig = paths.get(j).getLast();
            mustPass.remove(vOrig);
            j++;
        }

        return true;
    }

    /**
     * Gets the vertex with minimum distance to origin vertex
     *
     * @param visited set of previously visited vertices
     * @param dist    minimum distances
     * @param ce      comparator for E type
     * @param index   list of all vertices
     * @param <V>     Vertex
     * @param <E>     Distance unit
     * @return vertex with minimum distance to origin
     */

    public static <V,E> V getVertMinDist(boolean[] visited, E[] dist, Comparator<E> ce, ArrayList<V> index, E infinit) {
        V smallestVert = null;
        E smallestWeight = infinit;

        for (int i = 0; i < dist.length; i++) {
            if (!visited[i]) {
                if (ce.compare(smallestWeight, dist[i]) > 0) {
                    smallestVert = index.get(i);
                    smallestWeight = dist[i];
                }
            }
        }
        return smallestVert;
    }

    /**
     * Extracts from pathKeys the minimum path between voInf and vdInf
     * The path is constructed from the end to the beginning
     *
     * @param g        Graph instance
     * @param vOrig    information of the Vertex origin
     * @param vDest    information of the Vertex destination
     * @param pathKeys minimum path vertices keys
     * @param path     stack with the minimum path (correct order)
     */
    public static <V,E> void getPath(Graph<V,E> g, V vOrig, V vDest,
                                      V[] pathKeys, LinkedList<V> path) {
        ArrayList<V> listVertices = g.vertices();

        V nextVertex = pathKeys[listVertices.indexOf(vDest)];
        if (nextVertex != null) {
            path.add(vDest);
            path.add(nextVertex);
            while (!nextVertex.equals(vOrig)) {
                nextVertex = pathKeys[listVertices.indexOf(nextVertex)];
                path.add(nextVertex);

            }
        } else {
            path.add(vDest);
        }

        Collections.reverse(path);

        /*int keyDest = g.key(vDest);

        do {
            path.add(g.vertex(keyDest));
            keyDest = g.key(pathKeys[keyDest]);
        } while (keyDest != -1 && pathKeys[keyDest] != null);*/

    }

    /**
     * Calculates the minimum distance graph using Floyd-Warshall
     * Complexity = O^3
     *
     * @param g   initial graph
     * @param ce  comparator between elements of type E
     * @param sum sum two elements of type E
     * @return the minimum distance graph
     */
    public static <V,E> MatrixGraph<V, E> minDistGraph(Graph<V,E> g, Comparator<E> ce, BinaryOperator<E> sum) {

        if (g.numVertices() == 0) {
            return null;
        }
        @SuppressWarnings("unchecked")
        //colocar os pesos do grafo numa matriz para a manipular
        E[][] weightsMatrix = (E[][]) new Object[g.numVertices()][g.numVertices()];     //criamos uma nova matriz para colocar os pesos do grafo nela, ou seja criamos uma matriz do Tipo edge
        for (int i = 0; i < g.numVertices(); i++) {
            for (int j = 0; j < g.numVertices(); j++) {
                Edge<V, E> edge = g.edge(i, j);
                if (edge != null) {
                    weightsMatrix[i][j] = edge.getWeight();
                }
            }
        }

        //floyd-Warshall algorithm O^3
        for (int k = 0; k < g.numVertices(); k++) {
            for (int i = 0; i < g.numVertices(); i++) {
                if (i != k && weightsMatrix[i][k] != null) {
                    for (int j = 0; j < g.numVertices(); j++) {
                        if (i != j && k != j && weightsMatrix[k][j] != null) {
                            E s = sum.apply(weightsMatrix[i][k], weightsMatrix[k][j]);
                            if (weightsMatrix[i][j] == null || ce.compare(weightsMatrix[i][j], s) > 0) {
                                weightsMatrix[i][j] = s;
                            }
                        }
                    }
                }
            }
        }
        return new MatrixGraph<>(g.isDirected(), g.vertices(), weightsMatrix);
    }

    /**
     * Calculates the longest shortest distance graph using Floyd-Warshall
     * @param g
     * @param ce
     * @param sum
     * @param zero
     * @return
     */
    public static <V,E> E diameterGraph(Graph<V,E> g, Comparator<E> ce, BinaryOperator<E> sum, E zero) {
        E diameter = zero;
        MatrixGraph<V,E> matrixGraph = minDistGraph(g, ce, sum);
        for (int i = 0; i < matrixGraph.numVertices(); i++) {
            for (int j = 0; j < matrixGraph.numVertices(); j++) {
                if (matrixGraph.edge(i, j) != null) {
                    if (ce.compare(diameter, matrixGraph.edge(i, j).getWeight()) < 0) {
                        diameter = matrixGraph.edge(i, j).getWeight();
                    }
                }
            }
        }
        return diameter;
    }

    /**
     * Method to verify if a given graph is connected or not
     *
     * @param g given graph
     * @return true if grahp is connected, false otherwise
     */
    public static <V,E> boolean isConnected(Graph<V,E> g) {
        ArrayList<V> allVertices = g.vertices();
        LinkedList<V> depthFirstSearch = new LinkedList<>();
        DepthFirstSearch(g, allVertices.get(0), allVertices, depthFirstSearch);

        if (allVertices.size() != 0) {
            return false;
        }

        return true;
    }

    /**
     * Method to crate a MST og a given graph
     * @param orig given graph
     * @param <V>     Vertex
     * @param <E>     Distance unit
     * @return the MST of the given graph or null if given graph is non connected
     */
    public static <V,E> Graph<V, E> kruskalAlgorithm(Graph<V,E> orig) {

        if (isConnected(orig)) {
            ArrayList<V> allVertices = orig.vertices();
            Graph<V, E> mst = new MapGraph<>(false);

            for (int i = 0; i < allVertices.size(); i++)
                mst.addVertex(allVertices.get(i));

            List<Edge<V, E>> allEdges = (List<Edge<V, E>>) orig.edges();
            Collections.sort(allEdges, new Edge.weightComparator());

            for (Edge e : allEdges) {
                if (allPaths(mst, (V) e.getVOrig(), (V) e.getVDest()) == null) {
                    mst.addEdge((V) e.getVOrig(), (V) e.getVDest(), (E) e.getWeight());
                }
            }

            return mst;
        }
        return null;
    }

}