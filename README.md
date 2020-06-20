# cordova-plugin-cookies

[![npm version](https://img.shields.io/npm/v/cordova-plugin-cookies)](https://www.npmjs.com/package/cordova-plugin-cookies?activeTab=versions)
[![MIT Licence](https://img.shields.io/badge/license-MIT-blue?style=flat)](https://opensource.org/licenses/mit-license.php)

This plugin returns the cookies from the webview for a specific url so the cookies can be used e.g. to get the cookies from [cordova-plugin-inappbrowser](https://github.com/apache/cordova-plugin-inappbrowser) and pass it to [cordova-plugin-advanced-http](https://github.com/silkimen/cordova-plugin-advanced-http).

- [Installation](#installation)
- [Supported Platforms](#supported-platforms)
- [Limitations](#limitations)
- [Usage](#usage)
  - [Plain](#plain)
  - [Extended](#extended)

## Installation

```shell
cordova plugin add cordova-plugin-cookies
```

## Supported Platforms

- Android
- iOS

## Limitations

It doen't work with the UIWebView on iOS (It's deprecated by Apple).

## Usage

### Plain

```js
// get cookie string from webview
window.cordova.plugins.CookiesPlugin.getCookie(url, (cookies) => {
  // log cookies
  console.log(url, cookies);
});
```

### Extended

- Ionic v5 with Angular
- [@ionic-native/in-app-browser](https://ionicframework.com/docs/native/in-app-browser)
- [@ionic-native/http](https://ionicframework.com/docs/native/http)

```ts
// create in app browser
const iab = this.inAppBrowser.create(url, "_blank");

// check for cookies on every loadstop
iab.on("loadstop").subscribe(() => {
  // get cookie string from webview
  (window as any).cordova.plugins.CookiesPlugin.getCookie(
    url,
    async (cookies: string) => {
      // set cookies to http plugin
      cookies.split(";").forEach((cookie) => {
        this.http.setCookie(url, cookie);
      });

      // check if connected
      if (await this.isUserAuthenticated()) {
        iab.close();
      }
    }
  );
});
```
