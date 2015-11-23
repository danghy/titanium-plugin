// Test harness for MAT Titanium Android module

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

mat.addEventListener("tuneEnqueuedActionWithReferenceId", function(e){
    Ti.API.info("event 'tuneEnqueuedActionWithReferenceId' => " + JSON.stringify(e));
});

mat.addEventListener("tuneDidSucceedWithData", function(e){
    Ti.API.info("event 'tuneDidSucceedWithData' => " + JSON.stringify(e));
});

mat.addEventListener("tuneDidFailWithError", function(e){
    Ti.API.info("event 'tuneDidFailWithError' => " + JSON.stringify(e));
});

var button = Titanium.UI.createButton({ title: 'Start MAT', top: 45, width: Ti.UI.FILL, height: 200, borderWidth:1, borderRadius:8 });
button.addEventListener('click',function(e) {
    var advId = "877";
    var convKey = "8c14d6bbe466b65211e781d62e301eec";
    var pkgName = "com.hasoffers.titaniumsample";
    
    mat.initTracker(advId, convKey);
    mat.setPackageName(pkgName);
    mat.setDelegate(true);
    
    mat.checkForDeferredDeeplink(function(result) {
        var deeplink = result['deeplink'];
        var error = result['error'];
        console.log('deeplink is ' + deeplink);
        console.log('deeplink error is ' + error);
    });
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
button.addEventListener('click',function(e) { 
    mat.setAllowDuplicates(isMATDuplicatesAllowed);
});
scrollView.add(button);

var button = Titanium.UI.createButton({ title: 'Measure Session', top: 660, width: Ti.UI.FILL, height: 200, borderWidth:1, borderRadius:8 });
button.addEventListener('click',function(e) { 
    mat.measureSession();
});
scrollView.add(button);

var button = Titanium.UI.createButton({ title: 'Measure Event Name', top: 865, width: Ti.UI.FILL, height: 200, borderWidth:1, borderRadius:8 });
button.addEventListener('click',function(e) {
    mat.measureEventName("purchase");
});
scrollView.add(button);

var button = Titanium.UI.createButton({ title: 'Measure Event With Event Items', top: 1070, width: Ti.UI.FILL, height: 200, borderWidth:1, borderRadius:8 });
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

    mat.measureEvent({
        eventName: "purchaseWithItems",
        eventItems: eventItems,
        advertiserRefId: "ref2",
        revenue: 0.99,
        currencyCode: "USD",
        contentType: "testContentType",
        contentId: "testContentId",
        date1: new Date().getTime(),
        date2: new Date().getTime(),
        level: 3,
        quantity: 2,
        rating: 4.5,
        searchString: "testSearchString",
        attribute1: "attr1",
        attribute2: "attr2",
        attribute3: "attr3",
        attribute4: "attr4",
        attribute5: "attr5"
    });
});
scrollView.add(button);


var button = Titanium.UI.createButton({ title: 'Test Setter Methods', top: 1275, width: Ti.UI.FILL, height: 200, borderWidth:1, borderRadius:8 });
button.addEventListener('click',function(e) {

    mat.setAge(23);
    mat.setAppAdTracking(true);
    mat.setAppleAdvertisingIdentifier("12345678-1234-1234-1234-123456789012", false);
    mat.setAppleVendorIdentifier("12345678-1234-1234-1234-123456789012");
    mat.setCurrencyCode("tempCurrencyCode");
    mat.setExistingUser(false);
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

var button = Titanium.UI.createButton({ title: 'Test Getter Methods', top: 1480, width: Ti.UI.FILL, height: 200, borderWidth:1, borderRadius:8 });
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
