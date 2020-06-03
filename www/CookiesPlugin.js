var exec = require("cordova/exec");

exports.getCookie = function (url, success, error) {
  // check url argument
  if (!url) {
    error("URL missing.");
    return;
  }

  // execute cordova
  exec(success, error, "CookiesPlugin", "getCookie", [url]);
};
