(function (global) {
	var AppsFlyer;
	AppsFlyer = function () {

	};

	AppsFlyer.prototype.hasBeenNotified = function () {
		return this.appId && this.devKey)
	};

	AppsFlyer.prototype.notifyAppID = function (appId, devKey) {
		this.appId = appId;
		this.devKey = devKey;
    cordova.exec(null, null, "AppsFlyerPlugin", "notifyAppID", [ appId, devKey ]);
	};

	AppsFlyer.prototype.event = function (eventName, eventValue) {
		if (this.hasBeenNotified) {
			cordova.exec(null, null, "AppsFlyerPlugin", "notifyAppID", [ this.appId, this.devKey, eventName, eventValue ]);
		} else {
			throw new Error('event requries that notifyAppID has been run');
		}
	};
	
	AppsFlyer.prototype.setCurrencyId = function (currencyId) {
		if (this.hasBeenNotified) {
			cordova.exec(null, null, "AppsFlyerPlugin", "setCurrencyId", [ currencyId ]);
		} else {
			throw new Error('setCurrencyId requries that notifyAppID has been run');
		}
	};
	
	AppsFlyer.prototype.setCustomeUserId = function (customeUserId) {
		if (this.hasBeenNotified) {
			cordova.exec(null, null, "AppsFlyerPlugin", "setCustomeUserId", [ customeUserId ]);
		} else {
			throw new Error('setCustomeUserId requries that notifyAppID has been run');
		}
	};
	
	AppsFlyer.prototype.getDeviceId = function (callback) {
		if (this.hasBeenNotified) {
			cordova.exec(function (deviceId) {
				callback(null, deviceId);
			}, function (err) {
				callback(err || new Error ('Unable to get deviceId'));
			}, "AppsFlyerPlugin", "getDeviceId", []);
		} else {
			throw new Error('getDeviceId requries that notifyAppID has been run');
		}
	};

  AppsFlyer.prototype.getConversionData = function (callback) {
  	if (this.hasBeenNotified) {
			cordova.exec(function (conversionData) {
				callback(null, conversionData);
			}, function (err) {
				callback(err || new Error ('Unable to get Conversion Data'));
			}, "AppsFlyerPlugin", "getConversionData", []);
		} else {
			throw new Error('getConversionData requries that notifyAppID has been run');
		}
	};

	global.cordova.addConstructor(function() {
		if (!global.Cordova) {
			global.Cordova = global.cordova;
		};

		if (!global.plugins) {
			global.plugins = {};
		}

		global.plugins.appsFlyer = new AppsFlyer();
	});
}(window));
