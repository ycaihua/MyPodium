//
//  MPRegisterView.h
//  MyPodium
//
//  Created by Connor Neville on 5/15/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPView.h"
#import "CNLabel.h"
#import "MPTextField.h"

@interface MPRegisterView : MPView

@property CNLabel* titleLabel;
@property MPTextField* usernameField;
@property CNLabel* usernameLabel;
@property MPTextField* passwordField;
@property CNLabel* passwordLabel;
@property MPTextField* emailField;
@property CNLabel* emailLabel;
@property UIButton* registerButton;
@property CNLabel* descriptorLabel;
@property UIButton* goBackButton;

@end
