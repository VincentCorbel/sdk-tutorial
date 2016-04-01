package android.connecthings.app.qrNfcSdkDemo;


import android.os.Bundle;
import android.widget.TextView;

/**
 * ONly the configuration inside the manifest changes.
 */
public class ActivityQrNfcFgBg extends ActivityQrNfcFgOnly{

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
        TextView title = (TextView) findViewById(R.id.tv_activity_title);
        title.setText(R.string.btn_start_activity_fg_bg);

        TextView description = (TextView) findViewById(R.id.tv_activity_description);
        description.setText(R.string.tv_activity_bg_fg_explanation);
	}

}
