//
//  MPFriendsCell.h
//  MyPodium
//
//  Created by Connor Neville on 6/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNLabel.h"
#import <Parse/Parse.h>

@interface MPFriendsCell : UITableViewCell

@property UIView* solidColorView;
@property UIView* bottomBorder;
@property UIView* leadingBorder;
@property CNLabel* friendUsernameLabel;
@property CNLabel* friendRealNameLabel;
@property UIButton* infoButton;

- (void) updateForUser: (PFUser*) user;

+ (CGFloat) cellHeight;
@end
