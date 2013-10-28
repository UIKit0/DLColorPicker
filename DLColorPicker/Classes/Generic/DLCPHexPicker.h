//
//  DLCPHexPicker.h
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Definite Loop. All rights reserved.
//

#import "DLCPSimplePicker.h"

#import "DLCPColorPicker.h"

@interface DLCPHexPicker : DLCPSimplePicker <DLCPColorPicker>

@property (readwrite, strong, nonatomic) NSString *hex;
@property (readwrite, assign, nonatomic, getter = isEditable) BOOL editable;
@property (readwrite, assign, nonatomic, getter = isHexHidden) BOOL hexHidden;

@end
