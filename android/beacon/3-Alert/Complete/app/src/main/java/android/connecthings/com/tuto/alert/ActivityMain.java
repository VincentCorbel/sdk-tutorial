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


public class ActivityMain extends AppCompatActivity implements InAppActionListener<AdtagPlaceInAppAction>, InProximityInForeground<AdtagPlaceInAppAction>, View.OnClickListener {
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
        AdtagBeaconManager.getInstance().registerInAppActionListener(this);
        AdtagBeaconManager.getInstance().registerInProximityInForeground(this);
    }

    @Override
    protected void onPause() {
        super.onPause();
        AdtagBeaconManager.getInstance().unregisterInAppActionListener();
        AdtagBeaconManager.getInstance().unregisterInProximityInForeground(this);
    }

    @Override
    public void onClick(View view) {
        Intent intent = new Intent(this, ActivityDetail.class);
        // This permit to generate automatically logs when the user click
        InAppActionRedirectHelper.configureInAppActionIntent(intent, currentPlaceInAppAction, AdtagLogData.REDIRECT_TYPE.ALERT, "MAIN");
        startActivity(intent);
    }

    @Override
    public boolean createInAppAction(AdtagPlaceInAppAction placeInAppAction, InAppActionStatusManagerListener inAppActionStatusManagerListener) {
        currentPlaceInAppAction = placeInAppAction;
        if (currentPlaceInAppAction.getAction().equals("popup")) {
            textViewInAppAction.setText(currentPlaceInAppAction.getTitle());
            btnMore.setVisibility(View.VISIBLE);
            return true;
        }
        textViewInAppAction.setText(getString(R.string.create_in_app_action_no_popup));
        btnMore.setVisibility(View.GONE);
        return false;
    }

    @Override
    public boolean removeInAppAction(AdtagPlaceInAppAction placeInAppAction, InAppActionRemoveStatus inAppActionRemoveStatus) {
        textViewInAppAction.setText(getString(R.string.remove_in_app_action));
        btnMore.setVisibility(View.GONE);
        return true;
    }

    @Override
    public void proximityContentsInForeground(@NonNull List<AdtagPlaceInAppAction> adtagPlaceInAppActions) {
        for (AdtagPlaceInAppAction adtagPlaceInAppAction : adtagPlaceInAppActions) {
            Log.e(ActivityMain.class.getSimpleName(), adtagPlaceInAppAction.toString());
        }
    }
}