//
//  DLCPPickerController.m
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Definite Loop. All rights reserved.
//

#import "DLCPPickerController.h"

#import "DLCPPickerController+Protected.h"

@interface DLCPPickerController() <UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (readwrite, strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation DLCPPickerController

@dynamic resultColor;

#pragma mark - Class methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if (![self commonPickerControllerInit]) {
			return nil;
		}
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        if (![self commonPickerControllerInit]) {
			return nil;
		}
    }
    return self;
}

- (BOOL)commonPickerControllerInit {
	_tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapBackgroundView:)];
	[_tapGestureRecognizer setNumberOfTapsRequired:1];
	_tapGestureRecognizer.delegate = self;
	
	_backgroundTapBehaviour = DLCPPickerControllerBackgroundTapBehaviourFinish;
	
	UIColor *defaultColor = [[self class] defaultColor];
	_sourceColor = defaultColor;
	
	CGFloat hsba[4];
	[defaultColor getHue:(hsba + 0) saturation:(hsba + 1) brightness:(hsba + 2) alpha:(hsba + 3)];
	self.hue = hsba[0];
	self.saturation = hsba[1];
	self.brightness = hsba[2];
	self.alpha = hsba[3];
	
	return YES;
}

+ (UIColor *)defaultColor {
	return [UIColor redColor];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.view.userInteractionEnabled = YES;
	self.view.multipleTouchEnabled = NO;
	[self.view addGestureRecognizer:self.tapGestureRecognizer];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
	return touch.view == self.view;
}

- (void)didTapBackgroundView:(UITapGestureRecognizer *)tapGestureRecognizer {
	DLCPPickerControllerBackgroundTapBehaviour behaviour = self.backgroundTapBehaviour;
	switch (behaviour) {
		case DLCPPickerControllerBackgroundTapBehaviourCancel: {
			[self.delegate colorPickerControllerDidCancel:self];
			break;
		}
		case DLCPPickerControllerBackgroundTapBehaviourFinish: {
			[self.delegate colorPickerController:self didFinishWithColor:self.resultColor];
			break;
		}
		case DLCPPickerControllerBackgroundTapBehaviourIgnore:
		default: {
			break;
		}
	}
}

- (IBAction)finishColorPicker:(id)sender {
    [self.delegate colorPickerController:self didFinishWithColor:self.resultColor];
}

- (IBAction)cancelColorPicker:(id)sender {
	[self.delegate colorPickerControllerDidCancel:self];
}

- (void)informDelegateDidChangeColor {
	if (self.delegate && [(id)self.delegate respondsToSelector:@selector(colorPickerController:didChangeColor:)]) {
		[self.delegate colorPickerController:self didChangeColor:self.resultColor];
	}
}

- (void)setSourceColor:(UIColor *)sourceColor {
	_sourceColor = sourceColor;
	self.resultColor = sourceColor;
}

- (void)setResultColor:(UIColor *)resultColor {
	CGFloat hsba[4];
	[resultColor getHue:(hsba + 0) saturation:(hsba + 1) brightness:(hsba + 2) alpha:(hsba + 3)];
	
	self.hue = hsba[0];
	self.saturation = hsba[1];
	self.brightness = hsba[2];
	self.alpha = hsba[3];
	
	[self informDelegateDidChangeColor];
}

- (UIColor *)resultColor {
	return [UIColor colorWithHue:self.hue saturation:self.saturation brightness:self.brightness alpha:self.alpha];
}

- (void)changeValuesOfResultColorInformingDelegate:(void(^)(void))block {
	NSAssert(block, @"Method argument 'block' must not be nil.");
	[self willChangeValueForKey:NSStringFromSelector(@selector(resultColor))];
	block();
	[self didChangeValueForKey:NSStringFromSelector(@selector(resultColor))];
	[self informDelegateDidChangeColor];
}

@end
