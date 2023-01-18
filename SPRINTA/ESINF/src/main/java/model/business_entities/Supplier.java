package model.business_entities;

import model.Location;
import model.business_entities.BusinessEntity;

/**
 * @author alexandraipatova
 *
 * Business entity that makes and supplies products
 */
public class Supplier extends BusinessEntity {



    public Supplier(Location location,String entityID) {
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
