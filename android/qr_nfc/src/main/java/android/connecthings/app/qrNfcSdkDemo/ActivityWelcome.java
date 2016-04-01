package android.connecthings.app.qrNfcSdkDemo;

import android.app.Activity;
import android.connecthings.util.ViewUtils;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;

import android.connecthings.app.qrNfcSdkDemo.R;

public class ActivityWelcome extends Activity implements View.OnClickListener{


    public void onCreate(Bundle savedInstanceState){
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_welcome);
        ViewUtils.setListenerToView(this, this, R.id.btn_information, R.id.btn_start_activity_fg_only, R.id.btn_start_activity_bg_fg);
    }

    @Override
    public void onClick(View v) {
        int id = v.getId();
        switch (id){
            case R.id.btn_start_activity_fg_only :
                startActivity(new Intent(this, ActivityQrNfcFgOnly.class));
                break;
            case R.id.btn_start_activity_bg_fg :
                startActivity(new Intent(this, ActivityQrNfcFgBg.class));
                break;
            case R.id.btn_information :
                startActivity(new Intent(this, ActivityInformation.class));
                break;
        }
    }



}
