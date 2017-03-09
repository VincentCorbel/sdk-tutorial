package android.connecthings.com.tuto.alert;

import android.os.SystemClock;

import com.connecthings.adtag.model.sdk.BeaconAlertStrategyParameter;
import com.connecthings.adtag.model.sdk.BeaconContent;
import com.connecthings.util.adtag.beacon.strategy.alert.BeaconAlertStrategy;


public class TimeAlertStrategySecondWay extends BeaconAlertStrategy{

    public static final String ALERT_STRATEGY = "timeAlertStrategy";

    private final long timeBeforeCreatingAlert;

    public TimeAlertStrategySecondWay(int maxTimeBeforeReset, long timeBeforeCreatingAlert) {
        super(maxTimeBeforeReset);
        this.timeBeforeCreatingAlert = timeBeforeCreatingAlert;
    }

    @Override
    public Class<? extends BeaconAlertStrategyParameter> getBeaconAlertParameterClass() {
        return TimeAlertStrategyParameter.class;
    }

    @Override
    public String getStrategyKey() {
        return ALERT_STRATEGY;
    }

    @Override
    public boolean isConditionValid(BeaconAlertStrategyParameter beaconAlertStrategyParameter) {
        TimeAlertStrategyParameter timeAlertStrategyParameter = (TimeAlertStrategyParameter) beaconAlertStrategyParameter;
        return timeAlertStrategyParameter.getTimeToShowAlert() < SystemClock.elapsedRealtime();
    }

    @Override
    public void updateAlertParameter(BeaconContent beaconContent) {
        TimeAlertStrategyParameter timeAlertStrategyParameter = (TimeAlertStrategyParameter) beaconContent.getBeaconAlertStrategyParameter();
        //if we don't detect the beacon for more than 3 s. we consider it's a new beacon detection
        //because the scanning is done every 1.1s. and a beacon is keept in cache more than 10s.
        long currentTime = SystemClock.elapsedRealtime();
        if(timeAlertStrategyParameter.getLastDetectionTime() + 3000 < SystemClock.elapsedRealtime()){
            timeAlertStrategyParameter.setTimeToShowAlert(currentTime + timeBeforeCreatingAlert);
        }
        timeAlertStrategyParameter.setLastDetectionTime(currentTime);
    }

}


