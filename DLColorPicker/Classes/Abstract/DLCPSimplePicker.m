//
//  DLCPSimplePicker.m
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Definite Loop. All rights reserved.
//

#import "DLCPSimplePicker.h"

#import "DLCPSimplePicker+Protected.h"

#import "DLCPBackgroundLayer.h"

@interface DLCPSimplePicker ()

@end

@implementation DLCPSimplePicker

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
    if (self) {
        if (![self commonSimplePickerInit]) {
			return nil;
		}
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
	self = [super initWithCoder:decoder];
    if (self) {
        if (![self commonSimplePickerInit]) {
			return nil;
		}
    }
    return self;
}

- (BOOL)commonSimplePickerInit {
	self.backgroundLayer = [DLCPBackgroundLayer layer];
	return YES;
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
	self.backgroundLayer.frame = layer.bounds;
}

- (void)setBackgroundLayer:(CALayer *)backgroundLayer {
	[_backgroundLayer removeFromSuperlayer];
	_backgroundLayer = backgroundLayer;
	[self.layer addSublayer:backgroundLayer];
	[self layoutSublayersOfLayer:self.layer];
}

- (void)setColor:(UIColor *)color {
	_color = color;
	
	CGFloat hsba[4];
	[color getHue:(hsba + 0) saturation:(hsba + 1) brightness:(hsba + 2) alpha:(hsba + 3)];
	self.hue = hsba[0];
	self.saturation = hsba[1];
	self.brightness = hsba[2];
	self.alpha = hsba[3];
	
	[self updateWithColor:color];
}

+ (NSSet *)keyPathsForValuesAffectingColor {
    return [NSSet setWithObjects:@"hue", @"saturation", @"brightness", @"alpha", nil];
}

- (void)setHue:(CGFloat)hue {
	hue = MIN(MAX(hue, 0.0), 1.0);
	_hue = hue;
	[self willChangeValueForKey:NSStringFromSelector(@selector(color))];
	_color = [UIColor colorWithHue:hue saturation:self.saturation brightness:self.brightness alpha:self.alpha];
	[self didChangeValueForKey:NSStringFromSelector(@selector(color))];
	[self updateWithColor:_color];
}

- (void)setSaturation:(CGFloat)saturation {
	saturation = MIN(MAX(saturation, 0.0), 1.0);
	_saturation = saturation;
	[self willChangeValueForKey:NSStringFromSelector(@selector(color))];
	_color = [UIColor colorWithHue:self.hue saturation:saturation brightness:self.brightness alpha:self.alpha];
	[self didChangeValueForKey:NSStringFromSelector(@selector(color))];
	[self updateWithColor:_color];
}

- (void)setBrightness:(CGFloat)brightness {
	brightness = MIN(MAX(brightness, 0.0), 1.0);
	_brightness = brightness;
	[self willChangeValueForKey:NSStringFromSelector(@selector(color))];
	_color = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:brightness alpha:self.alpha];
	[self didChangeValueForKey:NSStringFromSelector(@selector(color))];
	[self updateWithColor:_color];
}

- (void)setAlpha:(CGFloat)alpha {
	alpha = MIN(MAX(alpha, 0.0), 1.0);
	_alpha = alpha;
	[self willChangeValueForKey:NSStringFromSelector(@selector(color))];
	_color = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:self.brightness alpha:alpha];
	[self didChangeValueForKey:NSStringFromSelector(@selector(color))];
	[self updateWithColor:_color];
}

- (void)updateWithColor:(UIColor *)color {
	self.backgroundLayer.backgroundColor = color.CGColor;
}

@end
