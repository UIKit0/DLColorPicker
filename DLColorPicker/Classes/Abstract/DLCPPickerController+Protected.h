//
//  DLCPPickerController+Protected.h
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Definite Loop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLCPPickerController ()

@property (readwrite, assign, nonatomic) CGFloat hue;
@property (readwrite, assign, nonatomic) CGFloat saturation;
@property (readwrite, assign, nonatomic) CGFloat brightness;
@property (readwrite, assign, nonatomic) CGFloat alpha;

- (void)changeValuesOfResultColorInformingDelegate:(void(^)(void))block;

@end
