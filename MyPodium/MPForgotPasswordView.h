//
//  MPForgotPasswordView.h
//  MyPodium
//
//  Created by Connor Neville on 5/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPView.h"
#import "CNLabel.h"
#import "MPTextField.h"

@interface MPForgotPasswordView : MPView

@property CNLabel* titleLabel;
@property MPTextField* emailField;

@end
