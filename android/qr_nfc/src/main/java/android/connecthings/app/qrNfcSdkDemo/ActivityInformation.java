package android.connecthings.app.qrNfcSdkDemo;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

import com.connecthings.util.Utils;

public class ActivityInformation extends Activity{
    public void onCreate(Bundle savedInstanceState){
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_information);
        TextView tv = findViewById(R.id.txt_version);
        tv.setText(getString(R.string.txt_version, Utils.getVersionName(this)));
    }
}
