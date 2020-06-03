/********* CookiesPlugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <WebKit/WKHTTPCookieStore.h>
#import <WebKit/WKWebsiteDataStore.h>

@interface CookiesPlugin : CDVPlugin {
  // Member variables go here.
}

- (void)getCookie:(CDVInvokedUrlCommand*)command;
@end

@implementation CookiesPlugin

- (void)getCookie:(CDVInvokedUrlCommand*)command
{
    // get url argument
    NSString* url = [command.arguments objectAtIndex:0];

    // check url argument
    if (url == nil || [url length] == 0) {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"URL missing."] callbackId:command.callbackId];
        return;
    }

    // get cookies
    WKHTTPCookieStore* cookies = [WKWebsiteDataStore defaultDataStore].httpCookieStore;

    [cookies getAllCookies:^(NSArray<NSHTTPCookie *> * _Nonnull allCookies) {
        // create cookie value
        NSString* cookieValue = @"";

        // iterate all cookies
        for (NSHTTPCookie *cookie in allCookies) {
            // check url with domain
            if ([url rangeOfString:cookie.domain].location != NSNotFound) {
                // append ; before cookie if its not first cookie
                if ([cookieValue length] > 0) {
                    cookieValue = [[NSString alloc] initWithFormat:@"%@;", cookieValue];
                }
                // append cookie to cookie value
                cookieValue = [[NSString alloc] initWithFormat:@"%@%@=%@", cookieValue, cookie.name, cookie.value];
            }
        }

        // return cookie value
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:cookieValue] callbackId:command.callbackId];
    }];
}

@end
