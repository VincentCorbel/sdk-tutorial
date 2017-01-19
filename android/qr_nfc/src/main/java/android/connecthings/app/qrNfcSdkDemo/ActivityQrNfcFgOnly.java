package android.connecthings.app.qrNfcSdkDemo;


import android.Manifest;
import com.connecthings.adtag.adtagEnum.FEED_STATUS;
import com.connecthings.adtag.model.sdk.AdtagContent;
import com.connecthings.adtag.nfc.FragmentNfcAdtagContentAsker;
import com.connecthings.adtag.nfc.NfcReceiver;
import com.connecthings.adtag.sdk.AdtagContentReceiver;
import com.connecthings.adtag.sdk.FragmentAdtagContentAsker;

import android.app.Activity;
import android.app.DialogFragment;
import android.connecthings.app.qrNfcSdkDemo.dialog.ApplicationDialog;
import com.connecthings.util.EasyIntent;
import com.connecthings.util.Log;
import com.connecthings.util.nfc.NfcStatus;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.TextView;
import android.widget.Toast;

import android.connecthings.app.qrNfcSdkDemo.R;

import java.lang.ref.WeakReference;


public class ActivityQrNfcFgOnly extends Activity implements OnClickListener, AdtagContentReceiver, NfcReceiver{
	
	private static final String TAG = "Home";
    private static final String FG_ADTAG_CONTENT = "fgFindAdtagContent";
    private static final String FG_NFC_CONTENT = "fgNFCAdtagContent";
    private static final String DIALOG_LOADING="dialog.loading";
    private static final int PERMISSION_REQUEST_CAMERA=1;


    private FragmentAdtagContentAsker fgNfcAdtagContent;
    private DialogFragment fragmentLoading;
    private TextView tvNfc;
    private View btnNfcActivate;
    private Handler handlerClosingFragment = new HandlerClosingFragment(this);
    private boolean useDefaultQrCodeActivity;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_qr_nfc);
        fgNfcAdtagContent = (FragmentAdtagContentAsker) getFragmentManager().findFragmentByTag(FG_NFC_CONTENT);
        if(fgNfcAdtagContent == null){
            //Initialize a new FragmentAdtagContentAsker() if you don't need NFC
            fgNfcAdtagContent = FragmentNfcAdtagContentAsker.newInstance(false);
            getFragmentManager().beginTransaction().add(fgNfcAdtagContent, FG_NFC_CONTENT).commitAllowingStateLoss();
        }
        findViewById(R.id.btn_launch_test).setOnClickListener(this);
        findViewById(R.id.btn_launch_default_qr).setOnClickListener(this);
        findViewById(R.id.btn_launch_own_qr).setOnClickListener(this);
        View v = findViewById(R.id.btn_information);
        v.setOnClickListener(this);
        v.setClickable(true);
        v.setFocusable(true);

        tvNfc = (TextView) findViewById(R.id.tv_nfc);
        btnNfcActivate = (TextView) findViewById(R.id.btn_activate_nfc);
        btnNfcActivate.setOnClickListener(this);
	}

    @Override
    public void onClick(View v) {
        int id = v.getId();
        if( id == R.id.btn_launch_test){
            fgNfcAdtagContent.askAdtagContent("http://t.adtag.fr/gmt6cb5rax84");
        }else if( id == R.id.btn_launch_default_qr){
            testCameraPermissionToStartQrCodeActivity(true);
        }else if(id == R.id.btn_launch_own_qr){
            testCameraPermissionToStartQrCodeActivity(false);
        }else if(id == R.id.btn_activate_nfc){
            EasyIntent.enableNfc(this);
        }else{
            Intent intent = new Intent(this, ActivityInformation.class);
            startActivity(intent);
        }
    }

    //WARNING : If you don't implement it, tag nfc dection will be catched by the Activity, but no action will happen
    public void onNewIntent(Intent intent){
        super.onNewIntent(intent);
        ((FragmentNfcAdtagContentAsker) fgNfcAdtagContent).onNewIntent(intent);
    }

    @Override
    public void onReceiveAdtagContent(FEED_STATUS feedStatus, AdtagContent adtagContent) {
        if (feedStatus == FEED_STATUS.IN_PROGRESS) {
            fragmentLoading = ApplicationDialog.newInstance(ApplicationDialog.Type.LOAD_IN_PROGRESS);
            fragmentLoading.show(getFragmentManager(), DIALOG_LOADING);
        } else {
            handlerClosingFragment.sendEmptyMessage(0);

            if (feedStatus == FEED_STATUS.BACKEND_SUCCESS) {
                Intent intent = new Intent(this, ActivityContent.class);
                intent.putExtra(ActivityContent.ADTAG_CONTENT, adtagContent);
                startActivity(intent);
            } else {
                Toast toast = Toast.makeText(this.getApplicationContext(), R.string.toast_error, Toast.LENGTH_LONG);
                toast.show();
            }

        }
        Log.d(TAG, "receive information: ", feedStatus, adtagContent);
    }


    @Override
    public void onParseNfcError() {
        Toast.makeText(this.getApplicationContext(), R.string.toast_error_nfc, Toast.LENGTH_LONG).show();
    }

    @Override
    public void onParseNfcFormatNotSupported() {
        Toast.makeText(this.getApplicationContext(), R.string.toast_error_nfc_format_not_supported, Toast.LENGTH_LONG).show();
    }

    public void onNfcStatusUpdate(NfcStatus nfcStatus){
        switch (nfcStatus){
            case DISABLED:
                btnNfcActivate.setVisibility(View.VISIBLE);
                tvNfc.setText(getText(R.string.error_nfc_disable));
                break;
            case ENABLED:
                btnNfcActivate.setVisibility(View.GONE);
                tvNfc.setText(getText(R.string.txt_nfc));
                break;
            case NOT_SUPPORTED:
                btnNfcActivate.setVisibility(View.GONE);
                tvNfc.setText(getText(R.string.error_nfc_not_supported));
                break;
        }
    }

    private class HandlerClosingFragment extends Handler{

        WeakReference<ActivityQrNfcFgOnly> activityHomeWeakReference;

        public HandlerClosingFragment(ActivityQrNfcFgOnly activity){
            activityHomeWeakReference = new WeakReference<ActivityQrNfcFgOnly>(activity);
        }

        public void dispatchMessage(Message m){
            ActivityQrNfcFgOnly activity = activityHomeWeakReference.get();
            if(activity == null){
                return;
            }
            DialogFragment df = (DialogFragment)activity.getFragmentManager().findFragmentByTag(DIALOG_LOADING);
            if(df!=null) {
                df.dismiss();
            }
        }
    }

    private void testCameraPermissionToStartQrCodeActivity(boolean defaultActivity){
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M ) {
            if (checkSelfPermission(Manifest.permission.CAMERA) == PackageManager.PERMISSION_GRANTED) {
                startQrCodeActivity(defaultActivity);
            }else{
                useDefaultQrCodeActivity = defaultActivity;
                //for better user experience use checkSelfPermission to detect
                // when the user has definitivly refuse to see again the permission popup
                requestPermissions(new String[]{Manifest.permission.CAMERA}, PERMISSION_REQUEST_CAMERA);
            }
        }else{
            startQrCodeActivity(defaultActivity);
        }
    }

    private void startQrCodeActivity(boolean defaultActivity) {
        if (defaultActivity) {
            fgNfcAdtagContent.startQrCodeActivity();
        } else {
            fgNfcAdtagContent.startQrCodeActivity(ActivityQrCodeScanner.class);
        }

    }


    @Override
    public void onRequestPermissionsResult(int requestCode,
                                           String permissions[], int[] grantResults) {
        if(requestCode == PERMISSION_REQUEST_CAMERA){
            if (grantResults.length > 0
                    && grantResults[0] == PackageManager.PERMISSION_DENIED) {
                // permission was denied,
                Toast.makeText(getApplicationContext(), R.string.toast_error_permission_camera, Toast.LENGTH_LONG).show();
            }else{
                startQrCodeActivity(useDefaultQrCodeActivity);
            }
        }

    }
}
