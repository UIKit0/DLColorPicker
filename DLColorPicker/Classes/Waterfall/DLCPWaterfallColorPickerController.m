//
//  DLCPWaterfallColorPickerController.m
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Definite Loop. All rights reserved.
//

#import "DLCPWaterfallColorPickerController.h"
#import "DLCPWaterfallColorPickerController+Protected.h"

@implementation DLCPWaterfallColorPickerController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.beforePicker.editable = NO;
	
	self.beforePicker.color = self.sourceColor;
	UIColor *resultColor = self.resultColor;
	self.afterPicker.color = resultColor;
	CGFloat brightness, alpha;
	[self.sourceColor getHue:NULL saturation:NULL brightness:&brightness alpha:&alpha];
	self.brightnessPicker.brightness = brightness;
	self.alphaPicker.alpha = alpha;
	
	[self.beforePicker addTarget:self action:@selector(resetResultColor:) forControlEvents:UIControlEventTouchUpInside];
	[self.afterPicker addTarget:self action:@selector(afterPickerColorDidChange:) forControlEvents:UIControlEventValueChanged];
	[self.brightnessPicker addTarget:self action:@selector(brightnessPickerColorDidChange:) forControlEvents:UIControlEventValueChanged];
	[self.alphaPicker addTarget:self action:@selector(alphaPickerColorDidChange:) forControlEvents:UIControlEventValueChanged];
	[self.hueSaturationPicker addTarget:self action:@selector(hueSaturationPickerColorDidChange:) forControlEvents:UIControlEventValueChanged];
}

- (IBAction)resetResultColor:(DLCPHexPicker *)sender {
	self.resultColor = self.sourceColor;
}

- (IBAction)afterPickerColorDidChange:(DLCPHexPicker *)sender {
	[self changeValuesOfResultColorInformingDelegate:^{
		self.brightness = sender.brightness;
		self.hue = sender.hue;
		self.saturation = sender.saturation;
		self.alpha = sender.alpha;
	}];
}

- (IBAction)brightnessPickerColorDidChange:(DLCPBrightnessPicker *)sender {
	[self changeValuesOfResultColorInformingDelegate:^{
		self.brightness = sender.brightness;
	}];
}

- (IBAction)hueSaturationPickerColorDidChange:(DLCPHueSaturationPicker *)sender {
	[self changeValuesOfResultColorInformingDelegate:^{
		self.hue = sender.hue;
		self.saturation = sender.saturation;
	}];
}

- (IBAction)alphaPickerColorDidChange:(DLCPAlphaPicker *)sender {
	[self changeValuesOfResultColorInformingDelegate:^{
		self.alpha = sender.alpha;
	}];
}

- (void)setHue:(CGFloat)hue {
	[super setHue:hue];
	
	self.hueSaturationPicker.hue = hue;
	self.afterPicker.hue = hue;
}

- (void)setSaturation:(CGFloat)saturation {
	[super setSaturation:saturation];
	
	self.hueSaturationPicker.saturation = saturation;
	self.afterPicker.saturation = saturation;
}

- (void)setBrightness:(CGFloat)brightness {
	[super setBrightness:brightness];
	
	self.hueSaturationPicker.brightness = brightness;
	self.afterPicker.brightness = brightness;
	self.brightnessPicker.brightness = brightness;
}

- (void)setAlpha:(CGFloat)alpha {
	[super setAlpha:alpha];
	
	self.alphaPicker.alpha = alpha;
}

- (void)setSourceColor:(UIColor *)sourceColor {
	[super setSourceColor:sourceColor];
	
	self.beforePicker.color = sourceColor;
}

@end
