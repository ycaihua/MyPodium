//
//  MPSettingsView.h
//  MyPodium
//
//  Created by Connor Neville on 7/1/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class MPTextField;
@class MPLabel;

@interface MPSettingsView : MPMenuView

@property MPTextField* realNameField;
@property MPLabel* realNameLabel;
@property UIButton* submitNameButton;
@property MPTextField* changePasswordField;
@property MPLabel* changePasswordLabel;
@property MPTextField* confirmPasswordField;
@property MPLabel* confirmPasswordLabel;
@property MPTextField* oldPasswordField;
@property MPLabel* oldPasswordLabel;
@property UIButton* submitPasswordButton;

- (void) shiftVerticalConstraintsBy: (CGFloat) amount;
- (void) restoreDefaultConstraints;

@end
