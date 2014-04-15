/**
 * This file was auto-generated by the Titanium Module SDK helper for Android
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2013 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 *
 */
package com.hasoffers.gaidwrapper;

import org.appcelerator.kroll.KrollDict;
import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;
import org.appcelerator.titanium.TiC;
import org.appcelerator.titanium.util.Log;
import org.appcelerator.titanium.util.TiConvert;
import org.appcelerator.titanium.proxy.TiViewProxy;
import org.appcelerator.titanium.view.TiCompositeLayout;
import org.appcelerator.titanium.view.TiCompositeLayout.LayoutArrangement;
import org.appcelerator.titanium.view.TiUIView;

import android.app.Activity;


// This proxy can be created by calling Gaidwrapper.createExample({message: "hello world"})
@Kroll.proxy(creatableInModule=GaidwrapperModule.class)
public class ExampleProxy extends TiViewProxy
{
	// Standard Debugging variables
	private static final String TAG = "ExampleProxy";

	private class ExampleView extends TiUIView
	{
		public ExampleView(TiViewProxy proxy) {
			super(proxy);
			LayoutArrangement arrangement = LayoutArrangement.DEFAULT;

			if (proxy.hasProperty(TiC.PROPERTY_LAYOUT)) {
				String layoutProperty = TiConvert.toString(proxy.getProperty(TiC.PROPERTY_LAYOUT));
				if (layoutProperty.equals(TiC.LAYOUT_HORIZONTAL)) {
					arrangement = LayoutArrangement.HORIZONTAL;
				} else if (layoutProperty.equals(TiC.LAYOUT_VERTICAL)) {
					arrangement = LayoutArrangement.VERTICAL;
				}
			}
			setNativeView(new TiCompositeLayout(proxy.getActivity(), arrangement));
		}

		@Override
		public void processProperties(KrollDict d)
		{
			super.processProperties(d);
		}
	}

	// Constructor
	public ExampleProxy()
	{
		super();
	}

	@Override
	public TiUIView createView(Activity activity)
	{
		TiUIView view = new ExampleView(this);
		view.getLayoutParams().autoFillsHeight = true;
		view.getLayoutParams().autoFillsWidth = true;
		return view;
	}

	// Handle creation options
	@Override
	public void handleCreationDict(KrollDict options)
	{
		super.handleCreationDict(options);
		
		if (options.containsKey("message")) {
			Log.d(TAG, "example created with message: " + options.get("message"));
		}
	}
	
	// Methods
	@Kroll.method
	public void printMessage(String message)
	{
		Log.d(TAG, "printing message: " + message);
	}


	@Kroll.getProperty @Kroll.method
	public String getMessage()
	{
        return "Hello World from my module";
	}

	@Kroll.setProperty @Kroll.method
	public void setMessage(String message)
	{
	    Log.d(TAG, "Tried setting module message to: " + message);
	}
}