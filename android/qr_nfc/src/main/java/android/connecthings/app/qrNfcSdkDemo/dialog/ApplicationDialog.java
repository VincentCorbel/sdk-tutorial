package android.connecthings.app.qrNfcSdkDemo.dialog;


import android.app.AlertDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.v4.app.DialogFragment;

import android.connecthings.app.qrNfcSdkDemo.R;

public class ApplicationDialog extends DialogFragment implements DialogInterface.OnClickListener{

    private static final String TYPE="type";

    public static enum Type{LOAD_IN_PROGRESS}

    public static ApplicationDialog newInstance(Type type) {
        ApplicationDialog frag = new ApplicationDialog();
        Bundle args = new Bundle();
        args.putString(TYPE, type.toString());
        frag.setArguments(args);
        return frag;
    }

    public Dialog onCreateDialog(Bundle savedInstanceState) {
        Type type = Type.valueOf(getArguments().getString(TYPE));
        AlertDialog.Builder alertBuilder = new AlertDialog.Builder(getActivity());

        switch (type){
            case LOAD_IN_PROGRESS:
                alertBuilder.setTitle(R.string.dialog_loading_title);
                alertBuilder.setMessage(R.string.dialog_loading_content);
                setCancelable(false);
            break;
        }
        return alertBuilder.create();
    }

    @Override
    public void onClick(DialogInterface dialog, int which) {
        if(which == Dialog.BUTTON_NEGATIVE){
            dismiss();
            getActivity().finish();
        }else if(which == Dialog.BUTTON_POSITIVE){

            dismiss();
        }else{
            dismiss();

        }
    }

}
