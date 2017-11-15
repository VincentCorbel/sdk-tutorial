package android.connecthings.com.tuto.alert;

import android.os.SystemClock;

import com.connecthings.connectplace.actions.inappaction.conditions.InAppActionConditionsDefault;
import com.connecthings.connectplace.actions.inappaction.conditions.parameter.InAppActionConditionsParameter;

/**
 * Created by Connecthings on 14/11/2017.
 */
public class TimeConditions extends InAppActionConditionsDefault {
    private long timeBeforeCreatingAlert;

    public TimeConditions(int maxTimeBeforeReset, long timeBeforeCreatingAlert) {
        super(maxTimeBeforeReset);
        this.timeBeforeCreatingAlert = timeBeforeCreatingAlert;
    }

    @Override
    public Class<? extends InAppActionConditionsParameter> getInAppActionParameterClass() {
        return TimeConditionsParameter.class;
    }

    @Override
    public String getConditionsKey() {
        return "timeConditions";
    }

    @Override
    public boolean isConditionValid(InAppActionConditionsParameter inAppActionConditionsParameter) {
        TimeConditionsParameter timeConditionsParameter = (TimeConditionsParameter) inAppActionConditionsParameter;
        return timeConditionsParameter.getTimeToShowAlert() < SystemClock.elapsedRealtime();
    }

    @Override
    public boolean isReadyForAction(InAppActionConditionsParameter inAppActionConditionsParameter) {
        return super.isReadyForAction(inAppActionConditionsParameter);
    }

    @Override
    public void updateInAppActionConditionsParameter(InAppActionConditionsParameter inAppActionConditionsParameter) {
        TimeConditionsParameter timeConditionsParameter = (TimeConditionsParameter) inAppActionConditionsParameter;
        long currentTime = SystemClock.elapsedRealtime();
        if (timeConditionsParameter.getLastDetectionTime() + 3000 < SystemClock.elapsedRealtime()) {
            timeConditionsParameter.setTimeToShowAlert(currentTime + timeBeforeCreatingAlert);
        }
        timeConditionsParameter.setLastDetectionTime(currentTime);
        super.updateInAppActionConditionsParameter(inAppActionConditionsParameter);
    }
}