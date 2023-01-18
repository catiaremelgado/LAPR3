package model.business_entities;

import model.Location;

/**
 * @author alexandraipatova
 *
 * Business entity that buys products
 */
public class Client extends BusinessEntity{


    public Client(Location location,String entityID) {
        super(location, entityID);
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
