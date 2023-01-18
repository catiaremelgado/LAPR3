package model.business_entities;

import model.Location;

import java.util.Objects;

/**
 * @author alexandraipatova
 *
 *
 * a business entity that participates in a business transaction
 */
public abstract class BusinessEntity implements Comparable <BusinessEntity>{


    private Location location;

    private String entityID;

    /**
     *
     * @param location location of entity
     * @param entityID ID of entity
     */
    public BusinessEntity(Location location,String entityID) {
        this.location = location;
        this.entityID = entityID;
    }


    public Location getLocation() {return location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

    public String getEntityID() {
        return entityID;
    }

    public void setEntityID(String entityID) {
        this.entityID = entityID;
    }

    /**
     * compares by entity ID
     * @param o other entity
     * @return int that represents comparation
     */
    @Override
    public int compareTo(BusinessEntity o) {
        return entityID.compareTo(o.getEntityID());
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof BusinessEntity)) return false;
        BusinessEntity that = (BusinessEntity) o;
        return this.getEntityID().equals(that.getEntityID());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getEntityID());
    }
}
