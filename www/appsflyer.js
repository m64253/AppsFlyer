(function (global) {
	var AppsFlyer = function () {};

	AppsFlyer.prototype._cordovaExec = function (callback, method, args, hasBeenNotified) {
		callback = callback || function () {};

		if (this.hasBeenNotified() === hasBeenNotified) {
			callback(new Error(hasBeenNotified ? (
					method + ' can not be called twice' 
				) : ( 
					'notifyAppID must have been called before ' + method
			)));
		} else {
			cordova.exec(function (value) {
				callback(null, value);
			}, function (err) {
				callback(err || new Error ('Failed ' + method));
			}, "AppsFlyerPlugin", method, args || []);
		}
	};

	AppsFlyer.prototype.hasBeenNotified = function () {
		return this.appId && this.devKey;
	};

	AppsFlyer.prototype.notifyAppID = function (appId, devKey, callback) {
		var self = this;
		this._cordovaExec(function (err, value) {
			if (!err) {
				self.appId = appId;
				self.devKey = devKey;
			}
			callback(err, value);
		}, "notifyAppID", [ appId, devKey ], false);
	};

	AppsFlyer.prototype.event = function (eventName, eventValue, callback) {
		this._cordovaExec(callback, "notifyAppID", [ this.appId, this.devKey, eventName, eventValue ], true);
	};

	AppsFlyer.prototype.setCurrencyId = function (currencyId, callback) {
		this._cordovaExec(callback, "setCurrencyId", [ currencyId ], true);
	};

	AppsFlyer.prototype.setCustomerUserId = function (customerUserId, callback) {
		this._cordovaExec(callback, "setCustomerUserId", [ customerUserId ], true);
	};

	AppsFlyer.prototype.getDeviceId = function (callback) {
		this._cordovaExec(callback, "getDeviceId", [], true);
	};

	AppsFlyer.prototype.getConversionData = function (callback) {
		this._cordovaExec(callback, "getConversionData", [], true);
	};

	global.cordova.addConstructor(function() {
		if (!global.Cordova) {
			global.Cordova = global.cordova;
		}
		
		if (!global.plugins) {
			global.plugins = {};
		}
		
		global.plugins.appsFlyer = new AppsFlyer();
	});
}(window));