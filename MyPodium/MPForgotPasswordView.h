//
//  MPForgotPasswordView.h
//  MyPodium
//
//  Created by Connor Neville on 5/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPView.h"
@class MPLabel;
@class MPTextField;

@interface MPForgotPasswordView : MPView

@property MPLabel* titleLabel;
@property MPTextField* emailField;
@property MPLabel* descriptorLabel;
@property UIButton* resetPasswordButton;
@property UIButton* goBackButton;

@end
