package model;

import java.util.Arrays;

public class WateringPlan implements Comparable<WateringPlan>{

    //where the crops are located
    private String field;

    //in minutes
    private Integer duration;

    //when does watering reoccur
    private char regularity;

    public WateringPlan(String field, Integer duration, char regularity) {
        this.field = field;
        this.duration = duration;
        this.regularity = regularity;
    }

    public String getField() {
        return field;
    }

    public void setField(String field) {
        this.field = field;
    }

    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    public char getRegularity() {
        return regularity;
    }

    public void setRegularity(char regularity) {
        this.regularity = regularity;
    }

    @Override
    public int compareTo(WateringPlan o) {
        return field.compareTo(o.field);
    }

    @Override
    public boolean equals(Object o){
        if(o instanceof WateringPlan){
            WateringPlan p=(WateringPlan) o;
            if(p.getRegularity()==regularity
                && p.getDuration()==duration
                && p.getField().equals(field))
            {
                return true;
            }
        }
        return false;
    }
}
