/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiMobileapptrackerModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

#import <Foundation/Foundation.h>

@interface Tune (TiMobileapptrackerModule)

+ (void)setPluginName:(NSString *)pluginName;

@end

@implementation TiMobileapptrackerModule



#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
    return @"f3c233bb-5f94-40d2-93a7-2ae3b77f8d9b";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
    return @"ti.mobileapptracker";
}

#pragma mark Lifecycle

-(void)startup
{
    // this method is called when the module is first loaded
    // you *must* call the superclass
    [super startup];
    
    NSLog(@"[INFO] TIMATModule: %@ loaded",self);
}

-(void)shutdown:(id)sender
{
    // this method is called when the module is being unloaded
    // typically this is during shutdown. make sure you don't do too
    // much processing here or the app will be quit forceably
    
    // you *must* call the superclass
    [super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
    // release any resources that have been retained by the module
    [super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
    // optionally release any resources that can be dynamically
    // reloaded once memory is available - such as caches
    [super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
    if (count == 1 && [type isEqualToString:@"my_event"])
    {
        // the first (of potentially many) listener is being added 
        // for event named 'my_event'
    }
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
    if (count == 0 && [type isEqualToString:@"my_event"])
    {
        // the last listener called for event named 'my_event' has
        // been removed, we can optionally clean up any resources
        // since no body is listening at this point for that event
    }
}

#pragma Public APIs

- (void)initTracker:(id)args
{
    NSArray *arr = args;
    NSLog(@"[INFO] TIMATModule: initTracker: arr  = %@", arr);
    
    NSString *aid = [arr objectAtIndex:0];
    NSString *key = [arr objectAtIndex:1];
    
    [Tune initializeWithTuneAdvertiserId:aid tuneConversionKey:key];
    [Tune setPluginName:@"titanium"];
}

- (void)setPackageName:(id)packageName
{
    NSLog(@"[INFO] TIMATModule: setPackageName");
    [Tune setPackageName:packageName];
}

- (void)checkForDeferredDeeplink:(id)args
{
    NSLog(@"[INFO] TIMATModule: checkForDeferredDeeplink");
    [Tune checkForDeferredDeeplink:self];
}

- (void)setDebugMode:(id)enable
{
    NSLog(@"[INFO] TIMATModule: setDebugMode");
    [Tune setDebugMode:[TiUtils boolValue:enable]];
}

- (void)setAllowDuplicates:(id)enable
{
    NSLog(@"[INFO] TIMATModule: setAllowDuplicates");
    [Tune setAllowDuplicateRequests:[TiUtils boolValue:enable]];
}

- (void)setDelegate:(id)enable
{
    NSLog(@"[INFO] TIMATModule: setDelegate");
    id<TuneDelegate> dele = [TiUtils boolValue:enable] ? self : nil;
    [Tune setDelegate:dele];
}

- (void)measureSession:(id)dummy
{
    NSLog(@"[INFO] TIMATModule: measureSession");
    [Tune measureSession];
}

- (void)measureEventName:(id)eventName
{
    NSLog(@"[INFO] TIMATModule: measureEventName");
    ENSURE_SINGLE_ARG(eventName, NSString);
    [Tune measureEventName:eventName];
}

- (void)measureEvent:(id)args
{
    NSLog(@"[INFO] TIMATModule: measureEvent");
    NSDictionary* eventDict = [args objectAtIndex:0];
    
    NSString* eventName = (NSString*)[eventDict objectForKey:@"eventName"];
    // If event name is nil, exit
    if (!eventName) {
        return;
    }
    
    // Construct TuneEvent from JS dictionary
    TuneEvent *event = [TuneEvent eventWithName:eventName];
    
    // Check if optional fields exist
    NSNumber* revenue = (NSNumber*)[eventDict objectForKey:@"revenue"];
    if (revenue) {
        event.revenue = [revenue floatValue];
    }
    NSString* currencyCode = (NSString*)[eventDict objectForKey:@"currencyCode"];
    if (currencyCode) {
        event.currencyCode = currencyCode;
    }
    NSString* advertiserRefId = (NSString*)[eventDict objectForKey:@"advertiserRefId"];
    if (advertiserRefId) {
        event.refId = advertiserRefId;
    }
    NSString* contentId = (NSString*)[eventDict objectForKey:@"contentId"];
    if (contentId) {
        event.contentId = contentId;
    }
    NSString* contentType = (NSString*)[eventDict objectForKey:@"contentType"];
    if (contentType) {
        event.contentType = contentType;
    }
    if ([eventDict objectForKey:@"date1"]) {
        event.date1 = [NSDate dateWithTimeIntervalSince1970:[((NSNumber*)[eventDict objectForKey:@"date1"]) doubleValue]/1000];
    }
    if ([eventDict objectForKey:@"date2"]) {
        event.date2 = [NSDate dateWithTimeIntervalSince1970:[((NSNumber*)[eventDict objectForKey:@"date2"]) doubleValue]/1000];
    }
    if ([eventDict objectForKey:@"level"]) {
        event.level = [(NSNumber*)[eventDict objectForKey:@"level"] intValue];
    }
    if ([eventDict objectForKey:@"quantity"]) {
        event.quantity = [(NSNumber*)[eventDict objectForKey:@"quantity"] intValue];
    }
    NSNumber* rating = (NSNumber*)[eventDict objectForKey:@"rating"];
    if (rating) {
        event.rating = [rating floatValue];
    }
    NSString* searchString = (NSString*)[eventDict objectForKey:@"searchString"];
    if (searchString) {
        event.searchString = searchString;
    }
    NSString* attribute1 = (NSString*)[eventDict objectForKey:@"attribute1"];
    if (attribute1) {
        event.attribute1 = attribute1;
    }
    NSString* attribute2 = (NSString*)[eventDict objectForKey:@"attribute2"];
    if (attribute2) {
        event.attribute2 = attribute2;
    }
    NSString* attribute3 = (NSString*)[eventDict objectForKey:@"attribute3"];
    if (attribute3) {
        event.attribute3 = attribute3;
    }
    NSString* attribute4 = (NSString*)[eventDict objectForKey:@"attribute4"];
    if (attribute4) {
        event.attribute4 = attribute4;
    }
    NSString* attribute5 = (NSString*)[eventDict objectForKey:@"attribute5"];
    if (attribute5) {
        event.attribute5 = attribute5;
    }
    NSString* receipt = (NSString*)[eventDict objectForKey:@"receipt"];
    if (receipt) {
        event.receipt = [receipt dataUsingEncoding:NSUTF8StringEncoding];;
    }
    if ([eventDict objectForKey:@"eventItems"]) {
        NSArray* eventItems = (NSArray*)[eventDict objectForKey:@"eventItems"];
        eventItems = [self convertToMATEventItems:eventItems];
        event.eventItems = eventItems;
    }
    
    [Tune measureEvent:event];
}

#pragma mark - Other Setter Methods

- (void)setSiteId:(id)siteId
{
    NSLog(@"[INFO] TIMATModule: setSiteId");
    [Tune setSiteId:siteId];
}

- (void)setCurrencyCode:(id)currencyCode
{
    NSLog(@"[INFO] TIMATModule: setCurrencyCode");
    [Tune setCurrencyCode:currencyCode];
}

- (void)setAppleAdvertisingIdentifier:(id)args
{
    NSLog(@"[INFO] TIMATModule: setAppleAdvertisingIdentifier");
    NSString *strAppleAdvId = [args objectAtIndex:0];
    
    NSNumber* strEnabled = [args objectAtIndex:1];
    BOOL enabled = [strEnabled boolValue];
    
    id classNSUUID = NSClassFromString(@"NSUUID");
    
    if(classNSUUID)
    {
        [Tune setAppleAdvertisingIdentifier:[[classNSUUID alloc] initWithUUIDString:strAppleAdvId] advertisingTrackingEnabled:enabled];
    }
}

- (void)setAppleVendorIdentifier:(id)vendorId
{
    NSLog(@"[INFO] TIMATModule: setAppleVendorIdentifier");
    NSString *strAppleVendorId = vendorId;
    id classNSUUID = NSClassFromString(@"NSUUID");
    if(classNSUUID)
    {
        [Tune setAppleVendorIdentifier:[[classNSUUID alloc] initWithUUIDString:strAppleVendorId]];
    }
}

- (void)setJailbroken:(id)jailBroken
{
    NSLog(@"[INFO] TIMATModule: setJailbroken");
    [Tune setJailbroken:[TiUtils boolValue:jailBroken]];
}

- (void)setAge:(id)age
{
    NSLog(@"[INFO] TIMATModule: setAge");
    [Tune setAge:[age intValue]];
}

- (void)setLocation:(id)args
{
    NSLog(@"[INFO] TIMATModule: setLocation");
    NSArray* arguments= args;
    if ([arguments count] == 2)
    {
        NSNumber* numLat = [arguments objectAtIndex:0];
        NSNumber* numLon = [arguments objectAtIndex:1];
        
        TuneLocation *loc = [TuneLocation new];
        loc.latitude = numLat;
        loc.longitude = numLon;
        [Tune setLocation:loc];
    }
}

- (void)setLocationWithAltitude:(id)args
{
    NSLog(@"[INFO] TIMATModule: setLocationWithAltitude");
    NSArray* arguments= args;
    if ([arguments count] == 3)
    {
        NSNumber* numLat = [arguments objectAtIndex:0];
        NSNumber* numLon = [arguments objectAtIndex:1];
        NSNumber* numAlt = [arguments objectAtIndex:2];
        
        TuneLocation *loc = [TuneLocation new];
        loc.latitude = numLat;
        loc.longitude = numLon;
        loc.altitude = numAlt;
        [Tune setLocation:loc];
    }
}

- (void)setExistingUser:(id)enable
{
    NSLog(@"[INFO] TIMATModule: setExistingUser");
    [Tune setExistingUser:[TiUtils boolValue:enable]];
}

- (void)setFacebookEventLogging:(id)args
{
    NSLog(@"[INFO] TIMATModule: setFacebookEventLogging");
    NSArray* arguments= args;
    if ([arguments count] == 2)
    {
        NSNumber* numEnable = [arguments objectAtIndex:0];
        NSNumber* numLimit = [arguments objectAtIndex:1];
        
        BOOL enable = [numEnable boolValue];
        BOOL limit = [numLimit boolValue];
        
        [Tune setFacebookEventLogging:enable limitEventAndDataUsage:limit];
    }
}

- (void)setPayingUser:(id)enable
{
    NSLog(@"[INFO] TIMATModule: setPayingUser");
    [Tune setPayingUser:[TiUtils boolValue:enable]];
}

- (void)setUseCookieMeasurement:(id)enable
{
    NSLog(@"[INFO] TIMATModule: setUseCookieTracking");
    [Tune setUseCookieMeasurement:[TiUtils boolValue:enable]];
}

- (void)setShouldAutoDetectJailbroken:(id)autoDetect
{
    NSLog(@"[INFO] TIMATModule: setShouldAutoDetectJailbroken");
    [Tune setShouldAutoDetectJailbroken:[TiUtils boolValue:autoDetect]];
}

- (void)setShouldAutoGenerateAppleVendorIdentifier:(id)autoGen
{
    NSLog(@"[INFO] TIMATModule: setShouldAutoGenerateAppleVendorIdentifier");
    [Tune setShouldAutoGenerateAppleVendorIdentifier:[TiUtils boolValue:autoGen]];
}

- (void)setAppAdMeasurement:(id)enable
{
    NSLog(@"[INFO] TIMATModule: setAppAdTracking");
    [Tune setAppAdMeasurement:[TiUtils boolValue:enable]];
}

- (void)setGender:(id)gender
{
    NSLog(@"[INFO] TIMATModule: setGender");
    [Tune setGender:[TiUtils intValue:gender]];
}

- (void)setUserId:(id)userId
{
    NSLog(@"[INFO] TIMATModule: setUserId");
    [Tune setUserId:userId];
}

- (void)setTRUSTeId:(id)tpid
{
    NSLog(@"[INFO] TIMATModule: setTRUSTeId");
    [Tune setTRUSTeId:tpid];
}

- (void)setUserName:(id)userName
{
    NSLog(@"[INFO] TIMATModule: setUserName");
    [Tune setUserName:userName];
}

- (void)setUserEmail:(id)userEmail
{
    NSLog(@"[INFO] TIMATModule: setUserEmail");
    [Tune setUserEmail:userEmail];
}

- (void)setFacebookUserId:(id)userId
{
    NSLog(@"[INFO] TIMATModule: setFacebookUserId");
    [Tune setFacebookUserId:userId];
}

- (void)setGoogleUserId:(id)userId
{
    NSLog(@"[INFO] TIMATModule: setGoogleUserId");
    [Tune setGoogleUserId:userId];
}

- (void)setTwitterUserId:(id)userId
{
    NSLog(@"[INFO] TIMATModule: setTwitterUserId");
    [Tune setTwitterUserId:userId];
}

- (void)setGoogleAdvertisingId:(id)advId
{
    // Android only method, no-op on iOS
}

- (void)applicationDidOpenURL:(id)args
{
    NSLog(@"[INFO] TIMATModule: applicationDidOpenURL");
    NSArray* arguments = args;
    if ([arguments count] == 2)
    {
        NSString* strURL = [arguments objectAtIndex:0];
        NSString* strSource = [arguments objectAtIndex:1];
        
        [Tune applicationDidOpenURL:strURL sourceApplication:strSource];
    }
}

- (void)setRedirectUrl:(id)strURL
{
    NSLog(@"[INFO] TIMATModule: setRedirectUrl");
    [Tune setRedirectUrl:strURL];
}

#pragma mark - Getter Methods

- (id)getMatId:(id)dummy
{
    NSLog(@"[INFO] TIMATModule: getMatId");
    return [Tune matId];
}

- (id)getOpenLogId:(id)dummy
{
    NSLog(@"[INFO] TIMATModule: getOpenLogId");
    return [Tune openLogId];
}

- (id)getIsPayingUser:(id)dummy
{
    NSLog(@"[INFO] TIMATModule: getIsPayingUser");
    return [NSNumber numberWithBool:[Tune isPayingUser]];
}

#pragma mark - Helper Methods

- (NSArray *)convertToMATEventItems:(NSArray *)arrDictionaries
{
    NSMutableArray *arrItems = [NSMutableArray array];
    
    for (NSDictionary *dict in arrDictionaries) {
        
        NSString *name = (NSString *)[dict objectForKey:@"item"];
        NSString *strUnitPrice = (NSString *)[dict objectForKey:@"unit_price"];
        float unitPrice = [NSNull null] == (id)strUnitPrice ? 0 : [strUnitPrice floatValue];
        
        NSString *strQuantity = (NSString *)[dict objectForKey:@"quantity"];
        int quantity = [NSNull null] == (id)strQuantity ? 0 : [strQuantity intValue];
        
        NSString *strRevenue = (NSString *)[dict objectForKey:@"revenue"];
        float revenue = [NSNull null] == (id)strRevenue ? 0 : [strRevenue floatValue];
        
        NSString *attribute1 = (NSString *)[dict objectForKey:@"attribute1"];
        NSString *attribute2 = (NSString *)[dict objectForKey:@"attribute2"];
        NSString *attribute3 = (NSString *)[dict objectForKey:@"attribute3"];
        NSString *attribute4 = (NSString *)[dict objectForKey:@"attribute4"];
        NSString *attribute5 = (NSString *)[dict objectForKey:@"attribute5"];
        
        TuneEventItem *item = [TuneEventItem eventItemWithName:name
                                                     unitPrice:unitPrice
                                                      quantity:quantity
                                                       revenue:revenue
                                                    attribute1:attribute1
                                                    attribute2:attribute2
                                                    attribute3:attribute3
                                                    attribute4:attribute4
                                                    attribute5:attribute5];
        
        [arrItems addObject:item];
    }
    
    return arrItems;
}

static const char * MAT_DATE_TIME_FORMAT = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"; // ISO 8601 Extended Format (always UTC) -- http://www.w3schools.com/jsref/jsref_toisostring.asp

NSDateFormatter* dateFormatter()
{
    static NSDateFormatter* sharedDateFormatter = nil;
    
    if(nil == sharedDateFormatter)
    {
        sharedDateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        
        [sharedDateFormatter setLocale:enUSPOSIXLocale];
        [sharedDateFormatter setDateFormat:[NSString stringWithUTF8String:MAT_DATE_TIME_FORMAT]];
        [sharedDateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    }
    
    return sharedDateFormatter;
}

#pragma mark - TuneDelegate Methods

- (void)tuneDidSucceedWithData:(id)data
{
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"[INFO] TIMATModule tuneDidSucceedWithData: %@", str);
    
    NSDictionary *dict = @{@"data":str ? str : @""};
    
    [self fireEvent:@"tuneDidSucceedWithData" withObject:dict];
}

- (void)tuneDidFailWithError:(NSError *)error
{
    NSLog(@"[INFO] TIMATModule tuneDidFailWithError: %@", error);
    
    [self fireEvent:@"tuneDidFailWithError" withObject:error.userInfo errorCode:error.code message:error.description];
}

- (void)tuneEnqueuedActionWithReferenceId:(NSString *)referenceId
{
    NSLog(@"[INFO] TIMATModule tuneEnqueuedActionWithReferenceId: %@", referenceId);
    
    NSDictionary *dict = @{@"refId":referenceId ? referenceId : @""};
    
    [self fireEvent:@"tuneEnqueuedActionWithReferenceId" withObject:dict];
}

- (void)tuneDidReceiveDeeplink:(NSString *)deeplink
{
    NSLog(@"[INFO] TIMATModule tuneDidReceiveDeeplink: %@", deeplink);
    NSDictionary *dict = @{@"deeplink":deeplink ? deeplink : @""};
    [self fireEvent:@"tuneDidReceiveDeeplink" withObject:dict];
}

- (void)tuneDidFailDeeplinkWithError:(NSError *)error
{
    NSLog(@"[INFO] TIMATModule tuneDidFailDeeplinkWithError: %@", error);
    NSDictionary *dict = @{@"error":error ? error : @""};
    [self fireEvent:@"tuneDidFailDeeplinkWithError" withObject:dict];
}

@end
