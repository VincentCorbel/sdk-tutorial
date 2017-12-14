package android.connecthings.com.tuto.alert;

import com.connecthings.connectplace.actions.inappaction.conditions.parameter.InAppActionConditionsParameter;
import com.connecthings.connectplace.actions.model.PlaceInAppAction;

/**
 * Created by Connecthings on 14/11/2017.
 */
public class TimeConditionsParameter extends InAppActionConditionsParameter {
    private double lastDetectionTime = 0;
    private double timeToShowAlert = 0;

    public TimeConditionsParameter(PlaceInAppAction placeInAppAction) {
        super(placeInAppAction);
    }

    public double getLastDetectionTime() {
        return lastDetectionTime;
    }

    public void setLastDetectionTime(double lastDetectionTime) {
        this.lastDetectionTime = lastDetectionTime;
    }

    public double getTimeToShowAlert() {
        return timeToShowAlert;
    }

    public void setTimeToShowAlert(double timeToShowAlert) {
        this.timeToShowAlert = timeToShowAlert;
    }
}