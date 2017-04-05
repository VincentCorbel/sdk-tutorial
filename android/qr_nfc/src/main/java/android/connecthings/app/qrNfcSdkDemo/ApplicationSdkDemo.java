package android.connecthings.app.qrNfcSdkDemo;

import android.app.Application;
import com.connecthings.adtag.AdtagInitializer;
import com.connecthings.adtag.analytics.AdtagLogsManager;
import com.connecthings.util.connection.Network;
import com.connecthings.util.connection.Url;
import com.connecthings.util.connection.Url.UrlType;


public class ApplicationSdkDemo extends Application {
	
	public static final String TAG="ApplicationSdkDemo";
   
	public void onCreate(){
		super.onCreate();
        AdtagInitializer.initInstance(this).initUrlType(UrlType.PROD)
                .initUser("User_cbeacon", "fSKbCEvCDCbYTDlk").initCompany("ccbeacondemo").synchronize();
    }

}
