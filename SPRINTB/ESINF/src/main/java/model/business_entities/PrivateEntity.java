package model.business_entities;

import model.Location;

/**
 * @author alexandraipatova
 *
 * Business entity that buys products and is private
 */

public class PrivateEntity extends Client{


    public PrivateEntity(Location location,String entityID) {
        super(location,entityID);
    }

    @Override
    public int compareTo(BusinessEntity o) {
        return super.compareTo(o);
    }

    @Override
    public boolean equals(Object o) {
        return super.equals(o);
    }

    @Override
    public int hashCode() {
        return super.hashCode();
    }
}
