//
//  MPUserProfileView.h
//  MyPodium
//
//  Created by Connor Neville on 6/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class MPLabel;
@class MPDualLabelButton;

@class PFUser;

@interface MPUserProfileView : MPMenuView

@property PFUser* displayedUser;

@property MPLabel* usernameLabel;
@property MPLabel* realNameLabel;
@property MPLabel* creationDateLabel;
@property MPLabel* friendStatusLabel;

@property MPDualLabelButton* friendButton;

@property MPDualLabelButton* teamControlView;

- (id) initWithUser: (PFUser*) user;

@end
