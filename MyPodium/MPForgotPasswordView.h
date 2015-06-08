//
//  MPForgotPasswordView.h
//  MyPodium
//
//  Created by Connor Neville on 5/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPView.h"

#import <UIKit/UIKit.h>

@class MPLabel;
@class MPTextField;

@interface MPForgotPasswordView : MPView

@property MPLabel* titleLabel;
@property MPTextField* emailField;
@property MPLabel* descriptorLabel;
@property UIButton* resetPasswordButton;
@property UIButton* goBackButton;

@end
