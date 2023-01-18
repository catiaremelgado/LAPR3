package model.stats;

import model.Bundle;

/**
 * the statistics of one bundle
 */
public class BundleStat {

    /**
     * number of types of product that were totally delivered in this bundle
     */
    int totallyDelivered=0;

    /**
     * number of types of products that were partially delivered in this bundle
     */
    int partDelivered=0;

    /**
     * number of types of products that were not delivered
     */
    int notDelivered=0;

    /**
     * percentage of the products that were delivered
     */
    float percentDelivered=0;

    /**
     * number of different suppliers that this bundle has
     */
    int numSuppliers=0;

    /**
     * statistics related to this bundle
     */
    Bundle bun;

    public BundleStat(Bundle bun) {
        this.bun = bun;
    }

    public void addTotallyDelivered(){
        totallyDelivered++;
    }

    public void addPartiallyDelivered(){
        partDelivered++;
    }

    public void addNotDelivered(){
        notDelivered++;
    }

    public void setPercentDelivered(float percentDelivered) {
        this.percentDelivered = percentDelivered;
    }

    public void setNumSuppliers(int numSuppliers) {
        this.numSuppliers = numSuppliers;
    }

    public int getTotallyDelivered() {
        return totallyDelivered;
    }

    public int getPartDelivered() {
        return partDelivered;
    }

    public int getNotDelivered() {
        return notDelivered;
    }

    public float getPercentDelivered() {
        return percentDelivered;
    }

    public int getNumSuppliers() {
        return numSuppliers;
    }

    public Bundle getBun() {
        return bun;
    }
}
