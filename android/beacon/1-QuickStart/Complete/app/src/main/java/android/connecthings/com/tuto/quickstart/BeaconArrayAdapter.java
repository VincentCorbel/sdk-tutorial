package android.connecthings.com.tuto.quickstart;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.connecthings.util.adapter.ArrayAdapter;
import com.connecthings.util.adtag.beacon.bridge.AdtagPlaceInAppAction;

import java.util.ArrayList;

public class BeaconArrayAdapter extends ArrayAdapter<AdtagPlaceInAppAction> {
    public BeaconArrayAdapter(Context context) {
        super(context, R.layout.row_list_beacon, new ArrayList<AdtagPlaceInAppAction>());
    }

    @Override
    protected View bindView(int i, AdtagPlaceInAppAction placeInAppAction, ViewGroup parent, boolean b, boolean b1) {
        View view = this.inflateDefaultView(parent);
        view.setTag(new ViewHolder(view));
        return view;
    }

    @Override
    protected void setContentToView(int i, AdtagPlaceInAppAction placeInAppAction, View convertView, boolean b, boolean b1) {
        ViewHolder vh = (ViewHolder) convertView.getTag();
        vh.tv.setText(buildBeaconRow(placeInAppAction));
    }

    private String buildBeaconRow(AdtagPlaceInAppAction placeInAppAction) {
        return placeInAppAction.getDescription();
    }

    private class ViewHolder {
        private TextView tv;

        private ViewHolder(View view) {
            tv = view.findViewById(R.id.content);
        }
    }
}