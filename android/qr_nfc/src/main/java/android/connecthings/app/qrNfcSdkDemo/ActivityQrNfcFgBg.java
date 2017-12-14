package android.connecthings.app.qrNfcSdkDemo;

import android.os.Bundle;
import android.widget.TextView;

/**
 * Only the configuration inside the manifest changes.
 */
public class ActivityQrNfcFgBg extends ActivityQrNfcFgOnly {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        TextView title = findViewById(R.id.tv_activity_title);
        title.setText(R.string.btn_start_activity_fg_bg);

        TextView description = findViewById(R.id.tv_activity_description);
        description.setText(R.string.tv_activity_bg_fg_explanation);
    }
}