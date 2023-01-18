package model.stats;

/**
 * stats related to one client
 */
public class ClientStat {

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
    int numDifSuppliers=0;

    /**
     * client to which the stats relate to
     */
    String client;

    public ClientStat(String client) {
        this.client = client;
    }

    public void addTotallyDelivered(){
        totallyDeliveredBundles++;
    }

    public void addPartiallyDelivered(){
        partDeliveredBundles++;
    }

    public void setNumSuppliers(int numDifSuppliers) {
        this.numDifSuppliers = numDifSuppliers;
    }

    public int getTotallyDeliveredBundles() {
        return totallyDeliveredBundles;
    }

    public int getPartDeliveredBundles() {
        return partDeliveredBundles;
    }

    public int getNumDifSuppliers() {
        return numDifSuppliers;
    }

    public String getClient() {
        return client;
    }
}
