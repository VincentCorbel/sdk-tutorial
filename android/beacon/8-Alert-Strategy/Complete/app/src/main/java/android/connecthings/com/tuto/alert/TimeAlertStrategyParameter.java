package android.connecthings.com.tuto.alert;

import com.connecthings.adtag.model.sdk.BeaconAlertStrategyParameter;
import android.os.Parcel;

/**.
 */
public class TimeAlertStrategyParameter extends BeaconAlertStrategyParameter{

    private long timeToShowAlert;
    private long lastDetectionTime;

    public TimeAlertStrategyParameter(){
        super();
    }

    protected TimeAlertStrategyParameter(Parcel from){
        super(from);
    }

    public long getTimeToShowAlert() {
        return timeToShowAlert;
    }

    public void setTimeToShowAlert(long timeToShowAlert) {
        this.timeToShowAlert = timeToShowAlert;
    }

    public long getLastDetectionTime() {
        return lastDetectionTime;
    }

    public void setLastDetectionTime(long lastDetectionTime) {
        this.lastDetectionTime = lastDetectionTime;
    }

    public void writeToParcel(Parcel dest, int flags) {
        super.writeToParcel(dest, flags);
        dest.writeLong(timeToShowAlert);
    }

    public void readFromParcel(Parcel from) {
        super.readFromParcel(from);
        timeToShowAlert = from.readLong();
        lastDetectionTime = from.readLong();
    }

    public static final Creator<TimeAlertStrategyParameter> CREATOR = new Creator() {
        public BeaconAlertStrategyParameter createFromParcel(Parcel in) {
            return new TimeAlertStrategyParameter(in);
        }

        public TimeAlertStrategyParameter[] newArray(int size) {
            return new TimeAlertStrategyParameter[size];
        }
    };

}
