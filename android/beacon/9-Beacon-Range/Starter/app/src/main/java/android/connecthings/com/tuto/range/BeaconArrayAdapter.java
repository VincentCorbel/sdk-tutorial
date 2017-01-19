package android.connecthings.com.tuto.range;

import com.connecthings.adtag.model.sdk.BeaconContent;
import com.connecthings.util.adapter.ArrayAdapter;
import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;


import java.util.ArrayList;

public class BeaconArrayAdapter extends ArrayAdapter<BeaconContent> {

    public BeaconArrayAdapter(Context context) {
        super(context, R.layout.row_list_beacon, new ArrayList<BeaconContent>());
    }

    @Override
    protected View bindView(int position, BeaconContent element, ViewGroup parent,
                            boolean isEnabled, boolean dropDown) {
        View view = this.inflateDefaultView(parent);
        view.setTag(new ViewHolder(view));
        return view;
    }

    @Override
    protected void setContentToView(int position, BeaconContent element,
                                    View convertView, boolean isEnable, boolean dropDown) {
        ViewHolder vh = (ViewHolder) convertView.getTag();
        vh.tv.setText(buildBeaconRow(element));
    }

    private String buildBeaconRow(BeaconContent beaconContent){
        return beaconContent.getNotificationDescription();
    }

    private class ViewHolder {
        public TextView tv;

        public ViewHolder(View view){
            tv = (TextView) view.findViewById(R.id.content);
        }

    }


}

