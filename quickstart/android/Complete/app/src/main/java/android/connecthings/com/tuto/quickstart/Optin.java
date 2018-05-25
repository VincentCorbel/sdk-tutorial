package android.connecthings.com.tuto.quickstart;

/**
 * Created by Connecthings on 04/05/2018.
 */

import com.connecthings.adtag.AdtagInitializer;
import com.connecthings.adtag.optin.OPTIN;

/**
 * Set of methods to manage the Optin
 */
public class Optin {

    public static void manage() {
        AdtagInitializer adtagInitializer = AdtagInitializer.getInstance();
        //To know if an optin has been updated
        if (adtagInitializer.optinsNeverAsked()) {
            // No update, ask the optin ?
        }

        //get the optin status
        if (adtagInitializer.isOptinAuthorized(OPTIN.USER_DATA)) {

        }

        //Update the optin status even if it's false
        adtagInitializer.updateOptin(OPTIN.USER_DATA, true);
        //Notify the SDK that it get all the optins -> launch the synchro process and we start to log analytics
        adtagInitializer.allOptinsAreUpdated();
    }

}
