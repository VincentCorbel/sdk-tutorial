package android.connecthings.app.qrNfcSdkDemo;

import android.app.Application;

import com.connecthings.adtag.AdtagInitializer;
import com.connecthings.util.connection.Url.UrlType;

public class ApplicationSdkDemo extends Application {
    public static final String TAG = "ApplicationSdkDemo";

    public void onCreate() {
        super.onCreate();

        AdtagInitializer.getInstance()
                .initContext(this)
                .initUrlType(UrlType.PROD)
                .initUser("__LOGIN__", "__PSWD__")
                .initCompany("__COMPANY__")
                .synchronize();
    }
}