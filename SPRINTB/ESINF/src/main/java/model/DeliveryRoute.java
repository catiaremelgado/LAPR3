package model;

import fileUtils.Pair;
import model.business_entities.BusinessEntity;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Objects;

/**
 * Class responsible to combine the necessary data related to a daily delivery route
 *
 * @author Diana Cardoso
 */
public class DeliveryRoute {

    private LinkedList<BusinessEntity> path;
    private ArrayList<Integer> dist;
    private Integer totalDistance;
    private ArrayList<Pair<BusinessEntity, Integer>> hubDeliveries;

    /**
     *
     * @param path path for the day
     * @param dist distance of each vertice
     * @param totalDistance total distance of the path
     * @param hubDeliveries delivery hubs and number of deliveries in each delivery hub
     */
    public DeliveryRoute(LinkedList<BusinessEntity> path, ArrayList<Integer> dist, Integer totalDistance, ArrayList<Pair<BusinessEntity, Integer>> hubDeliveries) {
        this.path = path;
        this.dist = dist;
        this.totalDistance = totalDistance;
        this.hubDeliveries = hubDeliveries;
    }

    public LinkedList<BusinessEntity> getPath() {
        return path;
    }

    public ArrayList<Integer> getDist() {
        return dist;
    }

    public Integer getTotalDistance() {
        return totalDistance;
    }

    public ArrayList<Pair<BusinessEntity, Integer>> getHubDeliveries() {
        return hubDeliveries;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!(o instanceof DeliveryRoute)) return false;
        DeliveryRoute that = (DeliveryRoute) o;
        return Objects.equals(path, that.path) && Objects.equals(dist, that.dist) &&
                Objects.equals(totalDistance, that.totalDistance) && Objects.equals(hubDeliveries, that.hubDeliveries);
    }

}
