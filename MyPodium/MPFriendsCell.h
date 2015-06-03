//
//  MPFriendsCell.h
//  MyPodium
//
//  Created by Connor Neville on 6/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNLabel.h"
#import "MPFriendsButton.h"
#import <Parse/Parse.h>

@interface MPFriendsCell : UITableViewCell

@property UIView* solidColorView;
@property UIView* bottomBorder;
@property UIView* leadingBorder;

@property CNLabel* friendUsernameLabel;
@property CNLabel* friendRealNameLabel;

//Should be: check if incoming pending, info otherwise
@property MPFriendsButton* greenButton;
//Should be: minus
@property MPFriendsButton* redButton;

- (void) updateForUser: (PFUser*) user;
- (void) updateForIncomingRequest;
- (void) updateForFriendOrOutgoingRequest;

+ (CGFloat) cellHeight;
@end
