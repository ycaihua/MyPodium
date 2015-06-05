//
//  MPUserCell.h
//  MyPodium
//
//  Created by Connor Neville on 6/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "CNLabel.h"

@interface MPUserCell : UITableViewCell

@property UIView* solidColorView;
@property UIView* bottomBorder;
@property UIView* leadingBorder;

@property CNLabel* friendUsernameLabel;
@property CNLabel* friendRealNameLabel;

@property UIButton* leftButton;
@property UIButton* rightButton;

@property NSIndexPath* indexPath;

- (void) updateForUser: (PFUser*) user;

+ (CGFloat) cellHeight;

@end
