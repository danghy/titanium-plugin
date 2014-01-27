# MobileAppTracker Module

## Description

Lets you use the MobileAppTracking SDK for Titanium to track app installs and events for attribution.

## Getting Started

View the following documents for instructions on getting started with using this module in your application.

[Using Titanium Modules](http://docs.appcelerator.com/titanium/latest/#!/guide/Using_Titanium_Modules) 
[Using a Module](http://docs.appcelerator.com/titanium/latest/#!/guide/Using_a_Module)


The iOS and Android module zip files are located at `dist`.



## Manually Building the Android Module

Modify the `<project_dir>/build/generated/jni/Android.mk`

1) Add `”-I$(NDK_PATH)/platforms/$(TARGET_PLATFORM)/arch-arm/usr/include”` to `LOCAL_CFLAGS` to make it look similar to:

    LOCAL_CFLAGS := -g "-I$(TI_MOBILE_SDK)/android/native/include" "-I$(NDK_PATH)/platforms/$(TARGET_PLATFORM)/arch-arm/usr/include"

2) By default, Android NDK compiled code is compiled with format string protection. This forces a compiler error if a non-constant format string is used in a printf style function. Add the following line to disable this:

    LOCAL_DISABLE_FORMAT_STRING_CHECKS=true

** JAB 12/5/13: Step 1 doesn't seem necessary; step 2 doesn't help.**  
This on Mac with NDK r9 and Titanium 3.1.3. Instead, the step 2 fix was
modifying `~/Library/Application\ Support/Titanium/mobilesdk/osx/3.1.3.GA/module/android/build.xml` by inserting `<arg value="LOCAL_DISABLE_FORMAT_STRING_CHECKS=true"/>`
at line 287 (inside `<exec executable="${ndk.build}">...</exec>`).



## Author

HasOffers Inc

## License

Copyright (c) 2013-2014 HasOffers. Please see the LICENSE file included in the distribution for further details.
