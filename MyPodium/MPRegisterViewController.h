//
//  MPRegisterViewController.h
//  MyPodium
//
//  Created by Connor Neville on 5/14/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPRegisterUsernameView;
@class MPRegisterPasswordView;
@class MPRegisterEmailView;
@class MPRegisterDisplayNameView;

@interface MPRegisterViewController : UIViewController <UITextFieldDelegate>

@property MPRegisterUsernameView* usernameView;
@property MPRegisterPasswordView* passwordView;
@property MPRegisterEmailView* emailView;
@property MPRegisterDisplayNameView* nameView;

@end
