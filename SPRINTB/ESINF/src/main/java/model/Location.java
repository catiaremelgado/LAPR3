package model;

import java.awt.geom.Point2D;

/**
 * @author alexandraipatova
 *
 * Geographical location in the world map
 */
public class Location implements Comparable<Location>{

    private String LocID;
    private Point2D.Float coords;

    public Location(String locID,Float lat,Float lng) {
        LocID = locID;
        this.coords = new Point2D.Float(lat,lng);
    }

    public Location(String locID) {
        LocID = locID;
    }

    public String getLocID() {
        return LocID;
    }

    public Float getLat() {
        return coords.x;
    }

    public Float getLng() {
        return coords.y;
    }

    public void setLocID(String locID) {
        LocID = locID;
    }

    public void setCoords(Float lat,Float lng) {
        this.coords.setLocation(lat,lng);
    }
    @Override
    public int compareTo(Location o) {
        return this.LocID.compareTo(o.getLocID());
    }
}
