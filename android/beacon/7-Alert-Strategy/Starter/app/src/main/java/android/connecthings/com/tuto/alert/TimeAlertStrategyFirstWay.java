package android.connecthings.com.tuto.alert;

import android.os.SystemClock;

import com.connecthings.adtag.model.sdk.BeaconAlertStrategyParameter;
import com.connecthings.adtag.model.sdk.BeaconContent;
import com.connecthings.util.Log;
import com.connecthings.util.adtag.beacon.strategy.alert.Listener.BeaconAlertStrategyListener;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;


public class TimeAlertStrategyFirstWay implements BeaconAlertStrategyListener{

    public static final String ALERT_STRATEGY = "timeAlertStrategy";

    private final int maxTimeBeforeReset;
    private final long timeBeforeCreatingAlert;


    public TimeAlertStrategyFirstWay(int maxTimeBeforeReset, long timeBeforeCreatingAlert) {
        this.maxTimeBeforeReset = maxTimeBeforeReset;
        this.timeBeforeCreatingAlert = timeBeforeCreatingAlert;
    }

    private BeaconAlertStrategyParameter createBeaconAlertParameter(){
        try {
            Constructor<? extends BeaconAlertStrategyParameter> constructor = getBeaconAlertParameterClass().getConstructor();
            return constructor.newInstance();
        }catch (NoSuchMethodException e){
            Log.e(ALERT_STRATEGY, e, "impossible to create strategy parameter");
        } catch (IllegalAccessException e) {
            Log.e(ALERT_STRATEGY, e, "impossible to create strategy parameter");
        } catch (InstantiationException e) {
            Log.e(ALERT_STRATEGY, e, "impossible to create strategy parameter");
        } catch (InvocationTargetException e) {
            Log.e(ALERT_STRATEGY, e, "impossible to create strategy parameter");
        }
        return null;
    }

    @Override
    public void updateBeaconContent(BeaconContent beacon) {
        BeaconAlertStrategyParameter strategyParameter = beacon.getBeaconAlertStrategyParameter();
        if (strategyParameter==null || !strategyParameter.getClass().equals(getBeaconAlertParameterClass())){
            strategyParameter = createBeaconAlertParameter();
            beacon.setBeaconAlertStrategyParameter(strategyParameter);
        }

        TimeAlertStrategyParameter timeAlertStrategyParameter = (TimeAlertStrategyParameter) strategyParameter;
        //if we don't detect the beacon for more than 3 s. we consider it's a new beacon detection
        //because the scanning is done every 1.1s. and a beacon is keept in cache more than 10s.
        long currentTime = SystemClock.elapsedRealtime();
        if(timeAlertStrategyParameter.getLastDetectionTime() + 3000 < SystemClock.elapsedRealtime()){
            timeAlertStrategyParameter.setTimeToShowAlert(currentTime + timeBeforeCreatingAlert);
        }
        timeAlertStrategyParameter.setLastDetectionTime(currentTime);

        strategyParameter.setIsConditionValid(isConditionValid(beacon.getBeaconAlertStrategyParameter()));
        if(strategyParameter.getActionStatus()== BeaconAlertStrategyParameter.BeaconActionStatus.DONE){
            testToResetActionIsDone(strategyParameter);
        }
        strategyParameter.setIsReadyForAction(isReadyForAction(beacon.getBeaconAlertStrategyParameter()));
        //Update each cycle -> means only a beacon that we don't see for more than maxTimeBeforeReset will be impact
        strategyParameter.setMaxTimeBeforeResetingActionDone(SystemClock.elapsedRealtime() + maxTimeBeforeReset);
    }

    public void testToResetActionIsDone(BeaconAlertStrategyParameter strategyParameter){
        if( !strategyParameter.isConditionValid()
                || strategyParameter.getMaxTimeBeforeResetingActionDone() < SystemClock.elapsedRealtime()){
            strategyParameter.setActionStatus(BeaconAlertStrategyParameter.BeaconActionStatus.WAITING_FOR_ACTION);
        }
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
    public boolean isReadyForAction(BeaconAlertStrategyParameter beaconAlertStrategyParameter) {
        return beaconAlertStrategyParameter.getActionStatus() == BeaconAlertStrategyParameter.BeaconActionStatus.WAITING_FOR_ACTION && beaconAlertStrategyParameter.isConditionValid();
    }

}
