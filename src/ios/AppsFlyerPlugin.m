#import "AppsFlyerPlugin.h"
#import "AppsFlyerTracker.h"

@implementation AppsFlyerPlugin

- (CDVPlugin *)initWithWebView:(UIWebView *)theWebView
{
    self = (AppsFlyerPlugin *)[super initWithWebView:theWebView];
    return self;
}

- (void)notifyAppID:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;

    if ([command.arguments count] >= 2) {
        NSString* appId = [command.arguments objectAtIndex:0];
        NSString* devKey = [command.arguments objectAtIndex:1];
        NSString* eventName = [command.arguments objectAtIndex:2];
        
        [AppsFlyerTracker sharedTracker].appleAppID = appId;
        [AppsFlyerTracker sharedTracker].appsFlyerDevKey = devKey;
        
        //#ifdef CONFIGURATION_Release
        if ([command.arguments count] == 2 || [eventName isEqual:[NSNull null]]) {
            [[AppsFlyerTracker sharedTracker] trackAppLaunch];
            [[AppsFlyerTracker sharedTracker] loadConversionDataWithDelegate:self];
            
        } else if ([command.arguments count] == 3) {
            [[AppsFlyerTracker sharedTracker] trackEvent:[command.arguments objectAtIndex:2] withValue:nil];
            
        } else if ([command.arguments count] == 4) {
            [[AppsFlyerTracker sharedTracker] trackEvent:[command.arguments objectAtIndex:2] withValue:[command.arguments objectAtIndex:3]];
        }
        //#endif

        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}



- (void)setCurrencyId:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;

    if ([command.arguments count] == 1) {
        NSString* currencyId = [command.arguments objectAtIndex:0];

        //#ifdef CONFIGURATION_Release
        [AppsFlyerTracker sharedTracker].currencyCode = currencyId; 
        //#endif

        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


- (void)setCustomerUserId:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;

    if ([command.arguments count] == 1) {
        NSString* customerId = [command.arguments objectAtIndex:0];

        //#ifdef CONFIGURATION_Release
        [AppsFlyerTracker sharedTracker].customerUserID = customerId;
        //#endif
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getDeviceId:(CDVInvokedUrlCommand*)command
{

    CDVPluginResult* pluginResult = nil;
    NSString* deviceId = [[AppsFlyerTracker sharedTracker] getAppsFlyerUID];
    
    if (deviceId != nil && [deviceId length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:deviceId];
        
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getConversionData:(CDVInvokedUrlCommand*)command
{

    CDVPluginResult* pluginResult = nil;
    
    if (self.conversionData != nil) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:self.conversionData];
        
    } else if (self.conversionDataError) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[self.conversionDataError localizedDescription]];
        
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

#pragma AppsFlyerTrackerDelegate methods
- (void) onConversionDataReceived:(NSDictionary*) installData
{
    self.conversionData = installData;
}

- (void) onConversionDataRequestFailure:(NSError *)error
{
    self.conversionDataError = error;
}
@end
