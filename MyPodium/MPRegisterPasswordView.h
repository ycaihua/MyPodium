//
//  MPRegisterPasswordView.h
//  MyPodium
//
//  Created by Connor Neville on 8/6/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPView.h"

@class MPLabel;
@class MPTextField;

@interface MPRegisterPasswordView : MPView

@property MPLabel* titleLabel;
@property MPLabel* passwordLabel;
@property MPTextField* passwordField;
@property MPLabel* confirmLabel;
@property MPTextField* confirmPasswordField;

- (void) adjustForKeyboardShowing: (BOOL) keyboardShowing;

@end