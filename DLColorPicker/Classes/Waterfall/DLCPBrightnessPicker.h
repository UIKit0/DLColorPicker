//
//  DLCPBrightnessPicker.h
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Definite Loop. All rights reserved.
//

#import "DLCPLinearPicker.h"

#import "DLCPColorPicker.h"

@interface DLCPBrightnessPicker : DLCPLinearPicker <DLCPColorPicker>

@property (readwrite, strong, nonatomic) UIColor *color;

@property (readwrite, assign, nonatomic) CGFloat hue;
@property (readwrite, assign, nonatomic) CGFloat saturation;
@property (readwrite, assign, nonatomic) CGFloat brightness;
@property (readwrite, assign, nonatomic) CGFloat alpha;

@end
