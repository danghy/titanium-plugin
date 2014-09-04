/**
 * This file was auto-generated by the Titanium Module SDK helper for Android
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2013 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 *
 */
package ti.mobileapptracker;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.SimpleTimeZone;

import org.appcelerator.kroll.KrollModule;
import org.appcelerator.kroll.annotations.Kroll;
import org.appcelerator.titanium.TiApplication;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.mobileapptracker.MATEventItem;
import com.mobileapptracker.MobileAppTracker;

@Kroll.module(name="Mobileapptracker", id="ti.mobileapptracker")
public class MobileapptrackerModule extends KrollModule {
    // You can define constants with @Kroll.constant, for example:
    // @Kroll.constant public static final String EXTERNAL_NAME = value;
    
    private static MobileAppTracker mat = null;
    
    private final String MAT_DATE_TIME_FORMAT = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"; // ISO 8601 Extended Format (always UTC) -- http://www.w3schools.com/jsref/jsref_toisostring.asp
    
    public MobileapptrackerModule() {
        super();
    }
    
    @Kroll.onAppCreate
    public static void onAppCreate(TiApplication app) {
        // put module init code that needs to run when the application is created
    }
    
    @Kroll.method
    public void initTracker(String advId, String convKey) {
        
        MobileAppTracker.init(getActivity(), advId, convKey);
        
        mat = MobileAppTracker.getInstance();
        
        mat.setPluginName("titanium");
    }
    
    @Kroll.method
    public void measureSession() {
        mat.measureSession();
    }
    
    @Kroll.method
    public void measureAction(String eventIdOrName) {
        mat.measureAction(eventIdOrName);
    }
    
    @Kroll.method
    public void measureAction(String eventIdOrName, String refId) {
        mat.measureAction(eventIdOrName, 0, null, refId);
    }
    
    @Kroll.method
    public void measureAction(String eventIdOrName, double revenue, String currency) {
        mat.measureAction(eventIdOrName, revenue, currency);
    }
    
    @Kroll.method
    public void measureAction(String eventIdOrName, String refId, double revenue, String currency) {
        mat.measureAction(eventIdOrName, revenue, currency, refId);
    }
    
    @Kroll.method
    public void measureActionWithItems(String eventIdOrName, Object[] items) {
        measureActionWithReceipt(eventIdOrName, items, null, 0, null, 0, null, null);
    }
    
    @Kroll.method
    public void measureActionWithItems(String eventIdOrName, Object[] items, String refId) {
        measureActionWithReceipt(eventIdOrName, items, refId, 0, null, 0, null, null);
    }
    
    @Kroll.method
    public void measureActionWithItems(String eventIdOrName, Object[] items, String refId, double revenueAmount, String currencyCode) {
        measureActionWithReceipt(eventIdOrName, items, refId, revenueAmount, currencyCode, 0, null, null);
    }
    
    @Kroll.method
    public void measureActionWithReceipt(String eventIdOrName, Object[] items, String refId, double revenueAmount, String currencyCode, int transactionState, String receipt, String receiptSignature) {    
        List<MATEventItem> listItems = convertToMATEventItems(items);
        
        if (receiptSignature != null && !receiptSignature.isEmpty()) {
            mat.measureAction(eventIdOrName, listItems, revenueAmount, currencyCode, refId, receipt, receiptSignature);
        } else {
            mat.measureAction(eventIdOrName, listItems, revenueAmount, currencyCode, refId);
        }
    }
    
    @Kroll.method
    public void setAge(int age) {
        mat.setAge(age);
    }
    
    @Kroll.method
    public void setAllowDuplicates(boolean allowDuplicates) {
        mat.setAllowDuplicates(allowDuplicates);
    }
    
    @Kroll.method
    public void setAndroidId(String androidId) {
        mat.setAndroidId(androidId);
    }
    
    @Kroll.method
    public void setAppAdTracking(boolean allowAdTracking) {
        mat.setAppAdTrackingEnabled(allowAdTracking);
    }
    
    @Kroll.method
    public void setCurrencyCode(String currencyCode) {
        mat.setCurrencyCode(currencyCode);
    }
    
    @Kroll.method
    public void setDebugMode(boolean debugMode) {
        mat.setDebugMode(debugMode);
    }
    
    @Kroll.method
    public void setExistingUser(boolean existing) {
        mat.setExistingUser(existing);
    }
    
    @Kroll.method
    public void setGender(int gender) {
        mat.setGender(MobileAppTracker.GENDER_FEMALE == gender ? MobileAppTracker.GENDER_FEMALE : MobileAppTracker.GENDER_MALE);
    }
    
    @Kroll.method
    public void setInstallReferrer(String referrer) {
        mat.setInstallReferrer(referrer);
    }
    
    @Kroll.method
    public void setLocation(double latitude, double longitude) {
        mat.setLatitude(latitude);
        mat.setLongitude(longitude);
    }
    
    @Kroll.method
    public void setLocationWithAltitude(double latitude, double longitude, double altitude) {
        mat.setLatitude(latitude);
        mat.setLongitude(longitude);
        mat.setAltitude(altitude);
    }
    
    @Kroll.method
    public void setPackageName(String packageName) {
        mat.setPackageName(packageName);
    }

    @Kroll.method
    public void setPayingUser(boolean paying) {
        mat.setIsPayingUser(paying);
    }
    
    @Kroll.method
    public void setSiteId(String siteId) {
        mat.setSiteId(siteId);
    }
    
    @Kroll.method
    public void setUserId(String userId) {
        mat.setUserId(userId);
    }
    
    @Kroll.method
    public void setUserEmail(String user_email) {
        mat.setUserEmail(user_email);
    }
    
    @Kroll.method
    public void setUserName(String user_name) {
        mat.setUserName(user_name);
    }

    @Kroll.method
    public void setFacebookUserId(String facebookUserId) {
        mat.setFacebookUserId(facebookUserId);
    }

    @Kroll.method
    public void setTwitterUserId(String twitterUserId) {
        mat.setTwitterUserId(twitterUserId);
    }

    @Kroll.method
    public void setGoogleUserId(String googleUserId) {
        mat.setGoogleUserId(googleUserId);
    }
    
    @Kroll.method
    public void setGoogleAdvertisingId(String adId, boolean isLATEnabled) {
        mat.setGoogleAdvertisingId(adId, isLATEnabled);
    }
    
    @Kroll.method
    public void setEventAttribute1(String attr) {
        mat.setEventAttribute1(attr);
    }
    
    @Kroll.method
    public void setEventAttribute2(String attr) {
        mat.setEventAttribute2(attr);
    }
    
    @Kroll.method
    public void setEventAttribute3(String attr) {
        mat.setEventAttribute3(attr);
    }
    
    @Kroll.method
    public void setEventAttribute4(String attr) {
        mat.setEventAttribute4(attr);
    }
    
    @Kroll.method
    public void setEventAttribute5(String attr) {
        mat.setEventAttribute5(attr);
    }
    
    @Kroll.method
    public void setEventContentId(String contentId) {
        
        mat.setEventContentId(contentId);
    }
    
    @Kroll.method
    public void setEventContentType(String contentType) {
        mat.setEventContentType(contentType);
    }
    
    @Kroll.method
    public void setEventDate1(String dateString) {
        
        SimpleDateFormat sdf = new SimpleDateFormat(MAT_DATE_TIME_FORMAT, Locale.ENGLISH);
        sdf.setTimeZone(new SimpleTimeZone(SimpleTimeZone.UTC_TIME, "UTC"));
        
        Date date;
        
        try {
            date = sdf.parse(dateString);
            
            mat.setEventDate1(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
    
    @Kroll.method
    public void setEventDate2(String dateString) {
        
        SimpleDateFormat sdf = new SimpleDateFormat(MAT_DATE_TIME_FORMAT, Locale.ENGLISH);
        sdf.setTimeZone(new SimpleTimeZone(SimpleTimeZone.UTC_TIME, "UTC"));
        
        Date date;
        
        try {
            date = sdf.parse(dateString);
            
            mat.setEventDate2(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
    
    @Kroll.method
    public void setEventLevel(int level) {
        mat.setEventLevel(level);
    }
    
    @Kroll.method
    public void setEventQuantity(int quantity) {
        
        mat.setEventQuantity(quantity);
    }
    
    @Kroll.method
    public void setEventRating(int rating) {
        mat.setEventRating(rating);
    }

    @Kroll.method
    public void setEventSearchString(String searchString) {
        mat.setEventSearchString(searchString);
    }
    
    /////////////////////////////////
    // Getter methods
    /////////////////////////////////
    
    @Kroll.method
    public String getMatId() {
        return mat.getMatId();
    }
    
    @Kroll.method
    public String getOpenLogId() {
        return mat.getOpenLogId();
    }
    
    @Kroll.method
    public boolean getIsPayingUser() {
        return mat.getIsPayingUser();
    }
    
    /////////////////////////////////
    // Android no-op methods
    /////////////////////////////////
    
    @Kroll.method
    public void setDelegate(boolean enable) {
        // no-op
    }
    
    @Kroll.method
    public void setJailbroken(boolean isJailbroken) {
        // no-op
    }
    
    @Kroll.method
    public void setShouldAutoDetectJailbroken(boolean shouldAutoDetect) {
        // no-op
    }
    
    @Kroll.method
    public void setUseCookieTracking(boolean useCookieTracking) {
        // no-op
    }
    
    @Kroll.method
    public void setRedirectUrl(String redirectUrl) {
        // no-op
    }
    
    @Kroll.method
    public void setTRUSTeId(String tpid) {
        // no-op
    }
    
    @Kroll.method
    public void setAppleAdvertisingIdentifier(String advertiserId, boolean trackingEnabled) {
        // no-op
    }
    
    @Kroll.method
    public void setAppleVendorIdentifier(String vendorId) {
        // no-op
    }
    
    @Kroll.method
    public void setShouldAutoGenerateAppleVendorIdentifier(boolean shouldAutoGenerate) {
        // no-op
    }
    
    private List<MATEventItem> convertToMATEventItems(Object[] arrItemMaps) {
        List<MATEventItem> listItems = new ArrayList<MATEventItem>();

        try {
            JSONArray arr = new JSONArray(Arrays.toString(arrItemMaps));

            for (int i = 0; i < arr.length(); i++) {
                JSONObject item = arr.getJSONObject(i);

                String itemName = item.getString("item");
                int quantity = 0;
                double unitPrice = 0;
                double revenue = 0;
                String attribute1 = null;
                String attribute2 = null;
                String attribute3 = null;
                String attribute4 = null;
                String attribute5 = null;

                if (item.has("quantity")) {
                    quantity = item.getInt("quantity");
                }
                if (item.has("unit_price")) {
                    unitPrice = item.getDouble("unit_price");
                }
                if (item.has("revenue")) {
                    revenue = item.getDouble("revenue");
                }

                if (item.has("attribute_sub1")) {
                    attribute1 = item.getString("attribute_sub1");
                }
                if (item.has("attribute_sub2")) {
                    attribute2 = item.getString("attribute_sub2");
                }
                if (item.has("attribute_sub3")) {
                    attribute3 = item.getString("attribute_sub3");
                }
                if (item.has("attribute_sub4")) {
                    attribute4 = item.getString("attribute_sub4");
                }
                if (item.has("attribute_sub5")) {
                    attribute5 = item.getString("attribute_sub5");
                }

                MATEventItem eventItem = new MATEventItem(itemName, quantity, unitPrice, revenue, attribute1, attribute2, attribute3, attribute4, attribute5);
                listItems.add(eventItem);
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }

        return listItems;
    }
}

