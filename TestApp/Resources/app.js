// Test harness for MAT iOS Titanium module

// open a single window
var win = Ti.UI.createWindow({
    backgroundColor:'white'
});

var label = Ti.UI.createLabel({
    text: "MAT Titanium Test App",
    top: 0,
    width: Ti.UI.FILL,
    height: 100,
    textAlign: Titanium.UI.TEXT_ALIGNMENT_CENTER,
    font: {fontSize:32,fontWeight:'bold'},
    color:'white',
    backgroundColor:'lightgray'
});
win.add(label);

var scrollView = Ti.UI.createScrollView({
    contentHeight:'auto',
    top:101
});

Ti.API.info("[INFO] Ti.Platform.name = " + Ti.Platform.name);

var mat = require("ti.mobileapptracker");
Ti.API.info("module is => " + mat);

mat.addEventListener("mobileAppTrackerDidReceiveDeeplink", function(e){
    Ti.API.info("event 'mobileAppTrackerDidReceiveDeeplink' => " + JSON.stringify(e));
});

mat.addEventListener("mobileAppTrackerEnqueuedActionWithReferenceId", function(e){
    Ti.API.info("event 'mobileAppTrackerEnqueuedActionWithReferenceId' => " + JSON.stringify(e));
});

mat.addEventListener("mobileAppTrackerDidSucceedWithData", function(e){
    Ti.API.info("event 'mobileAppTrackerDidSucceedWithData' => " + JSON.stringify(e));
});

mat.addEventListener("mobileAppTrackerDidFailWithError", function(e){
    Ti.API.info("event 'mobileAppTrackerDidFailWithError' => " + JSON.stringify(e));
});

var isiOS = Ti.Platform.osname=='iphone' || Ti.Platform.osname=='ipad';
var isAndroid = Ti.Platform.osname=='android';

Ti.API.info("isiOS = " + isiOS);
Ti.API.info("isAndroid = " + isAndroid);

var ifawrapper = null;
if(isiOS)
{
    ifawrapper = require('com.hasoffers.ifawrapper');
    Ti.API.info("module is => " + ifawrapper);
}

var gaidwrapper = null;
if (isAndroid)
{
    gaidwrapper = require('com.hasoffers.gaidwrapper');
    Ti.API.info("module is => " + gaidwrapper);
}

var button = Titanium.UI.createButton({ title: 'Start MAT', top: 45, width: Ti.UI.FILL, height: 200, borderWidth:1, borderRadius:8 });
button.addEventListener('click',function(e) {
    var advId = "877";
    var convKey = "8c14d6bbe466b65211e781d62e301eec";
    var pkgName = "com.hasoffers.titaniumsample";
    
    mat.initTracker(advId, convKey);
    mat.setPackageName(pkgName);
    
    if(isiOS)
    {
        mat.setAppleAdvertisingIdentifier(ifawrapper.getAppleAdvertisingIdentifier(), ifawrapper.getIsAdvertisingTrackingEnabled());
        mat.checkForDeferredDeeplink(2000); // 750 ms
    }
    else if (isAndroid)
    {
        gaidwrapper.getGoogleAdvertisingId(function(result) {
            if (result['gaid'] != null) {
                mat.setGoogleAdvertisingId(result['gaid'], result['isLAT']);
            } else {
                mat.setAndroidId(Ti.Platform.id);
            }
            
            mat.checkForDeferredDeeplink(750); // 750 ms
        });
    }
    mat.setDelegate(true);
});
scrollView.add(button);

var isMATDebugEnabled = false;
var button = Titanium.UI.createButton({ title: 'Toggle Debug Mode', top: 250, width: Ti.UI.FILL, height: 200, borderWidth:1, borderRadius:8 });
isMATDebugEnabled = !isMATDebugEnabled;
button.addEventListener('click',function(e) { mat.setDebugMode(isMATDebugEnabled); });
scrollView.add(button);

var isMATDuplicatesAllowed = false;
var button = Titanium.UI.createButton({ title: 'Toggle Allow Duplicates', top: 455, width: Ti.UI.FILL, height: 200, borderWidth:1, borderRadius:8 });
isMATDuplicatesAllowed = !isMATDuplicatesAllowed;
button.addEventListener('click',function(e) { mat.setAllowDuplicates(isMATDuplicatesAllowed); });
scrollView.add(button);

var button = Titanium.UI.createButton({ title: 'Measure Session', top: 660, width: Ti.UI.FILL, height: 200, borderWidth:1, borderRadius:8 });
button.addEventListener('click',function(e) { mat.measureSession(); });
scrollView.add(button);

var button = Titanium.UI.createButton({ title: 'Measure Action', top: 865, width: Ti.UI.FILL, height: 200, borderWidth:1, borderRadius:8 });
button.addEventListener('click',function(e) {
    mat.measureAction("purchase",
                    "ref1",
                    0.99,
                    "USD");
});
scrollView.add(button);

var button = Titanium.UI.createButton({ title: 'Measure Action With EventItems', top: 1070, width: Ti.UI.FILL, height: 200, borderWidth:1, borderRadius:8 });
button.addEventListener('click',function(e) {

    var eventItems = new Array();

    var eventItem1 = {"item":"item1",
                      "quantity":1,
                      "unit_price":0.99,
                      "revenue":0.99,
                      "attribute_sub1":"1",
                      "attribute_sub2":"2",
                      "attribute_sub3":"3",
                      "attribute_sub4":"4",
                      "attribute_sub5":"5"
    };
    eventItems[0] = eventItem1;

    var eventItem2 = {"item":"item2",
                      "quantity":2,
                      "unit_price":0.50,
                      "revenue":1
    };
    eventItems[1] = eventItem2;

    mat.measureActionWithItems("purchaseWithItems",
                             eventItems,
                             "ref2",
                             0.99,
                             "USD");
});
scrollView.add(button);

var button = Titanium.UI.createButton({ title: 'Measure Action With IAP Receipt', top: 1275, width: Ti.UI.FILL, height: 200, borderWidth:1, borderRadius:8 });
button.addEventListener('click',function(e) {

    var eventItems = new Array();

    var eventItem1 = {"item":"item1",
                      "quantity":1,
                      "unit_price":0.99,
                      "revenue":0.99,
                      "attribute_sub1":"1",
                      "attribute_sub2":"2",
                      "attribute_sub3":"3",
                      "attribute_sub4":"4",
                      "attribute_sub5":"5"
    };
    eventItems[0] = eventItem1;

    var eventItem2 = {"item":"item2",
                      "quantity":2,
                      "unit_price":0.50,
                      "revenue":1
    };
    eventItems[1] = eventItem2;

    var receipt = getSampleiTunesIAPReceipt();

    mat.measureActionWithReceipt("purchaseWithReceipt",
                               eventItems,
                               "ref3",
                               0.99,
                               "USD",
                               0,
                               receipt,
                               null);

});
scrollView.add(button);


var button = Titanium.UI.createButton({ title: 'Test Setter Methods', top: 1480, width: Ti.UI.FILL, height: 200, borderWidth:1, borderRadius:8 });
button.addEventListener('click',function(e) {

    mat.setAge(23);
    mat.setAppAdTracking(true);
    if(isiOS)
    {
        mat.setAppleAdvertisingIdentifier(ifawrapper.getAppleAdvertisingIdentifier(), ifawrapper.getIsAdvertisingTrackingEnabled());
        mat.setAppleVendorIdentifier("12345678-1234-1234-1234-123456789012");
    }
    mat.setCurrencyCode("tempCurrencyCode");
    mat.setEventAttribute1("attr1");
    mat.setEventAttribute2("attr2");
    mat.setEventAttribute3("attr3");
    mat.setEventAttribute4("attr4");
    mat.setEventAttribute5("attr5");
    mat.setExistingUser(false);
    
    mat.setEventContentType("testContentType");
    mat.setEventContentId("testContentId");
    mat.setEventDate1(new Date().toISOString ());
    mat.setEventDate2(new Date().toISOString ());
    mat.setEventLevel(3);
    mat.setEventQuantity(2);
    mat.setEventRating(4.5);
    mat.setEventSearchString("testSearchString");
    
    mat.setFacebookEventLogging(true, false);
    mat.setFacebookUserId("tempFacebook_user_id");
    mat.setGender(1);
    mat.setGoogleAdvertisingId("12345678-1234-1234-1234-123456789012", false);
    mat.setGoogleUserId("tempGoogle_user_id");
    mat.setJailbroken(false);
    mat.setLocation(1.1,2.2);
    mat.setLocationWithAltitude(3.3,4.4,5.5);
    mat.setPackageName("testPackageName");
    mat.setPayingUser(false);
    mat.setTRUSTeId("tempTRUSTeTPID");
    mat.setTwitterUserId("tempTwitter_user_id");
    mat.setUseCookieTracking(false);
    mat.setUserEmail("temp@temp.com");
    mat.setUserId("tempUserId");
    mat.setUserName("tempUserName");
});
scrollView.add(button);

var button = Titanium.UI.createButton({ title: 'Test Getter Methods', top: 1685, width: Ti.UI.FILL, height: 200, borderWidth:1, borderRadius:8 });
button.addEventListener('click',function(e) {

    var matId = mat.getMatId();
    var openLogId = mat.getOpenLogId();
    var paying = mat.getIsPayingUser();

    console.log('matId = ' + matId);
    console.log('openLogId = ' + openLogId);
    console.log('isPayingUser = ' + paying);
});
scrollView.add(button);

win.add(scrollView);
win.open();

function getSampleiTunesIAPReceipt()
{
    return "{\"signature\" = \"AiuR/oePW4lQq2qAFerYcL/lU7HB7rqPKoddrjnqLUqvLywbSukO3OUwWwiRGE8iFiNvaqVF2CaG8siBkfkP5KYaeiTHT2RNLCIKyCfhOIr4q0wYCKwxNp2vdo3S8b+4boeSAXzgzBHCR1S1hTN5LuoeRzDeIWHoYT66CBweqDetAAADVzCCA1MwggI7oAMCAQICCGUUkU3ZWAS1MA0GCSqGSIb3DQEBBQUAMH8xCzAJBgNVBAYTAlVTMRMwEQYDVQQKDApBcHBsZSBJbmMuMSYwJAYDVQQLDB1BcHBsZSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEzMDEGA1UEAwwqQXBwbGUgaVR1bmVzIFN0b3JlIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTA5MDYxNTIyMDU1NloXDTE0MDYxNDIyMDU1NlowZDEjMCEGA1UEAwwaUHVyY2hhc2VSZWNlaXB0Q2VydGlmaWNhdGUxGzAZBgNVBAsMEkFwcGxlIGlUdW5lcyBTdG9yZTETMBEGA1UECgwKQXBwbGUgSW5jLjELMAkGA1UEBhMCVVMwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMrRjF2ct4IrSdiTChaI0g8pwv/cmHs8p/RwV/rt/91XKVhNl4XIBimKjQQNfgHsDs6yju++DrKJE7uKsphMddKYfFE5rGXsAdBEjBwRIxexTevx3HLEFGAt1moKx509dhxtiIdDgJv2YaVs49B0uJvNdy6SMqNNLHsDLzDS9oZHAgMBAAGjcjBwMAwGA1UdEwEB/wQCMAAwHwYDVR0jBBgwFoAUNh3o4p2C0gEYtTJrDtdDC5FYQzowDgYDVR0PAQH/BAQDAgeAMB0GA1UdDgQWBBSpg4PyGUjFPhJXCBTMzaN+mV8k9TAQBgoqhkiG92NkBgUBBAIFADANBgkqhkiG9w0BAQUFAAOCAQEAEaSbPjtmN4C/IB3QEpK32RxacCDXdVXAeVReS5FaZxc+t88pQP93BiAxvdW/3eTSMGY5FbeAYL3etqP5gm8wrFojX0ikyVRStQ+/AQ0KEjtqB07kLs9QUe8czR8UGfdM1EumV/UgvDd4NwNYxLQMg4WTQfgkQQVy8GXZwVHgbE/UC6Y7053pGXBk51NPM3woxhd3gSRLvXj+loHsStcTEqe9pBDpmG5+sk4tw+GK3GMeEN5/+e1QT9np/Kl1nj+aBw7C0xsy0bFnaAd1cSS6xdory/CUvM6gtKsmnOOdqTesbp0bs8sn6Wqs0C9dgcxRHuOMZ2tm8npLUm7argOSzQ==\";\"purchase-info\" = \"ewoJIm9yaWdpbmFsLXB1cmNoYXNlLWRhdGUtcHN0IiA9ICIyMDEzLTA2LTE5IDEzOjMyOjE5IEFtZXJpY2EvTG9zX0FuZ2VsZXMiOwoJInVuaXF1ZS1pZGVudGlmaWVyIiA9ICJjODU0OGI1YWExZjM5NDA2NmY1ZWEwM2Q3ZGU0YTBiYzdjMTEyZDk5IjsKCSJvcmlnaW5hbC10cmFuc2FjdGlvbi1pZCIgPSAiMTAwMDAwMDA3Nzk2MDgzNSI7CgkiYnZycyIgPSAiMS4xIjsKCSJ0cmFuc2FjdGlvbi1pZCIgPSAiMTAwMDAwMDA4MzE1MjA1NCI7CgkicXVhbnRpdHkiID0gIjEiOwoJIm9yaWdpbmFsLXB1cmNoYXNlLWRhdGUtbXMiID0gIjEzNzE2NzM5MzkwMDAiOwoJInVuaXF1ZS12ZW5kb3ItaWRlbnRpZmllciIgPSAiQTM3MjFCQzctNDA3Qi00QzcyLTg4RDAtMTdGNjIwRUMzNzEzIjsKCSJwcm9kdWN0LWlkIiA9ICJjb20uaGFzb2ZmZXJzLmluYXBwcHVyY2hhc2V0cmFja2VyMS5iYWxsIjsKCSJpdGVtLWlkIiA9ICI2NTMyMzA4MjkiOwoJImJpZCIgPSAiY29tLkhhc09mZmVycy5JbkFwcFB1cmNoYXNlVHJhY2tlcjEiOwoJInB1cmNoYXNlLWRhdGUtbXMiID0gIjEzNzU4MTM2NDcxMDIiOwoJInB1cmNoYXNlLWRhdGUiID0gIjIwMTMtMDgtMDYgMTg6Mjc6MjcgRXRjL0dNVCI7CgkicHVyY2hhc2UtZGF0ZS1wc3QiID0gIjIwMTMtMDgtMDYgMTE6Mjc6MjcgQW1lcmljYS9Mb3NfQW5nZWxlcyI7Cgkib3JpZ2luYWwtcHVyY2hhc2UtZGF0ZSIgPSAiMjAxMy0wNi0xOSAyMDozMjoxOSBFdGMvR01UIjsKfQ==\";\"environment\" = \"Sandbox\";\"pod\" = \"100\";\"signing-status\" = \"0\";}";
}
