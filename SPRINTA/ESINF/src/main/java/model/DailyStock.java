package model;

import model.business_entities.*;

/**
 * @author alexandraipatova
 *
 * Stock of a certain product in a  day by a single supplier
 */
public class DailyStock {

    private Product product;
    private Supplier supplier;
    private Integer availableQuantity;
    private Integer day;

    public DailyStock(Product product, Supplier supplier, Integer availableQuantity, Integer day) {
        this.product = product;
        this.supplier = supplier;
        this.availableQuantity = availableQuantity;
        this.day = day;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public Integer getAvailableQuantity() {
        return availableQuantity;
    }

    public void setAvailableQuantity(Integer availableQuantity) {
        this.availableQuantity = availableQuantity;
    }

    public Integer getDay() {
        return day;
    }

    public void setDay(Integer day) {
        this.day = day;
    }
}
