package model;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.TreeMap;

public class WateringConfiguration {

    private Integer planDuration;

    ArrayList<LocalTime> wateringCycleHour;

    ArrayList<WateringPlan> fieldWateringPlan;

    public WateringConfiguration(Integer planDuration) {
        this.planDuration = planDuration;
        this.fieldWateringPlan=new ArrayList<>();
        this.wateringCycleHour=new ArrayList<>();
    }

    public WateringConfiguration(Integer planDuration, ArrayList<WateringPlan> fieldWateringPlan) {
        this.planDuration = planDuration;
        this.fieldWateringPlan = (ArrayList<WateringPlan>) fieldWateringPlan.clone();
    }

    public WateringConfiguration(Integer planDuration, ArrayList<WateringPlan> wateringPlans, ArrayList<LocalTime> wateringCycleHour) {
        this.planDuration = planDuration;
        this.fieldWateringPlan = (ArrayList<WateringPlan>) wateringPlans.clone();
        this.wateringCycleHour = (ArrayList<LocalTime>) wateringCycleHour.clone();
    }

    public Integer getPlanDuration() {
        return planDuration;
    }

    public void setPlanDuration(Integer planDuration) {
        this.planDuration = planDuration;
    }

    public void setWateringCycleHour(ArrayList<LocalTime> wateringCycleHour) {
        this.wateringCycleHour = wateringCycleHour;
    }

    public void setFieldWateringPlan(ArrayList<WateringPlan> fieldWateringPlan) {
        this.fieldWateringPlan = fieldWateringPlan;
    }

    public ArrayList<LocalTime> getWateringCycleHour() {
        return wateringCycleHour;
    }

    public ArrayList<WateringPlan> getFieldWateringPlan() {
        return fieldWateringPlan;
    }

    public boolean addFieldWateringPlan(WateringPlan plan) {
        return fieldWateringPlan.add(plan);
    }
    public boolean removeFieldWateringPlan(WateringPlan plan) {
        return fieldWateringPlan.remove(plan);
    }
    public int getIndexFieldWateringPlan(WateringPlan plan) {
        return fieldWateringPlan.indexOf(plan);
    }

    public WateringPlan getFieldWateringPlanByIndex(int index) {
        return fieldWateringPlan.get(index);
    }

    public boolean addWateringCycleHour(LocalTime hour) {
        return wateringCycleHour.add(hour);
    }
    public boolean removeWateringCycleHour(LocalTime hour) {
        return wateringCycleHour.remove(hour);
    }
    public int getIndexWateringCycleHour(LocalTime hour) {
        return wateringCycleHour.indexOf(hour);
    }

    /**
     * checks which fields are being watered at date and time
     * @param dateTime date and time to check if fields are being wateres
     * @return treemap with fields and time remaining for watering to end
     */
    public TreeMap<WateringPlan,Integer> isCurrentlyWatering(LocalDateTime dateTime){

        if(dateTime!=null){
            LocalTime time=dateTime.toLocalTime();
            LocalDate date=dateTime.toLocalDate();
            LocalTime wateringEndTime;
            Duration duration;
            boolean isEven=false;
            TreeMap<WateringPlan,Integer> isWatering=new TreeMap<>();

            boolean flag=false;
            if(date.getDayOfMonth()%2==0){
                isEven=true;
            }

            for (int i = 0; i < fieldWateringPlan.size() ; i++) {

                if (fieldWateringPlan.get(i).getRegularity() == 't' || (fieldWateringPlan.get(i).getRegularity() == 'p' && isEven) || (fieldWateringPlan.get(i).getRegularity() == 'i' && !isEven)) {

                    wateringEndTime=checkIfInWateringHour(time,fieldWateringPlan.get(i).getDuration());

                    if(wateringEndTime!=null){
                        duration=Duration.between(time,wateringEndTime);
                        isWatering.put(fieldWateringPlan.get(i),duration.toMinutesPart());
                    }else{
                        isWatering.put(fieldWateringPlan.get(i),0);
                    }

                } else {
                    isWatering.put(fieldWateringPlan.get(i),0);
                }

            }

            if(!isWatering.isEmpty()){
                return isWatering;
            }

            return null;
            }
        return null;


    }

    /**
     * checks if in this time a certains field with a certain duration is being watered
     *
     * @param time time to check
     * @param fieldDuration duration of watering of a field
     * @return end time of watering;
     */
    private LocalTime checkIfInWateringHour(LocalTime time,Integer fieldDuration){

        int i=0;
        LocalTime timeOfWatering=null;
        boolean flag =false;
        while (i<wateringCycleHour.size() && !flag)
        {
            if((wateringCycleHour.get(i).isBefore(time)|| wateringCycleHour.get(i).equals(time))&& wateringCycleHour.get(i).plusMinutes(fieldDuration.longValue()).isAfter(time)){
                flag=true;
                timeOfWatering=wateringCycleHour.get(i).plusMinutes(fieldDuration.longValue());

            }
            i++;
        }
        return timeOfWatering;
    }

    @Override
    public boolean equals(Object o){
        if(o instanceof WateringConfiguration){
            WateringConfiguration w=(WateringConfiguration) o;
            if(w.getPlanDuration().equals(planDuration)
                && Arrays.equals(wateringCycleHour.toArray(),(w.getWateringCycleHour().toArray()))
                && Arrays.equals(fieldWateringPlan.toArray(),(w.getFieldWateringPlan().toArray())))
            {
                return true;
            }
        }
        return false;
    }
}
