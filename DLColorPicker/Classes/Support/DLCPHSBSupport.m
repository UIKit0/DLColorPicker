//
//  DLCPHSBSupport.m
//  DLColorPicker
//
//  Created by Troy Gaul on 7 Aug 2010.
//  Copyright (c) 2011 DLCPinitApps LLC - http://infinitapps.com
//	Some rights reserved: http://opensource.org/licenses/MIT
//

#import "DLCPHSBSupport.h"

void DLCPHueToComponentFactors(CGFloat h, CGFloat *r, CGFloat *g, CGFloat *b) {
	CGFloat h_prime = h / 60.0;
	CGFloat x = 1.0 - fabsf(fmodf(h_prime, 2.0) - 1.0);
	
	if (h_prime < 1.0) {
		*r = 1;
		*g = x;
		*b = 0;
	} else if (h_prime < 2.0) {
		*r = x;
		*g = 1;
		*b = 0;
	} else if (h_prime < 3.0) {
		*r = 0;
		*g = 1;
		*b = x;
	} else if (h_prime < 4.0) {
		*r = 0;
		*g = x;
		*b = 1;
	} else if (h_prime < 5.0) {
		*r = x;
		*g = 0;
		*b = 1;
	} else {
		*r = 1;
		*g = 0;
		*b = x;
	}
}

void DLConvert_HSV_to_RGB(CGFloat h, CGFloat s, CGFloat v, CGFloat *r, CGFloat *g, CGFloat *b) {
	DLCPHueToComponentFactors(h, r, g, b);
	CGFloat c = v * s;
	CGFloat m = v - c;
	*r = *r * c + m;
	*g = *g * c + m;
	*b = *b * c + m;
}

void DLConvert_RGB_to_HSV(CGFloat r, CGFloat g, CGFloat b, CGFloat *h, CGFloat *s, CGFloat *v, BOOL preserveHS) {
	CGFloat max = CGFLOAT_MIN;
	max = MAX(MAX(max, g), b);
	
	CGFloat min = CGFLOAT_MAX;
	min = MIN(MIN(min, g), b);
	
	// Brightness (aka Value)
	
	*v = max;
	
	// Saturation
	
	CGFloat sat;
	
	if (max != 0.0) {
		sat = (max - min) / max;
		*s = sat;
	} else {
		sat = 0.0;
		
		if (!preserveHS) {
			*s = 0.0; // Black, so sat is undefined, use 0.0
		}
	}
	
	// Hue
	
	CGFloat delta;
	
	if (sat == 0.0) {
		if (!preserveHS) {
			*h = 0.0; // No color, so hue is undefined, use 0.0
		}
	} else {
		delta = max - min;
		
		CGFloat hue;
		
		if (r == max) {
			hue = (g - b) / delta;
		} else if (g == max) {
			hue = 2 + (b - r) / delta;
		} else {
			hue = 4 + (r - g) / delta;
		}
		
		hue /= 6.0;
		
		if (hue < 0.0) {
			hue += 1.0;
		}
		
		if (!preserveHS || (fabsf(hue - *h) != 1.0)) {
			*h = hue; // 0.0 and 1.0 hues are actually both the same (red)
		}
	}
}
