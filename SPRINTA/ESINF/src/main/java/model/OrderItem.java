package model;

import model.business_entities.Supplier;

/**
 * @author alexandraipatova
 *
 * An item in an order
 */
public class OrderItem implements Comparable<OrderItem>{

    private Supplier supplier;
    private Integer quantityOrdered;
    private Integer quantityDelivered = 0;

    public OrderItem(Supplier supplier,Integer quantityOrdered) {
        this.supplier = supplier;
        this.quantityOrdered = quantityOrdered;
    }


    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public Integer getQuantityOrdered() {
        return quantityOrdered;
    }

    public void setQuantityOrdered(Integer quantityOrdered) {
        this.quantityOrdered = quantityOrdered;
    }

    public Integer getQuantityDelivered() {
        return quantityDelivered;
    }

    public void setQuantityDelivered(Integer quantityDelivered) {
        this.quantityDelivered = quantityDelivered;
    }

    @Override
    public int compareTo(OrderItem o) {
        return this.quantityOrdered.compareTo(o.quantityOrdered);
    }
}
