package cordova.plugins.cookies;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.webkit.CookieManager;

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
        String url = args.optString(0);

        // check url argument
        if (url == null || url.length() == 0) {
            callbackContext.error("URL missing.");
            return;
        }

        // get cookies
        cordova.getThreadPool().execute(new Runnable() {
            public void run() {
                try {
                    // return cookie value
                    callbackContext.success(CookieManager.getInstance().getCookie(url));
                } catch (Exception e) {
                    // return error
                    callbackContext.error(e.getMessage());
                }
            }
        });
    }
}
