package model;
import model.business_entities.BusinessEntity;
import model.business_entities.Company;

import java.util.TreeMap;

/**
 * @author alexandraipatova
 * Bundle of several products from several suppliers that have been ordered by a client
 */
public class Bundle {

    private TreeMap<Product,OrderItem> order;
    private String client;
    private int expeditionDate;

    private Company hub;


    /**
     *
     * @param order products that have been ordered
     * @param client client that purchases products in bundle
     * @param expeditionDate date that the bundle will be shipped
     */
    public Bundle(TreeMap<Product,OrderItem> order, String client, int expeditionDate) {
        this.order = order;
        this.client = client;
        this.expeditionDate = expeditionDate;
    }

    public Bundle( String client, int expeditionDate) {
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


    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }

    public int getExpeditionDate() {
        return expeditionDate;
    }

    public Company getHub() {
        return hub;
    }

    public void setExpeditionDate(int expeditionDate) {
        this.expeditionDate = expeditionDate;
    }

    public void setHub(Company hub) {
        this.hub = hub;
    }
}
