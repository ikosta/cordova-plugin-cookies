package cordova-plugin-cookies;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * This class echoes a string called from JavaScript.
 */
public class CookiesPlugin extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("getCookie")) {
            this.getCookie(args, callbackContext);
            return true;
        }
        return false;
    }

    private void getCookie(JSONArray args, CallbackContext callbackContext) {
        // get url argument
        String url = args.getString(0);

        // check url argument
        if (url == null || url.length() == 0) {
            callbackContext.error("URL missing.");
            return;
        }

        // get cookies
        callbackContext.success(url);
    }
}
