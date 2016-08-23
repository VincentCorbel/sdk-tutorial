package android.connecthings.com.tuto.alert.firstWay;

import android.connecthings.adtag.model.sdk.BeaconAlertStrategyParameter;
import android.connecthings.adtag.model.sdk.BeaconAlertStrategyParameterProximity;
import android.connecthings.adtag.model.sdk.BeaconContent;
import android.connecthings.util.BEACON_PROXIMITY;
import android.connecthings.util.adtag.beacon.strategy.Alert.Listener.BeaconAlertStrategyListener;


public class TimeAlertStrategy implements BeaconAlertStrategyListener{

    private final int maxTimeBeforeReset;
    private final long timeToCreateAlert;
    public static final String ALERT_STRATEGY = "timeAlertStrategy";

    public TimeAlertStrategy(int maxTimeBeforeReset, long timeToCreateAlert) {

        this.timeToCreateAlert = timeToCreateAlert + System.currentTimeMillis();
        this.maxTimeBeforeReset = maxTimeBeforeReset;
    }

    @Override
    public void updateBeaconContent(BeaconContent beacon) {
        BeaconAlertStrategyParameter strategyParameter = beacon.getBeaconAlertStrategyParameter();
        if (strategyParameter==null){
            strategyParameter = createBeaconAlertParameter();
            beacon.setBeaconAlertStrategyParameter(strategyParameter);
        }

        strategyParameter.setIsConditionValid(isConditionValid(beacon.getBeaconAlertStrategyParameter()));
        if(strategyParameter.getActionStatus()== BeaconAlertStrategyParameter.BeaconActionStatus.DONE){
            testToResetActionIsDone(strategyParameter);
        }
        strategyParameter.setIsReadyForAction(isReadyForAction(beacon.getBeaconAlertStrategyParameter()));
        //Update each cycle -> means only a beacon that we don't see for more than maxTimeBeforeReset will be impact
        strategyParameter.setMaxTimeBeforeResetingActionDone(System.currentTimeMillis() + maxTimeBeforeReset);
    }

    public void testToResetActionIsDone(BeaconAlertStrategyParameter strategyParameter){
        if((!strategyParameter.isConditionValid())
                || strategyParameter.getMaxTimeBeforeResetingActionDone() < System.currentTimeMillis()){
            strategyParameter.setActionStatus(BeaconAlertStrategyParameter.BeaconActionStatus.WAITING_FOR_ACTION);
        }
    }

    @Override
    public BeaconAlertStrategyParameter createBeaconAlertParameter() {
        //You can create Object that extend the BeaconAlertStrategyParameter to save more information
        return  new BeaconAlertStrategyParameter();
    }

    @Override
    public String getStrategyKey() {
        return ALERT_STRATEGY;
    }

    @Override
    public boolean isConditionValid(BeaconAlertStrategyParameter beaconAlertStrategyParameter) {
        return System.currentTimeMillis() >= timeToCreateAlert;
    }

    @Override
    public boolean isReadyForAction(BeaconAlertStrategyParameter beaconAlertStrategyParameter) {
        return beaconAlertStrategyParameter.getActionStatus() == BeaconAlertStrategyParameter.BeaconActionStatus.WAITING_FOR_ACTION && beaconAlertStrategyParameter.isConditionValid();
    }

    @Override
    public void updateAlertParameter(BeaconContent beaconContent) {
       //not necesseray in that case
    }


}
