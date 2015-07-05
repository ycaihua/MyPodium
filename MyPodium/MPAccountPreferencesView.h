//
//  MPAccountPreferencesView.h
//  MyPodium
//
//  Created by Connor Neville on 7/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class MPLabel;
@class MPPreferencesButton;

@interface MPAccountPreferencesView : MPMenuView

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
