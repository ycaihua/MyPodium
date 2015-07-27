//
//  MPRuleCell.h
//  MyPodium
//
//  Created by Connor Neville on 7/20/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@class MPLabel;

@interface MPRuleCell : UITableViewCell

@property UIView* solidColorView;
@property UIView* bottomBorder;
@property UIView* leadingBorder;

@property MPLabel* modeNameLabel;
@property MPLabel* modeDetailsLabel;

@property UIButton* leftButton;
@property UIButton* centerButton;
@property UIButton* rightButton;

@property NSIndexPath* indexPath;

- (void) updateForRule: (PFObject*) rule;

- (void) showLeftButton;
- (void) hideLeftButton;

+ (CGFloat) cellHeight;

@end