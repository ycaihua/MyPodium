//
//  MPLoginView.h
//  MyPodium
//
//  View for the login screen.
//
//  Created by Connor Neville on 5/14/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPView.h"
@class MPLabel;

@interface MPLoginView : MPView

@property UIButton* logoButton;
@property MPLabel* logoTapLabel;
@property UITextField* usernameField;
@property UITextField* passwordField;
@property UIButton* loginButton;
@property UIButton* forgotPasswordButton;
@property MPLabel* registerLabel;
@property UIButton* registerButton;

- (void) animateLogoMovement;
- (void) revertAnimation;

@end
