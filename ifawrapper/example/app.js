// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var win = Ti.UI.createWindow({
    backgroundColor:'white'
});
var label = Ti.UI.createLabel();
win.add(label);
win.open();

// module tests
var ifawrapper = require('com.hasoffers.ifawrapper');
Ti.API.info("module is => " + ifawrapper);

label.text = "IFA = " + ifawrapper.getAppleAdvertisingIdentifier() + ", isTrackingEnabled = " + ifawrapper.getIsAdvertisingTrackingEnabled();


if (Ti.Platform.name == "android") {
    var proxy = ifawrapper.createExample({
        message: "Creating an example Proxy",
        backgroundColor: "red",
        width: 100,
        height: 100,
        top: 100,
        left: 150
    });

    proxy.printMessage("MAT IFAWrapper Module test app");
    proxy.message = "MAT IFAWrapper Module test app";
    win.add(proxy);
}

