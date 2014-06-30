package org.apache.cordova.appsflyer;

import org.apache.cordova.api.CallbackContext;
import org.apache.cordova.api.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.appsflyer.AppsFlyerLib;

import android.util.Log;

public interface ConversionDataListener {

    void onConversionDataLoaded(Map<String,String> conversionData);

    void onConversionFailure(String errorMessage);

}

public class AppsFlyerPlugin extends CordovaPlugin {
	
	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		if ("notifyAppID".equals(action)) 
		{
			notifyAppID(args);
			return true;
		} else if("setCurrencyId".equals(action))
		{
			setCurrencyId(args);
			return true;
		}
		else if("setCustomerUserId".equals(action))
		{
			setCustomeUserId(args);
			return true;
		}
		else if("getDeviceId".equals(action, callbackContext))
		{
			getDeviceId(args);
			return true;
		}
		else if("getConversionData".equals(action, callbackContext))
		{
			getConversionData(args);
			return true;
		}
		return false;
	}
	
	
	private void setCurrencyId(JSONArray parameters)
	{
		String currencyId=null;
		try
		{
			currencyId = parameters.getString(0);
		}
		catch (JSONException e) 
		{
			e.printStackTrace();
			return;
		}
		if(currencyId == null || currencyId.length()==0)
		{
			return;
		}
		AppsFlyerLib.setCurrencyCode(currencyId);
	
	}
	
	private void setCustomerUserId(JSONArray parameters)
	{
		String customerUserId=null;
		try
		{
			customerUserId = parameters.getString(0);
		}
		catch (JSONException e) 
		{
			e.printStackTrace();
			return;
		}
		if(customerUserId == null || customerUserId.length()==0)
		{
			return;
		}
		AppsFlyerLib.setAppUserId(customerUserId);
	
	}
	
	
	
	private void notifyAppID(JSONArray parameters) {	
		String appId = null;
		String devKey = null;
		String eventName = null;
		String eventValue = null;
		
		try {
			appId = parameters.getString(0);
		} catch (JSONException e) {
			e.printStackTrace();
			return;
		}
		
		try {
			devKey = parameters.getString(1);
		} catch (JSONException e) {
			e.printStackTrace();
			return;
		}

		try {
			if (parameters.length() > 2) {
				eventName = parameters.getString(2);
				eventValue = parameters.getString(3);
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		
		if (eventName != null && eventName != "null" && eventName.length() > 0) {
			AppsFlyerLib.sendTrackingWithEvent(this.cordova.getActivity().getApplicationContext(), devKey, eventName, eventValue);
		} else {
			AppsFlyerLib.sendTracking(this.cordova.getActivity().getApplicationContext(), devKey);
		}
	}


	private void getDeviceId(JSONArray parameters, CallbackContext callbackContext)
	{
		String deviceId = AppsFlyerLib.getAppsFlyerUID(this);

		if (deviceId != null && !deviceId.isEmpty())
		{
			callbackContext.success(deviceId);
		}
		else
		{
			callbackContext.error();
		}
	}

	private void getConversionData(JSONArray parameters, CallbackContext callbackContext)
	{
		AppsFlyerLib.getConversionData(this, new ConversionDataListener() {
    		public void onConversionDataLoaded(Map<String, String> conversionData) {
        	JSONObject r = new JSONObject();
        	for (String attrName : conversionData.keySet()){
        		Log.d("AppsFlyerTest","attribute: "+attrName+" = "+conversionData.get(attrName));
						r.put(attrName, conversionData.get(attrName));
          }
          callbackContext.success(r);
        }
        public void onConversionFailure(String errorMessage) {
        	Log.d("AppsFlyerTest", "error getting conversion data: "+errorMessage);
        	callbackContext.error(errorMessage);
        }
		});
	}
}
