//
//  MPUserCell.h
//  MyPodium
//
//  Created by Connor Neville on 6/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@class MPLabel;

@interface MPUserCell : UITableViewCell

@property UIView* solidColorView;
@property UIView* bottomBorder;
@property UIView* leadingBorder;

@property MPLabel* friendUsernameLabel;
@property MPLabel* friendRealNameLabel;

@property UIButton* leftButton;
@property UIButton* centerButton;
@property UIButton* rightButton;

@property NSIndexPath* indexPath;

- (void) updateForUser: (PFUser*) user;
- (void) hideLeftButton;
- (void) showLeftButton;

+ (CGFloat) cellHeight;

@end
