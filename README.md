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
- ``appId`` **String** _(Required)_ App ID provided from AppsFlyer
- ``devKey`` **String** _(Required)_ Dev key provided from AppsFlyer 
- ``callback`` **Function** _(Optional)_

for in app events please use

```javascript
window.plugins.appsFlyer.event(eventName, eventValue, callback);
```
- ``eventName`` **String** _(Required)_ The event name to define the event
- ``eventValue`` **String** _(Optional)_ The event sales value
- ``callback`` **Function** _(Optional)_

```javascript
window.plugins.appsFlyer.setCurrencyId(currencyId, callback);
```
- ``currencyId`` **String** _(Required)_ Currency Code (USD is default, GBP, EUR)
- ``callback`` **Function** _(Optional)_

```javascript
window.plugins.appsFlyer.setCustomeUserId(customeUserId, callback);
```
- ``customeUserId`` **String** _(Required)_ the custome user id you would like to attach to each conversion
- ``callback`` **Function** _(Optional)_

```javascript
window.plugins.appsFlyer.getDeviceId(callback);
```
- ``callback`` **Function** _(Required)_

```javascript
window.plugins.appsFlyer.getConversionData(callback);
```
- ``callback`` **Function** _(Required)_
