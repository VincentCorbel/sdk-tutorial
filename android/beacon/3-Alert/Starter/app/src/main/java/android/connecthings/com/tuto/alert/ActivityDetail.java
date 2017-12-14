package android.connecthings.com.tuto.alert;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.widget.TextView;

import com.connecthings.connectplace.actions.model.PlaceInAppAction;
import com.connecthings.util.adtag.beacon.analytics.InAppActionRedirectHelper;

public class ActivityDetail extends AppCompatActivity {
    private PlaceInAppAction placeInAppAction;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);
        placeInAppAction = getIntent().getParcelableExtra(InAppActionRedirectHelper.IN_APP_ACTION_CONTENT);
        initView();
    }

    private void initView() {
        ((TextView) findViewById(R.id.tv_beacon_title)).setText(placeInAppAction.getTitle());
        ((TextView) findViewById(R.id.tv_beacon_description)).setText(placeInAppAction.getDescription());
    }
}