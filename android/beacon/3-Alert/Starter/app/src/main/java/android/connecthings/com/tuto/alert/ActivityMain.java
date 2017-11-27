package android.connecthings.com.tuto.alert;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.connecthings.adtag.analytics.model.AdtagLogData;
import com.connecthings.connectplace.actions.inappaction.InAppActionListener;
import com.connecthings.connectplace.actions.inappaction.InAppActionStatusManagerListener;
import com.connecthings.connectplace.actions.inappaction.enums.InAppActionRemoveStatus;
import com.connecthings.connectplace.actions.model.PlaceInAppAction;
import com.connecthings.connectplace.common.content.detection.InProximityInForeground;
import com.connecthings.util.adtag.beacon.AdtagBeaconManager;
import com.connecthings.util.adtag.beacon.analytics.InAppActionRedirectHelper;
import com.connecthings.util.adtag.beacon.bridge.AdtagPlaceInAppAction;

import java.util.List;


public class ActivityMain extends AppCompatActivity implements View.OnClickListener {
    private TextView textViewInAppAction;
    private Button btnMore;
    private PlaceInAppAction currentPlaceInAppAction;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        textViewInAppAction = findViewById(R.id.tv_beacon_alert);
        btnMore = findViewById(R.id.btn_more);
        btnMore.setOnClickListener(this);
    }

    @Override
    protected void onResume() {
        super.onResume();
    }

    @Override
    protected void onPause() {
        super.onPause();
    }

    @Override
    public void onClick(View view) {
        Intent intent = new Intent(this, ActivityDetail.class);
        // This permit to generate automatically logs when the user click
        InAppActionRedirectHelper.configureInAppActionIntent(intent, currentPlaceInAppAction, AdtagLogData.REDIRECT_TYPE.ALERT, "MAIN");
        startActivity(intent);
    }

}