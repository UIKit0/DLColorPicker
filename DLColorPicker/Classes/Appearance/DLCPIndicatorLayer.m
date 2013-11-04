//
//  DLCPIndicatorLayer.m
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Definite Loop. All rights reserved.
//

#import "DLCPIndicatorLayer.h"

@implementation DLCPIndicatorLayer

+ (instancetype)layer {
	DLCPIndicatorLayer *layer = [super layer];
	if (layer) {
		CGFloat size = 40.0;
		layer.position = CGPointMake(0.0, 0.0);
		layer.bounds = CGRectMake(0.0, 0.0, size, size);
		
		layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.75].CGColor;
		layer.borderWidth = 1.5;
		layer.cornerRadius = size / 2;
		
		layer.shadowColor = [UIColor blackColor].CGColor;
		layer.shadowOffset = CGSizeMake(0.0, 1.5);
		layer.shadowOpacity = 0.25;
		layer.shadowRadius = 1.5;
		
		layer.colors = @[(__bridge id)[UIColor colorWithWhite:1.0 alpha:0.3].CGColor,
						 (__bridge id)[UIColor colorWithWhite:1.0 alpha:0.1].CGColor,
						 (__bridge id)[UIColor colorWithWhite:1.0 alpha:0.0].CGColor,
						 (__bridge id)[UIColor colorWithWhite:1.0 alpha:0.1].CGColor];
		layer.locations = @[@0.0, @0.49, @0.5, @1.0];
	}
	return layer;
}

@end
