package android.connecthings.com.tuto.notification;

import android.app.Application;
import com.connecthings.adtag.AdtagInitializer;
import com.connecthings.util.connection.Url;

public class ApplicationNotification extends Application {
    public void onCreate(){
        super.onCreate();

        AdtagInitializer.getInstance()
                .initContext(this)
                .initUrlType(Url.UrlType.PRE_PROD)
                .initUser("__USER__", "__PSWD__")
                .initCompany("__COMPANY__")
                .synchronize();
    }
}