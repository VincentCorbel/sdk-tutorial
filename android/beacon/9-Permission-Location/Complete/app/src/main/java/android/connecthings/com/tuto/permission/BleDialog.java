package android.connecthings.com.tuto.permission;

import android.app.AlertDialog;
import android.app.Dialog;
import android.app.DialogFragment;
import com.connecthings.util.adtag.beacon.AdtagBeaconManager;
import android.content.DialogInterface;
import android.os.Bundle;

/**
 */
public class BleDialog extends DialogFragment implements DialogInterface.OnClickListener{

    public static final String TAG="BleDialog";

    public static BleDialog newInstance() {
        BleDialog frag = new BleDialog();
        return frag;
    }

    public boolean fromResume;

    public Dialog onCreateDialog(Bundle savedInstanceState) {
        AlertDialog.Builder alertBuilder = new AlertDialog.Builder(getActivity());
        alertBuilder.setTitle(R.string.dialog_ble_access_title);
        alertBuilder.setMessage(R.string.dialog_ble_not_access_content);
        alertBuilder.setNegativeButton(R.string.btn_cancel, this);
        alertBuilder.setPositiveButton(R.string.btn_accept, this);
        return alertBuilder.create();
    }

    @Override
    public void onClick(DialogInterface dialog, int which) {

    }

}

