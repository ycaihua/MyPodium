//
//  MPSettingsView.h
//  MyPodium
//
//  Created by Connor Neville on 7/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class MPLabel;
@class MPView;
@class MPTextField;
@class MPPreferencesButton;
@class MPSettingsScrollView;

@interface MPSettingsView : MPMenuView

@property MPSettingsScrollView* preferencesScrollView;
@property MPView* preferencesContentView;

@property MPLabel* realNameTitle;
@property MPTextField* realNameField;
@property MPLabel* realNameLabel;
@property UIButton* submitNameButton;

@property MPLabel* changePasswordTitle;
@property MPLabel* changePasswordLabel;
@property MPTextField* changePasswordField;
@property MPLabel* confirmPasswordLabel;
@property MPTextField* confirmPasswordField;
@property MPLabel* oldPasswordLabel;
@property MPTextField* oldPasswordField;
@property UIButton* submitPasswordButton;

@property MPLabel* friendRequestsTitle;
@property MPLabel* friendRequestsDescription;
@property UIView* friendRequestsView;
@property UIImageView* friendRequestsImage;
@property MPPreferencesButton* friendRequestsButton;

@property MPLabel* confirmationAlertsTitle;
@property MPLabel* confirmationAlertsDescription;
@property UIView* confirmationAlertsView;
@property UIImageView* confirmationAlertsImage;
@property MPPreferencesButton* confirmationAlertsButton;

@end
