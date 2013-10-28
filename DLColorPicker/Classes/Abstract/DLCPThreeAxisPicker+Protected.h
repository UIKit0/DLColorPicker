//
//  DLCPThreeAxisPicker+Protected.h
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Definite Loop. All rights reserved.
//

#import "DLCPThreeAxisPicker.h"

#import "DLCPIndicatorLayer.h"
#import "DLCPBackgroundLayer.h"

@interface DLCPThreeAxisPicker ()

@property (readwrite, assign, nonatomic) CGFloat xValue;
@property (readwrite, assign, nonatomic) CGFloat minXValue;
@property (readwrite, assign, nonatomic) CGFloat maxXValue;

@property (readwrite, assign, nonatomic) CGFloat yValue;
@property (readwrite, assign, nonatomic) CGFloat minYValue;
@property (readwrite, assign, nonatomic) CGFloat maxYValue;

@property (readwrite, assign, nonatomic) CGFloat zValue;
@property (readwrite, assign, nonatomic) CGFloat minZValue;
@property (readwrite, assign, nonatomic) CGFloat maxZValue;

- (void)setXValue:(CGFloat)xValue silent:(BOOL)silent;
- (void)setYValue:(CGFloat)yValue silent:(BOOL)silent;
- (void)setZValue:(CGFloat)zValue silent:(BOOL)silent;

- (CGFloat)defaultXValue;
- (CGFloat)defaultYValue;
- (CGFloat)defaultZValue;

- (CGPoint)indicatorLayerPositionForXValue:(CGFloat)xValue yValue:(CGFloat)yValue zValue:(CGFloat)zValue;
- (void)getXValue:(CGFloat *)xValue yValue:(CGFloat *)yValue fromLocation:(CGPoint)location;

- (void)setupWithXValue:(CGFloat)xValue yValue:(CGFloat)yValue zValue:(CGFloat)zValue;
- (void)respondToXValue:(CGFloat)xValue yValue:(CGFloat)yValue zValue:(CGFloat)zValue;

@end
