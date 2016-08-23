package android.connecthings.com.tuto.alert.secondWay;

import android.connecthings.adtag.model.sdk.BeaconAlertStrategyParameter;
import android.connecthings.adtag.model.sdk.BeaconAlertStrategyParameterProximity;
import android.connecthings.adtag.model.sdk.BeaconContent;
import android.connecthings.util.BEACON_PROXIMITY;
import android.connecthings.util.adtag.beacon.strategy.Alert.BeaconAlertStrategy;
import android.connecthings.util.adtag.beacon.strategy.Alert.Listener.BeaconAlertStrategyListener;


public class TimeAlertStrategy extends BeaconAlertStrategy{

    private final int maxTimeBeforeReset;
    private final long timeToCreateAlert;
    public static final String ALERT_STRATEGY = "timeAlertStrategy";

    public TimeAlertStrategy(int maxTimeBeforeReset, long timeToCreateAlert) {
        super(maxTimeBeforeReset);
        this.timeToCreateAlert = timeToCreateAlert + System.currentTimeMillis();
        this.maxTimeBeforeReset = maxTimeBeforeReset;
    }


    @Override
    public BeaconAlertStrategyParameter createBeaconAlertParameter() {
        return  new BeaconAlertStrategyParameterProximity();
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
    public void updateAlertParameter(BeaconContent beaconContent) {
       //no specific update needs

    }

}


