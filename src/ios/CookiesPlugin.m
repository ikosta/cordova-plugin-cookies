/********* CookiesPlugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>

@interface CookiesPlugin : CDVPlugin {
  // Member variables go here.
}

- (void)coolMethod:(CDVInvokedUrlCommand*)command;
@end

@implementation CookiesPlugin

- (void)coolMethod:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];

    if (echo != nil && [echo length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    WKHTTPCookieStore* cookies = [WKWebsiteDataStore defaultDataStore].httpCookieStore;
    
    [cookies getAllCookies:^(NSArray<NSHTTPCookie *> * _Nonnull allCookies) {
        allCookies.count;
    }];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
