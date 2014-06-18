#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import "AppsFlyerTracker.h"

@interface AppsFlyerPlugin : CDVPlugin  <AppsFlyerTrackerDelegate>

@property (nonatomic, copy) NSDictionary* conversionData;
@property (nonatomic, copy) NSError* conversionDataError;

- (void)notifyAppID:(CDVInvokedUrlCommand*)command;
- (void)setCurrencyId:(CDVInvokedUrlCommand*)command;
- (void)setCustomerUserId:(CDVInvokedUrlCommand*)command;
- (void)getDeviceId:(CDVInvokedUrlCommand*)command;
- (void)getConversionData:(CDVInvokedUrlCommand*)command;
@end