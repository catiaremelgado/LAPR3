package model.stats;

import model.business_entities.Supplier;

/**
 * statistics related to suppliers
 */
public class SupplierStat {

    /**
     * number of types of product that were totally delivered in this bundle
     */
    int totallyDeliveredBundles=0;

    /**
     * number of types of products that were partially delivered in this bundle
     */
    int partDeliveredBundles=0;

    /**
     * number of different suppliers that this bundle has
     */
    int numDifClients=0;

    /**
     * number of sold out types of products this supplier has sold
     */
    int numSoldOutProds=0;

    /**
     * number of different hubs to which the supplier has delivered to
     */
    int numDifHubs=0;

    /**
     * the supplier that has these stats
     */
    Supplier supplier;

    public SupplierStat(Supplier supplier) {
        this.supplier = supplier;
    }

    public void addTotallyDelivered(){
        totallyDeliveredBundles++;
    }

    public void addPartiallyDelivered(){
        partDeliveredBundles++;
    }

    public void addSoldOutProduct(){
        numSoldOutProds++;
    }

    public void setNumDifClients(int numDifClients) {
        this.numDifClients = numDifClients;
    }

    public void setNumDifHubs(int numDifHubs) {
        this.numDifHubs = numDifHubs;
    }

    public int getTotallyDeliveredBundles() {
        return totallyDeliveredBundles;
    }

    public int getPartDeliveredBundles() {
        return partDeliveredBundles;
    }

    public int getNumDifClients() {
        return numDifClients;
    }

    public int getNumSoldOutProds() {
        return numSoldOutProds;
    }

    public int getNumDifHubs() {
        return numDifHubs;
    }

    public Supplier getSupplier() {
        return supplier;
    }
}
