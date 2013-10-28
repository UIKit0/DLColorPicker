//
//  DLCPHSBSupport.h
//  DLColorPicker
//
//  Created by Troy Gaul on 7 Aug 2010.
//  Copyright (c) 2011 DLCPinitApps LLC - http://infinitapps.com
//	Some rights reserved: http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>

//These functions convert between an RGB value with components in the
//0.0..1.0 range to HSV where Hue is 0..360 and Saturation and 
//Value (aka Brightness) are percentages expressed as 0.0..1.0.
//
//Note that HSB (B = Brightness) and HSV (V = Value) are interchangeable
//names that mean the same thing. I use V here as it is unambiguous
//relative to the B in RGB, which is Blue.

void DLConvert_HSV_to_RGB(CGFloat h, CGFloat s, CGFloat v, CGFloat *r, CGFloat *g, CGFloat *b);

void DLConvert_RGB_to_HSV(CGFloat r, CGFloat g, CGFloat b, CGFloat *h, CGFloat *s, CGFloat *v, BOOL preserveHS);

void DLCPHueToComponentFactors(CGFloat h, CGFloat *r, CGFloat *g, CGFloat *b);
