package android.connecthings.com.tuto.alert;

import com.connecthings.adtag.model.sdk.BeaconContent;
import com.connecthings.util.adtag.beacon.model.BeaconIntent;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.widget.TextView;

/**
 */
public class ActivityDetail extends AppCompatActivity {

    private BeaconContent currentBeaconContent;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);
        currentBeaconContent = getIntent().getParcelableExtra(BeaconIntent.BEACON_CONTENT);
        initView();
    }

    private void initView(){
        ((TextView) findViewById(R.id.tv_beacon_title)).setText(currentBeaconContent.getAlertTitle());
        ((TextView) findViewById(R.id.tv_beacon_description)).setText(currentBeaconContent.getAlertDescription());
        //You could find all the others field from the beacon using
        //currentBeaconContent.getValue("Category","Field");
    }

}
