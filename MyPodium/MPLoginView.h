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

@interface MPLoginView : MPView

@property UIImageView* logoView;
@property UITextField* usernameField;
@property UITextField* passwordField;
@property UIButton* loginButton;
@property UIButton* forgotPasswordButton;

@end
