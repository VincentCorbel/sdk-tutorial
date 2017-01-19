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
        //Initialize the connection to the adtag platform

        AdtagInitializer.initInstance(this).initUrlType(Url.UrlType.PLATFORM)
                .initUser("***USER***", "***PSW****").initCompany("***COMPANY***");
        //Initiate the adtagLogManager that manages the way log are sent to the platform
        AdtagLogsManager.initInstance(this, Network.ALL,  50, 1000*60*2);
    }

}
