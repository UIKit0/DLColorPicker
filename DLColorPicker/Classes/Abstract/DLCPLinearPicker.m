//
//  DLCPLinearPicker.m
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Definite Loop. All rights reserved.
//

#import "DLCPLinearPicker.h"

#import "DLCPThreeAxisPicker+Protected.h"

@interface DLCPLinearPicker ()

@end

@implementation DLCPLinearPicker

- (CGPoint)indicatorLayerPositionForXValue:(CGFloat)xValue yValue:(CGFloat)yValue zValue:(CGFloat)zValue {
	CGPoint indicatorLayerPosition = [super indicatorLayerPositionForXValue:xValue yValue:yValue zValue:zValue];
	indicatorLayerPosition.y = CGRectGetMidY(self.bounds);
	return indicatorLayerPosition;
}

- (void)getXValue:(CGFloat *)xValue yValue:(CGFloat *)yValue fromLocation:(CGPoint)location {
	[super getXValue:xValue yValue:NULL fromLocation:location];
	if (yValue) {
		*yValue = self.yValue;
	}
}

@end
