//
//  DLCPBrightnessPicker.m
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Definite Loop. All rights reserved.
//

#import "DLCPBrightnessPicker.h"

#import "DLCPThreeAxisPicker+Protected.h"

#import "DLCPRendering.h"

@interface DLCPBrightnessPicker ()

@end

@implementation DLCPBrightnessPicker

@dynamic hue, saturation, brightness;

- (CGFloat)defaultXValue {
	return 0.0;
}

- (CGFloat)defaultYValue {
	return 1.0;
}

- (CGFloat)defaultZValue {
	return 0.0;
}

- (void)setColor:(UIColor *)color {
	CGFloat hsba[4];
	[color getHue:(hsba + 0) saturation:(hsba + 1) brightness:(hsba + 2) alpha:(hsba + 3)];
	self.hue = hsba[0];
	self.saturation = hsba[1];
	self.brightness = hsba[2];
	self.alpha = hsba[3];
}

- (UIColor *)color {
	return [UIColor colorWithHue:self.hue saturation:self.saturation brightness:self.brightness alpha:self.alpha];
}

+ (NSSet *)keyPathsForValuesAffectingColor {
    return [NSSet setWithObjects:@"hue", @"saturation", @"brightness", @"alpha", nil];
}

- (void)setHue:(CGFloat)hue {
	self.yValue = hue;
}

- (CGFloat)hue {
	return self.yValue;
}

+ (NSSet *)keyPathsForValuesAffectingHue {
    return [NSSet setWithObjects:@"yValue", @"color", nil];
}

- (void)setSaturation:(CGFloat)saturation {
	self.zValue = saturation;
}

- (CGFloat)saturation {
	return self.zValue;
}

+ (NSSet *)keyPathsForValuesAffectingSaturation {
    return [NSSet setWithObjects:@"zValue", @"color", nil];
}

- (void)setBrightness:(CGFloat)brightness {
	self.xValue = brightness;
}

- (CGFloat)brightness {
	return self.xValue;
}

+ (NSSet *)keyPathsForValuesAffectingBrightness {
    return [NSSet setWithObjects:@"xValue", @"color", nil];
}

- (void)setupWithXValue:(CGFloat)xValue yValue:(CGFloat)yValue zValue:(CGFloat)zValue {
	[super setupWithXValue:xValue yValue:yValue zValue:zValue];
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		UIImage *image = DLCPRenderBrightnessImageWithWidth(yValue, zValue, 32);
		dispatch_async(dispatch_get_main_queue(), ^{
			self.backgroundLayer.contents = (__bridge id)image.CGImage;
		});
	});
}

- (void)respondToXValue:(CGFloat)xValue yValue:(CGFloat)yValue zValue:(CGFloat)zValue {
	[super respondToXValue:xValue yValue:yValue zValue:zValue];
	self.indicatorLayer.backgroundColor = [UIColor colorWithHue:yValue saturation:zValue brightness:xValue alpha:1.0].CGColor;
	if (yValue != self.yValue || zValue != self.zValue) {
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
			UIImage *image = DLCPRenderBrightnessImageWithWidth(yValue, zValue, 32);
			dispatch_async(dispatch_get_main_queue(), ^{
				self.backgroundLayer.contents = (__bridge id)image.CGImage;
			});
		});
	}
}

@end
