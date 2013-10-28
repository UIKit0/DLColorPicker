//
//  DLCPRendering.h
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Definite Loop. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DLCPPixelRenderBlock)(CGFloat *red, CGFloat *green, CGFloat *blue, CGFloat *alpha, CGFloat xNormalized, CGFloat yNormalized);

UIImage *DLCPRenderHueImage(CGFloat saturation, CGFloat brightness);
UIImage *DLCPRenderHueImageWithWidth(CGFloat saturation, CGFloat brightness, NSUInteger width);

UIImage *DLCPRenderBrightnessImage(CGFloat hue, CGFloat saturation);
UIImage *DLCPRenderBrightnessImageWithWidth(CGFloat hue, CGFloat saturation, NSUInteger width);

UIImage *DLCPRenderSaturationBrightnessImage(CGFloat hue);
UIImage *DLCPRenderSaturationBrightnessImageWithSize(CGFloat hue, NSUInteger width, NSUInteger height);

UIImage *DLCPRenderHueSaturationImage(CGFloat brightness);
UIImage *DLCPRenderHueSaturationImageWithSize(CGFloat brightness, NSUInteger width, NSUInteger height);

UIImage *DLCPRenderAlphaImageWithWidth(CGFloat checkerDarkBrightness, CGFloat checkerLightBrightness, CGFloat foregroundBrightness, NSUInteger width);
UIImage *DLCPRenderAlphaImageWithSize(CGFloat checkerDarkBrightness, CGFloat checkerLightBrightness, CGFloat foregroundBrightness, NSUInteger width, NSUInteger height);

UIImage *DLCPRenderImageWithSize(NSUInteger width, NSUInteger height, DLCPPixelRenderBlock renderBlock);