package model.stats;

import model.*;
import model.business_entities.Company;
import model.business_entities.Supplier;

import java.util.*;


/**
 * statistics methods relating to bundles
 */
public class Statistics {

    /**
     * calculates the list of statistics for each bundle
     * @param bundles list of bundles to be expedited
     * @return  list of statistics for each bundle
     */
    public static List<BundleStat> getBundleStats(List<Bundle> bundles){

        List<BundleStat> lbs=new ArrayList<>();
        TreeMap<Product,OrderItem> order= new TreeMap<>();
        Set<Supplier> supplierSet=new HashSet<>();

        float totalOrdered=0;
        float totalDelivered=0;

        BundleStat bs;

        for (Bundle bun: bundles){
            order=bun.getOrder();
            bs=new BundleStat(bun);

            for (Map.Entry<Product, OrderItem> item : order.entrySet()) {

                if(item.getValue().getQuantityOrdered().equals(item.getValue().getQuantityDelivered()) && item.getValue().getQuantityOrdered()!=0) {
                    bs.addTotallyDelivered();
                }else if(item.getValue().getQuantityDelivered()==0){
                    bs.addNotDelivered();
                }else{
                    bs.addPartiallyDelivered();
                }

                totalOrdered+=item.getValue().getQuantityOrdered();
                totalDelivered+=item.getValue().getQuantityDelivered();
                supplierSet.add(item.getValue().getSupplier());
            }

            if(totalOrdered!=0){
                bs.setPercentDelivered(totalDelivered/totalOrdered);
            }

            bs.setNumSuppliers(supplierSet.size());
            supplierSet=new HashSet<>();
            totalOrdered=0;
            totalDelivered=0;
            lbs.add(bs);
        }

        return lbs;

    }

    /**
     * calculates the list of statistics for each client
     * @param bundles list of bundles to be expedited
     * @return  list of statistics for each client
     */

    public static List<ClientStat> getClientStats(List<Bundle> bundles){

        List<ClientStat> lcs=new ArrayList<>();
        TreeMap<String,Set<Supplier>> suppliers= new TreeMap<>();
        TreeMap<String,ClientStat> stats= new TreeMap<>();
        TreeMap<Product,OrderItem> order= new TreeMap<>();
        boolean flagTotallyDelivered=true;
        boolean flagPartiallyDelivered=false;
        ClientStat cs;

        for (Bundle bun: bundles){
            order=bun.getOrder();
            cs=new ClientStat(bun.getClient());

            stats.putIfAbsent(bun.getClient(), cs); //O(B*log(n))
            suppliers.computeIfAbsent(bun.getClient(), k -> new HashSet<>());

            for (Map.Entry<Product, OrderItem> item : order.entrySet()) {

                if(!item.getValue().getQuantityOrdered().equals(item.getValue().getQuantityDelivered())) {
                    flagTotallyDelivered=false;
                }

                if(item.getValue().getSupplier()!=null && item.getValue().getQuantityDelivered()!=0){
                    suppliers.get(bun.getClient()).add(item.getValue().getSupplier());
                }

            }

            if(!flagTotallyDelivered && suppliers.get(bun.getClient())!=null){
                flagPartiallyDelivered=true;
            }

            if(flagTotallyDelivered && !flagPartiallyDelivered){
                stats.get(bun.getClient()).addTotallyDelivered();
            }else if(flagPartiallyDelivered && !flagTotallyDelivered){
                stats.get(bun.getClient()).addPartiallyDelivered();
            }

            stats.get(bun.getClient()).setNumSuppliers(suppliers.get(bun.getClient()).size());
            flagPartiallyDelivered=false;
            flagTotallyDelivered=true;

        }

        for (Map.Entry<String, ClientStat> stat : stats.entrySet()) {
            lcs.add(stat.getValue());
        }

        return lcs;
    }

    /**
     * calculates the list of statistics for each supplier
     * @param bundles list of bundles to be expedited
     * @return  list of statistics for each supplier
     */

    public static List<SupplierStat> getSupplierStats(List<Bundle> bundles,HashMap<Integer,List<DailyStock>> originalStockList,HashMap<Integer,List<DailyStock>> alteredStockList){

        int dayOfExpedition=bundles.get(0).getExpeditionDate();
        List<List<DailyStock>> alteredStock=new ArrayList<>();
        List<List<DailyStock>> stock=new ArrayList<>();

        for (int i = 0; i < 3; i++) {
            if(dayOfExpedition>i){
                alteredStock.add(alteredStockList.get(dayOfExpedition-i));
                stock.add(originalStockList.get(dayOfExpedition-i));
            }
        }

        List<SupplierStat> lss=new ArrayList<>();
        Set<Supplier> bundleSuppliers=new HashSet<>();
        TreeMap<Supplier,Set<String>> clients= new TreeMap<>();
        TreeMap<Supplier,Set<Company>> hubs= new TreeMap<>();
        TreeMap<Supplier,SupplierStat> stats= new TreeMap<>();
        TreeMap<Product,OrderItem> order= new TreeMap<>();
        boolean flagPartiallyDelivered=false;
        SupplierStat ss;
        Supplier previousSupplier=null;

        for (Bundle bun: bundles){
            order=bun.getOrder();

            for (Map.Entry<Product, OrderItem> item : order.entrySet()) {

                if(item.getValue().getSupplier()!=null){

                    ss=new SupplierStat(item.getValue().getSupplier());
                    bundleSuppliers.add(item.getValue().getSupplier());
                    stats.putIfAbsent(item.getValue().getSupplier(), ss);
                    clients.putIfAbsent(item.getValue().getSupplier(), new HashSet<>());
                    hubs.putIfAbsent(item.getValue().getSupplier(), new HashSet<>());
                    if(!ss.getSupplier().equals(previousSupplier) && previousSupplier!=null) {
                        flagPartiallyDelivered=true;
                    }

                    clients.get(item.getValue().getSupplier()).add(bun.getClient());
                    hubs.get(item.getValue().getSupplier()).add(bun.getHub());
                    previousSupplier=item.getValue().getSupplier();
                }
            }

           if(!flagPartiallyDelivered){
                stats.get(previousSupplier).addTotallyDelivered();
            }else{
               for (Supplier item : bundleSuppliers) {
                   stats.get(item).addPartiallyDelivered();
               }
           }
           bundleSuppliers=new HashSet<>();
           flagPartiallyDelivered=false;
        }

        for (int i = 0; i < alteredStock.size(); i++) {
            for (int j = 0; j < alteredStock.get(i).size(); j++) {
                if(!alteredStock.get(i).get(j).getAvailableQuantity().equals(stock.get(i).get(j).getAvailableQuantity())){
                    if(alteredStock.get(i).get(j).getAvailableQuantity()==0){
                        stats.get(new Supplier(new Location("",0f,0f),alteredStock.get(i).get(j).getSupplier())).addSoldOutProduct();
                    }
                }
            }
        }

        for (Map.Entry<Supplier, SupplierStat> stat : stats.entrySet()) {
            stat.getValue().setNumDifClients(clients.get(stat.getKey()).size());
            stat.getValue().setNumDifHubs(hubs.get(stat.getKey()).size());
            lss.add(stat.getValue());
        }

        return lss;
    }

    /**
     * calculates the list of statistics for each hub
     * @param bundles list of bundles to be expedited
     * @return  list of statistics for each hub
     */
    public static List<HubStat> getHubStats(List<Bundle> bundles){

        List<HubStat> lhs=new ArrayList<>();
        TreeMap<Company,Set<String>> clients= new TreeMap<>();
        TreeMap<Company,Set<Supplier>> suppliers= new TreeMap<>();
        TreeMap<Company,HubStat> stats= new TreeMap<>();
        TreeMap<Product,OrderItem> order= new TreeMap<>();
        HubStat hs;

        for (Bundle bun: bundles){

            order=bun.getOrder();
            hs=new HubStat(bun.getHub());
            stats.putIfAbsent(bun.getHub(), hs);
            clients.putIfAbsent(bun.getHub(), new HashSet<>());
            suppliers.putIfAbsent(bun.getHub(), new HashSet<>());

            clients.get(bun.getHub()).add(bun.getClient());

            for (Map.Entry<Product, OrderItem> item : order.entrySet()) {

                if(item.getValue().getSupplier()!=null){
                    suppliers.get(bun.getHub()).add(item.getValue().getSupplier());
                }
            }
        }

        for (Map.Entry<Company, HubStat> stat : stats.entrySet()) {
            stat.getValue().setNumDifClients(clients.get(stat.getKey()).size());
            stat.getValue().setNumDifSuppliers(suppliers.get(stat.getKey()).size());
            lhs.add(stat.getValue());
        }

        return lhs;
    }

}
