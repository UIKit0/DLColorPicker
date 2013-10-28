//
//  DLCPPickerController.h
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Definite Loop. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DLCPPickerController;

@protocol DLCPPickerControllerDelegate

- (void)colorPickerController:(DLCPPickerController *)controller didFinishWithColor:(UIColor *)color;

- (void)colorPickerControllerDidCancel:(DLCPPickerController *)controller;

@optional

- (void)colorPickerController:(DLCPPickerController *)controller didChangeColor:(UIColor *)color;

@end

@interface DLCPPickerController : UIViewController

@property (readwrite, strong, nonatomic) UIColor *sourceColor;
@property (readwrite, strong, nonatomic) UIColor *resultColor;

@property (readwrite, weak, nonatomic) id<DLCPPickerControllerDelegate> delegate;

// Calls the delegate's `colorPickerController:didFinishWithColor:` method.
// The delegate is responsible for actually hiding the controller
- (IBAction)finishColorPicker:(id)sender;

// Calls the delegate's `colorPickerControllerDidCancel:` method.
// The delegate is responsible for actually hiding the controller
- (IBAction)cancelColorPicker:(id)sender;

@end
