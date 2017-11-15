package android.connecthings.com.tuto.alert;

import android.os.SystemClock;

import com.connecthings.connectplace.actions.inappaction.conditions.InAppActionConditions;
import com.connecthings.connectplace.actions.inappaction.conditions.parameter.InAppActionConditionsParameter;
import com.connecthings.connectplace.actions.inappaction.enums.InAppActionActionStatus;

/**
 * Created by Connecthings on 14/11/2017.
 */
public class TimeConditionsFirstWay implements InAppActionConditions {
    private int maxTimeBeforeReset;
    private double delayBeforeCreation;

    public TimeConditionsFirstWay(int maxTimeBeforeReset, double delayBeforeCreation) {
        this.maxTimeBeforeReset = maxTimeBeforeReset;
        this.delayBeforeCreation = delayBeforeCreation;
    }

    @Override
    public String getConditionsKey() {
        return "timeConditionsFirstWay";
    }

    @Override
    public Class<? extends InAppActionConditionsParameter> getInAppActionParameterClass() {
        return TimeConditionsParameter.class;
    }

    @Override
    public void updateInAppActionConditionsParameter(InAppActionConditionsParameter inAppActionConditionsParameter) {
        TimeConditionsParameter timeConditionsParameter = (TimeConditionsParameter) inAppActionConditionsParameter;

        long currentTime = SystemClock.elapsedRealtime();
        if (timeConditionsParameter.getLastDetectionTime() + 3000 < SystemClock.elapsedRealtime()) {
            timeConditionsParameter.setTimeToShowAlert(currentTime + delayBeforeCreation);
        }
        timeConditionsParameter.setLastDetectionTime(currentTime);

        timeConditionsParameter.setConditionValid(timeConditionsParameter.getTimeToShowAlert() < SystemClock.elapsedRealtime());

        if (inAppActionConditionsParameter.getActionStatus() == InAppActionActionStatus.DONE
                && (!inAppActionConditionsParameter.isConditionValid())
                || inAppActionConditionsParameter.getMaxTimeBeforeActionDoneReset() < SystemClock.elapsedRealtime()) {
            timeConditionsParameter.setInAppActionActionStatus(InAppActionActionStatus.WAITING_FOR_ACTION);
        }
        timeConditionsParameter.setReadyForAction(inAppActionConditionsParameter.getActionStatus() == InAppActionActionStatus.WAITING_FOR_ACTION
                && inAppActionConditionsParameter.isConditionValid());
        timeConditionsParameter.setMaxTimeBeforeActionDoneReset(SystemClock.elapsedRealtime() + maxTimeBeforeReset);
    }
}