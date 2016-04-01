package android.connecthings.app.qrNfcSdkDemo;

import android.app.Application;
import android.connecthings.adtag.AdtagInitializer;
import android.connecthings.adtag.analytics.AdtagLogsManager;
import android.connecthings.util.connection.Network;
import android.connecthings.util.connection.Url.UrlType;


public class ApplicationSdkDemo extends Application {
	
	public static final String TAG="ApplicationSdkDemo";
   
	public void onCreate(){
		super.onCreate();
        //Initialize the connection to the adtag platform
        AdtagInitializer.initInstance(this).initUrlType(UrlType.PROD)
                .initUser("User_cbeacon","fSKbCEvCDCbYTDlk").initCompany("ccbeacondemo");
        //Initiate the adtagLogManager that manages the way log are sent to the platform
        AdtagLogsManager.initInstance(this, Network.ALL,  50, 1000*60*2);
    }

}
