//
//  MPRegisterView.h
//  MyPodium
//
//  Created by Connor Neville on 5/15/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPView.h"

#import <UIKit/UIKit.h>

@class MPLabel;
@class MPTextField;

@interface MPRegisterView : MPView

@property MPLabel* titleLabel;
@property MPTextField* usernameField;
@property MPLabel* usernameLabel;
@property MPTextField* passwordField;
@property MPLabel* passwordLabel;
@property MPTextField* emailField;
@property MPLabel* emailLabel;
@property UIButton* registerButton;
@property MPLabel* descriptorLabel;
@property UIButton* goBackButton;

@end
