package model;

import org.junit.jupiter.api.Test;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.TreeMap;

import static org.junit.Assert.*;

public class WateringConfigurationTest {
    @Test
    public void testIsCurrentlyWateringRegular(){

        ArrayList<LocalTime> wateringCycleHour=new ArrayList<>();
        ArrayList<WateringPlan> wateringPlans=new ArrayList<>();
        wateringCycleHour.add(LocalTime.of(8,30));
        wateringCycleHour.add(LocalTime.of(17,0));
        WateringPlan plan=new WateringPlan("a",10,'t');
        wateringPlans.add(plan);
        WateringPlan plan1=new WateringPlan("b",12,'p');
        wateringPlans.add(plan1);
        WateringPlan plan2=new WateringPlan("c",12,'i');
        wateringPlans.add(plan2);
        WateringPlan plan3=new WateringPlan("d",5,'t');
        wateringPlans.add(plan3);
        WateringPlan plan4=new WateringPlan("e",8,'i');
        wateringPlans.add(plan4);
        WateringConfiguration wc=new WateringConfiguration(30,wateringPlans,wateringCycleHour);
        TreeMap<WateringPlan,Integer> wexpected= new TreeMap<>();
        wexpected.put(plan,8);
        wexpected.put(plan1,10);
        wexpected.put(plan2,0);
        wexpected.put(plan3,3);
        wexpected.put(plan4,0);
        TreeMap<WateringPlan,Integer> w=wc.isCurrentlyWatering(LocalDateTime.of(2003,4,2,8,32));
        assertEquals(wexpected,w);
    }

    @Test
    public void testIsCurrentlyWateringNoValues(){

        ArrayList<LocalTime> wateringCycleHour=new ArrayList<>();
        ArrayList<WateringPlan> wateringPlans=new ArrayList<>();
        wateringCycleHour.add(LocalTime.of(8,30));
        wateringCycleHour.add(LocalTime.of(17,0));
        WateringPlan plan=new WateringPlan("a",10,'t');
        wateringPlans.add(plan);
        WateringPlan plan1=new WateringPlan("b",12,'p');
        wateringPlans.add(plan1);
        WateringPlan plan2=new WateringPlan("c",12,'i');
        wateringPlans.add(plan2);
        WateringPlan plan3=new WateringPlan("d",5,'t');
        wateringPlans.add(plan3);
        WateringPlan plan4=new WateringPlan("e",8,'i');
        wateringPlans.add(plan4);
        WateringConfiguration wc=new WateringConfiguration(30,wateringPlans,wateringCycleHour);
        TreeMap<WateringPlan,Integer> wexpected= new TreeMap<>();
        wexpected.put(plan,0);
        wexpected.put(plan1,0);
        wexpected.put(plan2,0);
        wexpected.put(plan3,0);
        wexpected.put(plan4,0);
        TreeMap<WateringPlan,Integer> w=wc.isCurrentlyWatering(LocalDateTime.of(2003,4,2,8,50));
        assertEquals(wexpected,w);
    }

    @Test
    public void testIsCurrentlyWateringNotEven(){

        ArrayList<LocalTime> wateringCycleHour=new ArrayList<>();
        ArrayList<WateringPlan> wateringPlans=new ArrayList<>();
        wateringCycleHour.add(LocalTime.of(8,30));
        wateringCycleHour.add(LocalTime.of(17,0));
        WateringPlan plan=new WateringPlan("a",10,'t');
        wateringPlans.add(plan);
        WateringPlan plan1=new WateringPlan("b",12,'p');
        wateringPlans.add(plan1);
        WateringPlan plan2=new WateringPlan("c",12,'i');
        wateringPlans.add(plan2);
        WateringPlan plan3=new WateringPlan("d",5,'t');
        wateringPlans.add(plan3);
        WateringPlan plan4=new WateringPlan("e",8,'i');
        wateringPlans.add(plan4);
        WateringConfiguration wc=new WateringConfiguration(30,wateringPlans,wateringCycleHour);
        TreeMap<WateringPlan,Integer> wexpected= new TreeMap<>();
        wexpected.put(plan,8);
        wexpected.put(plan1,0);
        wexpected.put(plan2,10);
        wexpected.put(plan3,3);
        wexpected.put(plan4,6);
        TreeMap<WateringPlan,Integer> w=wc.isCurrentlyWatering(LocalDateTime.of(2003,4,3,8,32));
        assertEquals(wexpected,w);
    }

    @Test
    public void testIsCurrentlyWateringStartOfWatering(){

        ArrayList<LocalTime> wateringCycleHour=new ArrayList<>();
        ArrayList<WateringPlan> wateringPlans=new ArrayList<>();
        wateringCycleHour.add(LocalTime.of(8,30));
        wateringCycleHour.add(LocalTime.of(17,0));
        WateringPlan plan=new WateringPlan("a",10,'t');
        wateringPlans.add(plan);
        WateringPlan plan1=new WateringPlan("b",12,'p');
        wateringPlans.add(plan1);
        WateringPlan plan2=new WateringPlan("c",12,'i');
        wateringPlans.add(plan2);
        WateringPlan plan3=new WateringPlan("d",5,'t');
        wateringPlans.add(plan3);
        WateringPlan plan4=new WateringPlan("e",8,'i');
        wateringPlans.add(plan4);
        WateringConfiguration wc=new WateringConfiguration(30,wateringPlans,wateringCycleHour);
        TreeMap<WateringPlan,Integer> wexpected= new TreeMap<>();
        wexpected.put(plan,10);
        wexpected.put(plan1,0);
        wexpected.put(plan2,12);
        wexpected.put(plan3,5);
        wexpected.put(plan4,8);
        TreeMap<WateringPlan,Integer> w=wc.isCurrentlyWatering(LocalDateTime.of(2003,4,3,17,0));
        assertEquals(wexpected,w);
    }

    @Test
    public void testIsCurrentlyWateringNull(){

        ArrayList<LocalTime> wateringCycleHour=new ArrayList<>();
        ArrayList<WateringPlan> wateringPlans=new ArrayList<>();
        wateringCycleHour.add(LocalTime.of(8,30));
        wateringCycleHour.add(LocalTime.of(17,0));
        WateringPlan plan=new WateringPlan("a",10,'t');
        wateringPlans.add(plan);
        WateringPlan plan1=new WateringPlan("b",12,'p');
        wateringPlans.add(plan1);
        WateringPlan plan2=new WateringPlan("c",12,'i');
        wateringPlans.add(plan2);
        WateringPlan plan3=new WateringPlan("d",5,'t');
        wateringPlans.add(plan3);
        WateringPlan plan4=new WateringPlan("e",8,'i');
        wateringPlans.add(plan4);
        WateringConfiguration wc=new WateringConfiguration(30,wateringPlans,wateringCycleHour);
        TreeMap<WateringPlan,Integer> w=wc.isCurrentlyWatering(null);
        assertNull(w);
    }
}
