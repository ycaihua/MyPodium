//
//  MPUserProfileView.h
//  MyPodium
//
//  Created by Connor Neville on 6/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"
#import "MPFriendsModel.h"

@class MPLabel;
@class MPBottomEdgeButton;
@class MPProfileControlBlock;

@class PFUser;

@interface MPUserProfileView : MPMenuView

@property PFUser* displayedUser;
@property MPFriendStatus userStatus;
@property BOOL userAcceptingRequests;

@property MPLabel* usernameLabel;
@property MPLabel* realNameLabel;
@property MPLabel* creationDateLabel;
@property MPLabel* friendStatusLabel;

@property MPProfileControlBlock* controlBlock;

@property MPBottomEdgeButton* leftBottomButton;
@property MPBottomEdgeButton* rightBottomButton;

- (id) initWithUser: (PFUser*) user;

@end
