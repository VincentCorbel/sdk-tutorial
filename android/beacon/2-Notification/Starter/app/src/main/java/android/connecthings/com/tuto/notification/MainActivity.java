package android.connecthings.com.tuto.notification;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.widget.TextView;

import com.connecthings.connectplace.actions.model.PlaceNotification;
import com.connecthings.connectplace.actions.notification.NotificationManager;
import com.connecthings.util.Log;

public class MainActivity extends AppCompatActivity {
    private final String TAG = MainActivity.class.getSimpleName();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        if (getIntent().getExtras() != null) {
            if (getIntent().getExtras().containsKey(NotificationManager.NOTIFICATION_CONTENT)) {
                PlaceNotification placeNotification = getIntent().getExtras().getParcelable(NotificationManager.NOTIFICATION_CONTENT);
                Log.d(TAG, placeNotification);
                ((TextView) findViewById(R.id.beacon_content)).setText(getString(R.string.beacon_content));
            }
        }
    }
}