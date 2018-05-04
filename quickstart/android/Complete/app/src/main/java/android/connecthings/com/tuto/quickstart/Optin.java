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
        if (!adtagInitializer.areOptinsUpdateOnce()) {
            // No update, ask the optin ?
        }
        //Update the optin status even if it's false
        adtagInitializer.updateOptin(OPTIN.LOCATION, true);
        adtagInitializer.updateOptin(OPTIN.USER_ID, false);
        //get the optin status
        if (adtagInitializer.isOptinAuthorized(OPTIN.LOCATION)) {

        }
    }

}
