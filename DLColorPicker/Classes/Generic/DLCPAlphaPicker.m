//
//  DLCPAlphaPicker.m
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Definite Loop. All rights reserved.
//

#import "DLCPAlphaPicker.h"

#import "DLCPThreeAxisPicker+Protected.h"

#import "DLCPRendering.h"

@interface DLCPAlphaPicker ()

@end

@implementation DLCPAlphaPicker

@dynamic alpha;

- (CGFloat)defaultXValue {
	return 1.0;
}

- (CGFloat)defaultYValue {
	return 0.0;
}

- (CGFloat)defaultZValue {
	return 0.0;
}

- (void)setAlpha:(CGFloat)alpha {
	self.xValue = alpha;
}

- (CGFloat)alpha {
	return self.xValue;
}

+ (NSSet *)keyPathsForValuesAffectingAlpha {
    return [NSSet setWithObjects:@"xValue", nil];
}

- (void)setupWithXValue:(CGFloat)xValue yValue:(CGFloat)yValue zValue:(CGFloat)zValue {
	[super setupWithXValue:xValue yValue:yValue zValue:zValue];
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		UIImage *image = DLCPRenderAlphaImageWithSize(0.2, 0.8, 1.0, self.bounds.size.width, self.bounds.size.height);
		dispatch_async(dispatch_get_main_queue(), ^{
			self.backgroundLayer.contents = (__bridge id)image.CGImage;
		});
	});
}

- (void)respondToXValue:(CGFloat)xValue yValue:(CGFloat)yValue zValue:(CGFloat)zValue {
	[super respondToXValue:xValue yValue:yValue zValue:zValue];
	self.indicatorLayer.backgroundColor = [UIColor colorWithWhite:1.0 alpha:xValue].CGColor;
}

@end
