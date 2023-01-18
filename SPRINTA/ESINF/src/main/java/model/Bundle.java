package model;
import model.business_entities.BusinessEntity;

import java.util.TreeMap;

/**
 * @author alexandraipatova
 * Bundle of several products from several suppliers that have been ordered by a client
 */
public class Bundle {

    private TreeMap<Product,OrderItem> order;
    private BusinessEntity mainSupplier;
    private BusinessEntity client;
    private String expeditionDate;

    /**
     *
     * @param order products that have been ordered
     * @param mainSupplier supplier of the bundle
     * @param client client that purchases products in bundle
     * @param expeditionDate date that the bundle will be shipped
     */
    public Bundle(TreeMap<Product,OrderItem> order, BusinessEntity mainSupplier, BusinessEntity client, String expeditionDate) {
        this.order = order;
        this.mainSupplier = mainSupplier;
        this.client = client;
        this.expeditionDate = expeditionDate;
    }

    public Bundle(BusinessEntity mainSupplier, BusinessEntity client, String expeditionDate) {
        this.mainSupplier = mainSupplier;
        this.client = client;
        this.expeditionDate = expeditionDate;
        this.order=new TreeMap<>();
    }

    public TreeMap<Product, OrderItem> getOrder() {
        return order;
    }

    public OrderItem getOrderItem(Product product) {
        return order.get(product);
    }

    public void setOrder(TreeMap<Product, OrderItem> order) {
        this.order = order;
    }

    public BusinessEntity getMainSupplier() {
        return mainSupplier;
    }

    public void setMainSupplier(BusinessEntity mainSupplier) {
        this.mainSupplier = mainSupplier;
    }

    public BusinessEntity getClient() {
        return client;
    }

    public void setClient(BusinessEntity client) {
        this.client = client;
    }

    public String getExpeditionDate() {
        return expeditionDate;
    }

    public void setExpeditionDate(String expeditionDate) {
        this.expeditionDate = expeditionDate;
    }
}
