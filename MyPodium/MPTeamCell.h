//
//  MPTeamCell.h
//  MyPodium
//
//  Created by Connor Neville on 6/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@class CNLabel;

@interface MPTeamCell : UITableViewCell

@property UIView* solidColorView;
@property UIView* bottomBorder;
@property UIView* leadingBorder;

@property CNLabel* teamNameLabel;
@property CNLabel* teamOwnerLabel;
@property CNLabel* numPlayersLabel;

@property UIButton* leftButton;
@property UIButton* centerButton;
@property UIButton* rightButton;

@property NSIndexPath* indexPath;

- (void) updateForTeam: (PFObject*) team;
- (void) showLeftButton;
- (void) hideLeftButton;

+ (CGFloat) cellHeight;

@end