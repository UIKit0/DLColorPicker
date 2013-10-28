//
//  DLCPThreeAxisPicker.m
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Definite Loop. All rights reserved.
//

#import "DLCPThreeAxisPicker.h"
#import "DLCPThreeAxisPicker+Protected.h"

@implementation DLCPThreeAxisPicker

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
    if (self) {
        if (![self commonThreeAxisPickerInit]) {
			return nil;
		}
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
	self = [super initWithCoder:decoder];
    if (self) {
        if (![self commonThreeAxisPickerInit]) {
			return nil;
		}
    }
    return self;
}

- (BOOL)commonThreeAxisPickerInit {
	self.minXValue = 0.0;
	self.maxXValue = 1.0;
	[self setXValue:[self defaultXValue] silent:YES];
	
	self.minYValue = 0.0;
	self.maxYValue = 1.0;
	[self setYValue:[self defaultYValue] silent:YES];
	
	self.minZValue = 0.0;
	self.maxZValue = 1.0;
	[self setZValue:[self defaultZValue] silent:YES];
	
	self.backgroundLayer = [DLCPBackgroundLayer layer];
	self.indicatorLayer = [DLCPIndicatorLayer layer];
	
	[self setupWithXValue:self.xValue yValue:self.yValue zValue:self.zValue];
	
	return YES;
}

- (CGFloat)defaultXValue {
	return 0.0;
}

- (CGFloat)defaultYValue {
	return 0.0;
}

- (CGFloat)defaultZValue {
	return 0.0;
}

- (void)setXValue:(CGFloat)xValue {
	[self setXValue:xValue silent:NO];
}

- (void)setXValue:(CGFloat)xValue silent:(BOOL)silent {
	xValue = MIN(MAX(xValue, self.minXValue), self.maxXValue);
	_xValue = xValue;
	if (!silent) {
		[self respondToXValue:xValue yValue:self.yValue zValue:self.zValue];
	}
}

- (void)setMinXValue:(CGFloat)minXValue {
	_minXValue = minXValue;
	if (self.xValue < minXValue) {
		self.xValue = minXValue;
	}
	if (self.maxXValue < minXValue) {
		self.maxXValue = minXValue;
	}
}

- (void)setMaxXValue:(CGFloat)maxXValue {
	_maxXValue = maxXValue;
	if (self.xValue > maxXValue) {
		self.xValue = maxXValue;
	}
	if (self.minXValue > maxXValue) {
		self.minXValue = maxXValue;
	}
}

- (void)setYValue:(CGFloat)yValue {
	[self setYValue:yValue silent:NO];
}

- (void)setYValue:(CGFloat)yValue silent:(BOOL)silent {
	yValue = MIN(MAX(yValue, self.minYValue), self.maxYValue);
	_yValue = yValue;
	if (!silent) {
		[self respondToXValue:self.xValue yValue:yValue zValue:self.zValue];
	}
}

- (void)setMinYValue:(CGFloat)minYValue {
	_minYValue = minYValue;
	if (self.yValue < minYValue) {
		self.yValue = minYValue;
	}
	if (self.maxYValue < minYValue) {
		self.maxYValue = minYValue;
	}
}

- (void)setMaxYValue:(CGFloat)maxYValue {
	_maxYValue = maxYValue;
	if (self.yValue > maxYValue) {
		self.yValue = maxYValue;
	}
	if (self.minYValue > maxYValue) {
		self.minYValue = maxYValue;
	}
}

- (void)setZValue:(CGFloat)zValue {
	[self setZValue:zValue silent:NO];
}

- (void)setZValue:(CGFloat)zValue silent:(BOOL)silent {
	zValue = MIN(MAX(zValue, self.minZValue), self.maxZValue);
	_zValue = zValue;
	if (!silent) {
		[self respondToXValue:self.xValue yValue:self.yValue zValue:zValue];
	}
}

- (void)setMinZValue:(CGFloat)minZValue {
	_minZValue = minZValue;
	if (self.zValue < minZValue) {
		self.zValue = minZValue;
	}
	if (self.maxZValue < minZValue) {
		self.maxZValue = minZValue;
	}
}

- (void)setMaxZValue:(CGFloat)maxZValue {
	_maxZValue = maxZValue;
	if (self.zValue > maxZValue) {
		self.zValue = maxZValue;
	}
	if (self.minZValue > maxZValue) {
		self.minZValue = maxZValue;
	}
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
	self.backgroundLayer.frame = layer.bounds;
	[self respondToXValue:self.xValue yValue:self.yValue zValue:self.zValue];
}

- (void)setBackgroundLayer:(CALayer *)backgroundLayer {
	[_backgroundLayer removeFromSuperlayer];
	_backgroundLayer = backgroundLayer;
	[self.layer addSublayer:backgroundLayer];
	[self layoutSublayersOfLayer:self.layer];
}

- (void)setIndicatorLayer:(CALayer *)indicatorLayer {
	[_indicatorLayer removeFromSuperlayer];
	_indicatorLayer = indicatorLayer;
	[self.layer addSublayer:indicatorLayer];
	[self layoutSublayersOfLayer:self.layer];
}

- (CGPoint)indicatorLayerPositionForXValue:(CGFloat)xValue yValue:(CGFloat)yValue zValue:(CGFloat)zValue {
	CGFloat normalizedXValue = [self normalizeValue:self.xValue withMin:self.minXValue max:self.maxXValue];
	CGFloat normalizedYValue = [self normalizeValue:self.yValue withMin:self.minYValue max:self.maxYValue];
	
	CGRect rect = self.layer.bounds;
	
	CGFloat x = normalizedXValue * rect.size.width;
	CGFloat y = normalizedYValue * rect.size.height;
	
	CGSize indicatorSize = self.indicatorLayer.bounds.size;
	
	x = MAX(x, CGRectGetMinX(rect) + indicatorSize.width / 2);
	x = MIN(x, CGRectGetMaxX(rect) - indicatorSize.width / 2);
	y = MAX(y, CGRectGetMinY(rect) + indicatorSize.height / 2);
	y = MIN(y, CGRectGetMaxY(rect) - indicatorSize.height / 2);
	
	return CGPointMake(x, y);
}

- (void)getXValue:(CGFloat *)xValue yValue:(CGFloat *)yValue fromLocation:(CGPoint)location {
	NSAssert(xValue || yValue, @"Method arguments 'xValues' & 'yValues' must not both be NULL");
	CGSize indicatorLayerSize = CGSizeZero; // self.indicatorLayer.bounds.size;
	if (xValue) {
		CGFloat normalizedXValue = (location.x - indicatorLayerSize.width) / (self.bounds.size.width - 2 * indicatorLayerSize.width);
		*xValue = [self denormalizeValue:normalizedXValue withMin:self.minXValue max:self.maxXValue];
	}
	if (yValue) {
		CGFloat normalizedYValue = (location.y - indicatorLayerSize.height) / (self.bounds.size.height - 2 * indicatorLayerSize.height);
		*yValue = [self denormalizeValue:normalizedYValue withMin:self.minYValue max:self.maxYValue];
	}
}

- (CGFloat)normalizeValue:(CGFloat)denormalizedValue withMin:(CGFloat)minValue max:(CGFloat)maxValue {
	return (denormalizedValue - minValue) / (maxValue - minValue);
}

- (CGFloat)denormalizeValue:(CGFloat)normalizedValue withMin:(CGFloat)minValue max:(CGFloat)maxValue {
	return minValue + (normalizedValue * (maxValue - minValue));
}

- (void)trackIndicatorWithTouch:(UITouch *)touch {
	CGFloat xValue, yValue;
	[self getXValue:&xValue yValue:&yValue fromLocation:[touch locationInView:self]];
	[self setXValue:xValue silent:YES];
	[self setYValue:yValue silent:YES];
	
	[self respondToXValue:xValue yValue:yValue zValue:self.zValue];
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
	[self trackIndicatorWithTouch:touch];
	return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
	[CATransaction begin];
    [CATransaction setAnimationDuration:0.0];
	[self trackIndicatorWithTouch:touch];
	[CATransaction commit];
	return YES;
}

- (void)setupWithXValue:(CGFloat)xValue yValue:(CGFloat)yValue zValue:(CGFloat)zValue {
	self.indicatorLayer.position = [self indicatorLayerPositionForXValue:xValue yValue:self.yValue zValue:self.zValue];
}

- (void)respondToXValue:(CGFloat)xValue yValue:(CGFloat)yValue zValue:(CGFloat)zValue {
	CGPoint position = [self indicatorLayerPositionForXValue:self.xValue yValue:self.yValue zValue:self.zValue];
	self.indicatorLayer.position = position;
}

@end
