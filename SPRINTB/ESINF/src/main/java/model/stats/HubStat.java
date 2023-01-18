package model.stats;

import model.business_entities.Company;

/**
 * stats relating to a hub
 */
public class HubStat {

    /**
     * number of sold out types of products this supplier has sold
     */
    int numDifClients=0;

    /**
     * number of different hubs to which the supplier has delivered to
     */
    int numDifSuppliers=0;


    /**
     * hub that is referred in the statistics
     */
    Company hub;

    public HubStat(Company hub) {
        this.hub = hub;
    }

    public int getNumDifClients() {
        return numDifClients;
    }

    public void setNumDifClients(int numDifClients) {
        this.numDifClients = numDifClients;
    }

    public int getNumDifSuppliers() {
        return numDifSuppliers;
    }

    public void setNumDifSuppliers(int numDifSuppliers) {
        this.numDifSuppliers = numDifSuppliers;
    }
}
