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
    
    NSLog(@"[INFO] %@ loaded",self);
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
    NSLog(@"[INFO] initTracker: arr  = %@", arr);
    
    NSString *aid = [arr objectAtIndex:0];
    NSString *key = [arr objectAtIndex:1];
    
    [MobileAppTracker initializeWithMATAdvertiserId:aid MATConversionKey:key];
    
    [MobileAppTracker setPluginName:@"titanium"];
}

- (void)setPackageName:(id)packageName
{
    NSLog(@"[INFO] setPackageName")
    
    [MobileAppTracker setPackageName:packageName];
}

- (void)setDebugMode:(id)enable
{
    NSLog(@"[INFO] setDebugMode")
    
    [MobileAppTracker setDebugMode:[TiUtils boolValue:enable]];
}

- (void)setAllowDuplicates:(id)enable
{
    NSLog(@"[INFO] setAllowDuplicates")
    
    [MobileAppTracker setAllowDuplicateRequests:[TiUtils boolValue:enable]];
}

- (void)setDelegate:(id)enable
{
    NSLog(@"[INFO] setDelegate")
    
    id<MobileAppTrackerDelegate> dele = [TiUtils boolValue:enable] ? self : nil;
    
    [MobileAppTracker setDelegate:dele];
}

- (void)measureSession:(id)dummy
{
    NSLog(@"[INFO] measureSession")
    
    [MobileAppTracker measureSession];
}

- (void)measureAction:(id)args
{
    NSLog(@"[INFO] measureAction")
    
    NSArray *arr = args;
    
    int paramCount = arr ? [arr count] : 0;
    
    if(paramCount > 0)
    {
        NSString *strEvent = [arr objectAtIndex:0];
        NSString *strRefId = nil;
        double revenue = 0;
        NSString *strCurrency = nil;
        
        if(paramCount > 1)
        {
            strRefId = [arr objectAtIndex:1];
            
            if(paramCount > 2)
            {
                NSNumber* numRev = [arr objectAtIndex:2];
                revenue = [numRev doubleValue];
                
                if(paramCount > 3)
                {
                    strCurrency = [arr objectAtIndex:3];
                }
            }
        }
        
        [MobileAppTracker measureAction:strEvent
                            referenceId:strRefId
                          revenueAmount:revenue
                           currencyCode:strCurrency];
    }
}

- (void)measureActionWithItems:(id)args
{
    NSLog(@"[INFO] TIMATModule: measureActionWithItems");
    
    NSArray *arr = args;
    
    int paramCount = arr ? [arr count] : 0;
    
    if(paramCount > 0)
    {
        NSString *strEvent = [arr objectAtIndex:0];
        NSArray *arrItems = nil;
        NSString *strRefId = nil;
        double revenue = 0;
        NSString *strCurrency = nil;
        
        if(paramCount > 1)
        {
            arrItems = [arr objectAtIndex:1];
            arrItems = [NSNull null] == (id)arrItems ? nil : arrItems;
            arrItems = [self convertToMATEventItems:arrItems];
            
            if(paramCount > 2)
            {
                strRefId = [arr objectAtIndex:2];
                
                if(paramCount > 3)
                {
                    NSNumber* numRev = [arr objectAtIndex:3];
                    revenue = [numRev doubleValue];
                    
                    if(paramCount > 4)
                    {
                        strCurrency = [arr objectAtIndex:4];
                    }
                }
            }
        }
        
        [MobileAppTracker measureAction:strEvent
                             eventItems:arrItems
                            referenceId:strRefId
                          revenueAmount:revenue
                           currencyCode:strCurrency];
    }
}

- (void)measureActionWithReceipt:(id)args
{
    NSLog(@"[INFO] TIMATModule: measureActionWithReceipt");
    
    NSArray *arr = args;
    
    if (arr && [arr count] > 6)
    {
        NSString *strEvent = [arr objectAtIndex:0];
        
        NSArray *arrItems = [arr objectAtIndex:1];
        arrItems = [NSNull null] == (id)arrItems ? nil : arrItems;
        
        arrItems = [self convertToMATEventItems:arrItems];
        
        NSString *strRefId = [arr objectAtIndex:2];
        
        NSNumber* numRev = [arr objectAtIndex:3];
        double revenue = [numRev doubleValue];
        
        NSString *strCurrency = [arr objectAtIndex:4];
        
        NSNumber* numTransactionState = [arr objectAtIndex:5];
        int transactionState = [numTransactionState intValue];
        
        NSString *strReceipt = [arr objectAtIndex:6];
        NSData *receiptData = [strReceipt dataUsingEncoding:NSUTF8StringEncoding];
        
        // receiptSignature -- only for Android, ignore on iPhone
        
        [MobileAppTracker measureAction:strEvent
                             eventItems:arrItems
                            referenceId:strRefId
                          revenueAmount:revenue
                           currencyCode:strCurrency
                       transactionState:transactionState
                                receipt:receiptData];
    }
}

#pragma mark - Other Setter Methods

- (void)setSiteId:(id)siteId
{
    NSLog(@"[INFO] TIMATModule: setSiteId");
    
    [MobileAppTracker setSiteId:siteId];
}

- (void)setCurrencyCode:(id)currencyCode
{
    NSLog(@"[INFO] TIMATModule: setCurrencyCode");
    
    [MobileAppTracker setCurrencyCode:currencyCode];
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
        [MobileAppTracker setAppleAdvertisingIdentifier:[[classNSUUID alloc] initWithUUIDString:strAppleAdvId] advertisingTrackingEnabled:enabled];
    }
}

- (void)setAppleVendorIdentifier:(id)vendorId
{
    NSLog(@"[INFO] TIMATModule: setAppleVendorIdentifier");
    
    NSString *strAppleVendorId = vendorId;
            
    id classNSUUID = NSClassFromString(@"NSUUID");
    
    if(classNSUUID)
    {
        [MobileAppTracker setAppleVendorIdentifier:[[classNSUUID alloc] initWithUUIDString:strAppleVendorId]];
    }
}

- (void)setJailbroken:(id)jailBroken
{
    NSLog(@"[INFO] TIMATModule: setJailbroken");
    
    [MobileAppTracker setJailbroken:[TiUtils boolValue:jailBroken]];
}

- (void)setAge:(id)age
{
    NSLog(@"[INFO] TIMATModule: setAge");
    
    [MobileAppTracker setAge:[age intValue]];
}

- (void)setLocation:(id)args
{
    NSLog(@"[INFO] TIMATModule: setLocation");
    
    NSArray* arguments= args;
    
    if ([arguments count] == 2)
    {
        NSNumber* numLat = [arguments objectAtIndex:0];
        NSNumber* numLon = [arguments objectAtIndex:1];
        
        CGFloat lat = [numLat doubleValue];
        CGFloat lon = [numLon doubleValue];
        
        [MobileAppTracker setLatitude:lat longitude:lon];
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
        
        CGFloat lat = [numLat doubleValue];
        CGFloat lon = [numLon doubleValue];
        CGFloat alt = [numAlt doubleValue];
        
        [MobileAppTracker setLatitude:lat longitude:lon altitude:alt];
    }
}

- (void)setExistingUser:(id)enable
{
    NSLog(@"[INFO] TIMATModule: setExistingUser");
    
    [MobileAppTracker setExistingUser:[TiUtils boolValue:enable]];
}

- (void)setPayingUser:(id)enable
{
    NSLog(@"[INFO] TIMATModule: setPayingUser");
    
    [MobileAppTracker setPayingUser:[TiUtils boolValue:enable]];
}

- (void)setUseCookieTracking:(id)enable
{
    NSLog(@"[INFO] TIMATModule: setUseCookieTracking");
    
    [MobileAppTracker setUseCookieTracking:[TiUtils boolValue:enable]];
}

- (void)setShouldAutoDetectJailbroken:(id)autoDetect
{
    NSLog(@"[INFO] TIMATModule: setShouldAutoDetectJailbroken");
    
    [MobileAppTracker setShouldAutoDetectJailbroken:[TiUtils boolValue:autoDetect]];
}

- (void)setShouldAutoGenerateAppleVendorIdentifier:(id)autoGen
{
    NSLog(@"[INFO] TIMATModule: setShouldAutoGenerateAppleVendorIdentifier");
    
    [MobileAppTracker setShouldAutoGenerateAppleVendorIdentifier:[TiUtils boolValue:autoGen]];
}

- (void)setAppAdTracking:(id)enable
{
    NSLog(@"[INFO] TIMATModule: setAppAdTracking");
    
    [MobileAppTracker setAppAdTracking:[TiUtils boolValue:enable]];
}

- (void)setGender:(id)gender
{
    NSLog(@"[INFO] TIMATModule: setGender");
    
    [MobileAppTracker setGender:[TiUtils intValue:gender]];
}

- (void)setUserId:(id)userId
{
    NSLog(@"[INFO] TIMATModule: setUserId");
    
    [MobileAppTracker setUserId:userId];
}

- (void)setTRUSTeId:(id)tpid
{
    NSLog(@"[INFO] TIMATModule: setTRUSTeId");
    
    [MobileAppTracker setTRUSTeId:tpid];
}

- (void)setUserName:(id)userName
{
    NSLog(@"[INFO] TIMATModule: setUserName");
    
    [MobileAppTracker setUserName:userName];
}

- (void)setUserEmail:(id)userEmail
{
    NSLog(@"[INFO] TIMATModule: setUserEmail");
    
    [MobileAppTracker setUserEmail:userEmail];
}

- (void)setFacebookUserId:(id)userId
{
    NSLog(@"[INFO] TIMATModule: setFacebookUserId");
    
    [MobileAppTracker setFacebookUserId:userId];
}

- (void)setGoogleUserId:(id)userId
{
    NSLog(@"[INFO] TIMATModule: setGoogleUserId");
    
    [MobileAppTracker setGoogleUserId:userId];
}

- (void)setTwitterUserId:(id)userId
{
    NSLog(@"[INFO] TIMATModule: setTwitterUserId");
    
    [MobileAppTracker setTwitterUserId:userId];
}

- (void)setEventAttribute1:(id)attr
{
    NSLog(@"[INFO] TIMATModule: setEventAttribute1");
    
    [MobileAppTracker setEventAttribute1:attr];
}

- (void)setEventAttribute2:(id)attr
{
    NSLog(@"[INFO] TIMATModule: setEventAttribute2");
    
    [MobileAppTracker setEventAttribute2:attr];
}

- (void)setEventAttribute3:(id)attr
{
    NSLog(@"[INFO] TIMATModule: setEventAttribute3");
    
    [MobileAppTracker setEventAttribute3:attr];
}

- (void)setEventAttribute4:(id)attr
{
    NSLog(@"[INFO] TIMATModule: setEventAttribute4");
    
    [MobileAppTracker setEventAttribute4:attr];
}

- (void)setEventAttribute5:(id)attr
{
    NSLog(@"[INFO] TIMATModule: setEventAttribute5");
    
    [MobileAppTracker setEventAttribute5:attr];
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
        
        [MobileAppTracker applicationDidOpenURL:strURL sourceApplication:strSource];
    }
}

- (void)startAppToAppTracking:(id)args
{
    NSLog(@"[INFO] TIMATModule: startAppToAppTracking");
    
    NSArray* arguments = args;
    
    if ([arguments count] == 5)
    {
        NSString* strTargetAppPackageName = [arguments objectAtIndex:0];
        NSString* strTargetAdvId = [arguments objectAtIndex:1];
        NSString* strTargetOfferId = [arguments objectAtIndex:2];
        NSString* strTargetPublisherId = [arguments objectAtIndex:3];
        NSString* strShouldRedirect = [arguments objectAtIndex:4];
        BOOL shouldRedirect = [strShouldRedirect boolValue];
        
        [MobileAppTracker startAppToAppTracking:strTargetAppPackageName
                                   advertiserId:strTargetAdvId
                                        offerId:strTargetOfferId
                                    publisherId:strTargetPublisherId
                                       redirect:shouldRedirect];
    }
}

- (void)setRedirectUrl:(id)strURL
{
    NSLog(@"[INFO] TIMATModule: setRedirectUrl");
    
    [MobileAppTracker setRedirectUrl:strURL];
}

#pragma mark - Getter Methods

- (id)getMatId:(id)dummy
{
    NSLog(@"[INFO] TIMATModule: getMatId");
    
    return [MobileAppTracker matId];
}

- (id)getOpenLogId:(id)dummy
{
    NSLog(@"[INFO] TIMATModule: getOpenLogId");
    
    return [MobileAppTracker openLogId];
}

- (id)getIsPayingUser:(id)dummy
{
    NSLog(@"[INFO] TIMATModule: getIsPayingUser");
    
    return [NSNumber numberWithBool:[MobileAppTracker isPayingUser]];
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
        
        MATEventItem *item = [MATEventItem eventItemWithName:name
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

#pragma mark - MobileAppTrackerDelegate Methods

- (void)mobileAppTrackerDidSucceedWithData:(id)data
{
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"[INFO] TIMATModule MAT didSucceed: %@", str);
}

- (void)mobileAppTrackerDidFailWithError:(NSError *)error
{
    NSLog(@"[INFO] TIMATModule MAT didFail: %@", error);
}

- (void)mobileAppTrackerEnqueuedActionWithReferenceId:(NSString *)referenceId
{
    NSLog(@"[INFO] TIMATModule MAT didEnqueue: %@", referenceId);
}

@end
