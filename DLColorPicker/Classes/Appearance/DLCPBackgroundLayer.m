//
//  DLCPBackgroundLayer.m
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Definite Loop. All rights reserved.
//

#import "DLCPBackgroundLayer.h"

@implementation DLCPBackgroundLayer

+ (instancetype)layer {
	DLCPBackgroundLayer *layer = [super layer];
	
	layer.borderColor = [UIColor whiteColor].CGColor;
	layer.borderWidth = 2.0;

	layer.shadowColor = [UIColor blackColor].CGColor;
	layer.shadowOffset = CGSizeMake(0.0, 1.0);
	layer.shadowOpacity = 0.25;
	layer.shadowRadius = 1.0;
	
	return layer;
}

@end
