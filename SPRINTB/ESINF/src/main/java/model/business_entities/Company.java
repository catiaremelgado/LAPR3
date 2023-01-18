package model.business_entities;

import model.*;
/**
 * @author alexandraipatova
 *
 * Business entity that buys products and is a distribuition hub
 */
public class Company extends Client{

    private boolean isHub=false;

    public Company(Location location,String entityID) {
        super(location,entityID);
    }

    public Company(Company company){
        super(company.getLocation(),company.getEntityID());

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

    public boolean isHub() {
        return isHub;
    }

    public void setHub(boolean hub) {
        isHub = hub;
    }
}
