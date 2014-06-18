# PhoneGap

AppsFlyer plugin for Phonegap. 

Built against Phonegap 3.3.0.

## Installation

```
cordova plugin add https://github.com/m64253/AppsFlyer.git
```
        
## API

The supported methods are:

for appInstall please use

```javascript
window.plugins.appsFlyer.notifyAppID(appId, devKey, callback);
```
- appId: (String)(Required) App ID provided from AppsFlyer
- devKey: (String)(Required) Dev key provided from AppsFlyer 
- callback: (Function)

for in app events please use

```javascript
window.plugins.appsFlyer.event(eventName, eventValue, callback);
```
- eventName: (String)(Required) The event name to define the event
- eventValue: (String)(Optional) The event sales value
- callback: (Function)

```javascript
window.plugins.appsFlyer.setCurrencyId(currencyId, callback);
```
- currencyId: (String)(Required) Currency Code (USD is default, GBP, EUR)
- callback: (Function)

```javascript
window.plugins.appsFlyer.setCustomeUserId(customeUserId, callback);
```
- customeUserId: (String)(Required) the custome user id you would like to attach to each conversion
- callback: (Function)

```javascript
window.plugins.appsFlyer.getDeviceId(callback);
```
- callback: (Function)(Required)

```javascript
window.plugins.appsFlyer.getConversionData(callback);
```
- callback: (Function)(Required)
