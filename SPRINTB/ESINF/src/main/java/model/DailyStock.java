package model;

import model.business_entities.*;

/**
 * @author alexandraipatova
 *
 * Stock of a certain product in a  day by a single supplier
 */
public class DailyStock {

    private Product product;
    private String supplier;
    private Float availableQuantity;
    private Integer day;

    public DailyStock(Product product, String supplier, Float availableQuantity, Integer day) {
        this.product = product;
        this.supplier = supplier;
        this.availableQuantity = availableQuantity;
        this.day = day;
    }

    public DailyStock() {}

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public String getSupplier() {
        return supplier;
    }

    public void setSupplier(String supplier) {
        this.supplier = supplier;
    }

    public Float getAvailableQuantity() {
        return availableQuantity;
    }

    public void setAvailableQuantity(Float availableQuantity) {
        this.availableQuantity = availableQuantity;
    }

    public Integer getDay() {
        return day;
    }

    public void setDay(Integer day) {
        this.day = day;
    }

}
