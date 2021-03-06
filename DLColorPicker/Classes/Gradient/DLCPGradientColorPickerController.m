//
//  DLCPGradientColorPickerController.m
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Definite Loop. All rights reserved.
//

#import "DLCPGradientColorPickerController.h"
#import "DLCPGradientColorPickerController+Protected.h"

@implementation DLCPGradientColorPickerController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.beforePicker.editable = NO;
	
	self.beforePicker.color = self.sourceColor;
	UIColor *resultColor = self.resultColor;
	self.afterPicker.color = resultColor;
	self.saturationBrightnessPicker.color = resultColor;
	CGFloat hue, alpha;
	[resultColor getHue:&hue saturation:NULL brightness:NULL alpha:&alpha];
	self.huePicker.hue = hue;
	self.alphaPicker.alpha = alpha;
	
	[self.beforePicker addTarget:self action:@selector(resetResultColor:) forControlEvents:UIControlEventTouchUpInside];
	[self.afterPicker addTarget:self action:@selector(afterPickerColorDidChange:) forControlEvents:UIControlEventValueChanged];
	[self.huePicker addTarget:self action:@selector(huePickerColorDidChange:) forControlEvents:UIControlEventValueChanged];
	[self.alphaPicker addTarget:self action:@selector(alphaPickerColorDidChange:) forControlEvents:UIControlEventValueChanged];
	[self.saturationBrightnessPicker addTarget:self action:@selector(saturationBrightnessPickerColorDidChange:) forControlEvents:UIControlEventValueChanged];
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

- (IBAction)huePickerColorDidChange:(DLCPHuePicker *)sender {
	[self changeValuesOfResultColorInformingDelegate:^{
		self.hue = sender.hue;
	}];
}

- (IBAction)alphaPickerColorDidChange:(DLCPAlphaPicker *)sender {
	[self changeValuesOfResultColorInformingDelegate:^{
		self.alpha = sender.alpha;
	}];
}

- (IBAction)saturationBrightnessPickerColorDidChange:(DLCPSaturationBrightnessPicker *)sender {
	[self changeValuesOfResultColorInformingDelegate:^{
		self.saturation = sender.saturation;
		self.brightness = sender.brightness;
	}];
}

- (void)setHue:(CGFloat)hue {
	[super setHue:hue];
	
	self.saturationBrightnessPicker.hue = hue;
	self.afterPicker.hue = hue;
	self.huePicker.hue = hue;
}

- (void)setSaturation:(CGFloat)saturation {
	[super setSaturation:saturation];
	
	self.saturationBrightnessPicker.saturation = saturation;
	self.afterPicker.saturation = saturation;
}

- (void)setBrightness:(CGFloat)brightness {
	[super setBrightness:brightness];
	
	self.saturationBrightnessPicker.brightness = brightness;
	self.afterPicker.brightness = brightness;
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
