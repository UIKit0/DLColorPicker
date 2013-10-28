//
//  DLCPHexPicker.m
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Definite Loop. All rights reserved.
//

#import "DLCPHexPicker.h"

#import "DLCPSimplePicker+Protected.h"

@interface DLCPSimplePicker ()

- (void)updateWithColor:(UIColor *)color;

@end

@interface DLCPHexPicker () <UITextFieldDelegate>

@property (readwrite, strong, nonatomic) UITextField *textField;

@end

@implementation DLCPHexPicker

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
    if (self) {
        if (![self commonHexPickerInit]) {
			return nil;
		}
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
	self = [super initWithCoder:decoder];
    if (self) {
        if (![self commonHexPickerInit]) {
			return nil;
		}
    }
    return self;
}

- (BOOL)commonHexPickerInit {
	self.textField = [[UITextField alloc] initWithFrame:[self textFieldFrame]];
	self.textField.adjustsFontSizeToFitWidth = YES;
	self.textField.font = [self.textField.font fontWithSize:100];
	[self addSubview:self.textField];
	
	self.editable = YES;
	self.hexHidden = NO;
	
	self.textField.textAlignment = NSTextAlignmentCenter;
	self.textField.delegate = self;
	return YES;
}

- (void)layoutSubviews {
	self.textField.frame = [self textFieldFrame];
}

- (CGRect)textFieldFrame {
	CGRect bounds = self.bounds;
	return CGRectInset(bounds, bounds.size.width * 0.1, bounds.size.height * 0.25);
}

- (NSString *)hex {
	return [[self class] hexStringFromColor:self.color];
}

+ (NSSet *)keyPathsForValuesAffectingHex {
    return [NSSet setWithObjects:@"color", nil];
}

- (UIColor *)textColorForColor:(UIColor *)color {
	CGFloat saturation;
	CGFloat brightness;
	[color getHue:NULL saturation:&saturation brightness:&brightness alpha:NULL];
	if (saturation < 0.5 && brightness > 0.5) {
		brightness = 0.0; // bright, low-saturated colors get black
	} else {
		brightness = 1.0; // all others white
	}
	return [UIColor colorWithWhite:brightness alpha:1.0];
}

- (void)updateWithColor:(UIColor *)color {
	[super updateWithColor:color];
	self.textField.textColor = [self textColorForColor:color];
	NSString *hexString = (color) ? [[self class] hexStringFromColor:color] : nil;
	self.textField.text = hexString;
}

+ (UIColor *)colorFromHexString:(NSString *)hexString {
	NSAssert(hexString, @"Method argument 'hexString' must not be nil");
	
    hexString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
	NSUInteger length = [hexString length];
    if (length < 6 || length > 7) {
		return nil;
	}
	
	NSUInteger offset = ([hexString hasPrefix:@"#"]) ? 1 : 0;
	
 	unsigned int rgb[3];
	for (NSUInteger i = 0; i < 3; i++) {
		NSString *string = [hexString substringWithRange:NSMakeRange(i * 2 + offset, 2)];
		NSScanner *scanner = [NSScanner scannerWithString:string];
		if (![scanner scanHexInt:(rgb + i)]) {
			return nil;
		}
	}
    
    return [UIColor colorWithRed:((CGFloat)rgb[0] / 255) green:((CGFloat)rgb[1] / 255) blue:((CGFloat)rgb[2] / 255) alpha:1.0];
}

+ (NSString *)hexStringFromColor:(UIColor *)color {
	NSAssert(color, @"Method argument 'color' must not be nil");
    CGFloat rgba[4];
	[color getRed:(rgba + 0) green:(rgba + 1) blue:(rgba + 2) alpha:(rgba + 3)];
	return [NSString stringWithFormat:@"#%02X%02X%02X", (unsigned char)(rgba[0] * 255), (unsigned char)(rgba[1] * 255), (unsigned char)(rgba[2] * 255)];
}

- (void)setEditable:(BOOL)editable {
	_editable = editable;
	[self.textField resignFirstResponder];
}

- (void)setHexHidden:(BOOL)hexHidden {
	_hexHidden = hexHidden;
	self.textField.hidden = hexHidden;
}

#pragma mark - UITextFieldDelegate Protocol

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	if (!self.editable) {
		[self sendActionsForControlEvents:UIControlEventTouchUpInside];
	}
	return self.editable;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	UIColor *color = [[self class] colorFromHexString:textField.text];
	self.color = color;
	[self updateWithColor:color];
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if ([[self class] colorFromHexString:textField.text]) {
		[textField resignFirstResponder];
		return YES;
	}
    return NO;
}

@end
