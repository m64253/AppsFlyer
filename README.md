# PhoneGap

AppsFlyer plugin for Phonegap. 

Built against Phonegap 3.3.0.

## Installation

```
cordova plugin add https://git-wip-us.apache.org/repos/asf/cordova-plugin-device.git
```
        
## API

The supported methods are:

for appInstall please use

```javascript
window.plugins.appsFlyer.notifyAppID(appId, devKey);
```

for in app events please use

```javascript
window.plugins.appsFlyer.notifyAppID(appId, devKey, eventName, eventValue);
```
		
- appId: (String)(Required) App ID provided from AppsFlyer

- devKey: (String)(Required) Dev key provided from AppsFlyer 

- eventName: (String)(Optional) The event name to define the event

- eventValue: (String)(Optional) The event sales value

```javascript
window.plugins.appsFlyer.setCurrencyId(currencyId);
```
	
- currencyId: (String)(Required) Currency Code (USD is default, GBP, EUR)		

```javascript
window.plugins.appsFlyer.setCustomeUserId(customeUserId);
```

- customeUserId: (String)(Required) the custome user id you would like to attach to each conversion

```javascript
window.plugins.appsFlyer.getDeviceId(callback);
```
	
- callback: (Function)(Required)
