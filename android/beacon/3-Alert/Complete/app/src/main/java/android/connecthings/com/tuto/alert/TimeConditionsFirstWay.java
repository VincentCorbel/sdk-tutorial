package android.connecthings.com.tuto.alert;

import android.os.SystemClock;

import com.connecthings.connectplace.actions.inappaction.conditions.InAppActionConditions;
import com.connecthings.connectplace.actions.inappaction.conditions.InAppActionConditionsUpdater;
import com.connecthings.connectplace.actions.inappaction.conditions.parameter.InAppActionConditionsParameter;
import com.connecthings.connectplace.actions.inappaction.enums.InAppActionActionStatus;
import com.connecthings.connectplace.actions.inappaction.updater.InAppActionManagerUpdater;
import com.connecthings.util.Log;

/**
 * Created by Connecthings on 14/11/2017.
 */
public class TimeConditionsFirstWay implements InAppActionConditions, InAppActionConditionsUpdater {
    private int maxTimeBeforeReset;
    private double delayBeforeCreation;

    public TimeConditionsFirstWay(int maxTimeBeforeReset, double delayBeforeCreation) {
        this.maxTimeBeforeReset = maxTimeBeforeReset;
        this.delayBeforeCreation = delayBeforeCreation;
    }

    @Override
    public String getConditionsKey() {
        return "timeConditions";
    }

    @Override
    public Class<? extends InAppActionConditionsParameter> getInAppActionParameterClass() {
        return TimeConditionsParameter.class;
    }

    @Override
    public void updateInAppActionConditionsParameter(InAppActionConditionsParameter inAppActionConditionsParameter) {
        updateTimeConditionsParameter(inAppActionConditionsParameter);
        inAppActionConditionsParameter.setConditionValid(isConditionValid(inAppActionConditionsParameter));
        inAppActionConditionsParameter.setInAppActionActionStatus(updateInAppActionActionStatus(inAppActionConditionsParameter));
        inAppActionConditionsParameter.setReadyForAction(isReadyForAction(inAppActionConditionsParameter));
        if (inAppActionConditionsParameter.getActionStatus() != InAppActionActionStatus.DONE) {
            inAppActionConditionsParameter.setMaxTimeBeforeActionDoneReset(updateMaxTimeBeforeActionDoneReset(inAppActionConditionsParameter));
        }
    }

    public void updateTimeConditionsParameter(InAppActionConditionsParameter inAppActionConditionsParameter) {
        TimeConditionsParameter timeConditionsParameter = (TimeConditionsParameter) inAppActionConditionsParameter;
        long currentTime = SystemClock.elapsedRealtime();
        if (timeConditionsParameter.getLastDetectionTime() + 3000 < SystemClock.elapsedRealtime()) {
            timeConditionsParameter.setTimeToShowAlert(currentTime + delayBeforeCreation);
        }
        timeConditionsParameter.setLastDetectionTime(currentTime);
    }

    @Override
    public boolean isConditionValid(InAppActionConditionsParameter inAppActionConditionsParameter) {
        TimeConditionsParameter timeConditionsParameter = (TimeConditionsParameter) inAppActionConditionsParameter;
        Log.d("TimeConditions", "remaining time before alert: ", (timeConditionsParameter.getTimeToShowAlert() - SystemClock.elapsedRealtime()));
        return timeConditionsParameter.getTimeToShowAlert() < SystemClock.elapsedRealtime();
    }

    @Override
    public boolean isReadyForAction(InAppActionConditionsParameter inAppActionConditionsParameter) {
        return inAppActionConditionsParameter.getActionStatus() == InAppActionActionStatus.WAITING_FOR_ACTION && inAppActionConditionsParameter.isConditionValid();
    }

    @Override
    public long updateMaxTimeBeforeActionDoneReset(InAppActionConditionsParameter inAppActionConditionsParameter) {
        return SystemClock.elapsedRealtime() + maxTimeBeforeReset;
    }

    @Override
    public InAppActionActionStatus updateInAppActionActionStatus(InAppActionConditionsParameter inAppActionConditionsParameter) {
        if (inAppActionConditionsParameter.getActionStatus() == InAppActionActionStatus.DONE
                && (!inAppActionConditionsParameter.isConditionValid())
                || inAppActionConditionsParameter.getMaxTimeBeforeActionDoneReset() < SystemClock.elapsedRealtime()) {
            return InAppActionActionStatus.WAITING_FOR_ACTION;
        }
        return inAppActionConditionsParameter.getActionStatus();
    }
}