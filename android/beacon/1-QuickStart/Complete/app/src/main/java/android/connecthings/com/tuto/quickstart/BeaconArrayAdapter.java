package android.connecthings.com.tuto.quickstart;

import com.connecthings.util.adapter.ArrayAdapter;
import com.connecthings.util.adtag.beacon.bridge.AdtagPlaceInAppAction;

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
    protected View bindView(int position, AdtagPlaceInAppAction element, ViewGroup parent,
                            boolean isEnabled, boolean dropDown) {
        View view = this.inflateDefaultView(parent);
        view.setTag(new ViewHolder(view));
        return view;
    }

    @Override
    protected void setContentToView(int position, AdtagPlaceInAppAction element,
                                    View convertView, boolean isEnable, boolean dropDown) {
        ViewHolder vh = (ViewHolder) convertView.getTag();
        vh.tv.setText(buildBeaconRow(element));
    }

    private String buildBeaconRow(AdtagPlaceInAppAction adtagPlaceInAppAction){
        return adtagPlaceInAppAction.getAdtagContent().getNotificationDescription();
    }

    private class ViewHolder {
        private TextView tv;

        private ViewHolder(View view) {
            tv = view.findViewById(R.id.content);
        }
    }
}