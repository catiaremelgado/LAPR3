package model;

import model.business_entities.Supplier;

/**
 * @author alexandraipatova
 *
 * An item in an order
 */
public class OrderItem implements Comparable<OrderItem>{

    private Supplier supplier = null;
    private Product product;
    private Float quantityOrdered;
    private Float quantityDelivered = 0.0f;

    public OrderItem(Product product, Float quantityOrdered) {
        this.product = product;
        this.quantityOrdered = quantityOrdered;
    }

    public OrderItem(Supplier supplier, Product product, Float quantityOrdered) {
        this(product, quantityOrdered);
        this.supplier = supplier;
    }


    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public Float getQuantityOrdered() {
        return quantityOrdered;
    }

    public void setQuantityOrdered(Float quantityOrdered) {
        this.quantityOrdered = quantityOrdered;
    }

    public Float getQuantityDelivered() {
        return quantityDelivered;
    }

    public void setQuantityDelivered(Float quantityDelivered) {
        this.quantityDelivered = quantityDelivered;
    }

    public Product getProduct() {
        return product;
    }

    @Override
    public int compareTo(OrderItem o) {
        return this.quantityOrdered.compareTo(o.quantityOrdered);
    }
}
