//
//  MPMessagesCell.h
//  MyPodium
//
//  Created by Connor Neville on 6/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@class MPLabel;

@interface MPMessagesCell : UITableViewCell

@property UIView* solidColorView;
@property UIView* bottomBorder;
@property UIView* leadingBorder;

@property MPLabel* titleLabel;
@property MPLabel* userLabel;

@property UIButton* leftButton;
@property UIButton* centerButton;
@property UIButton* rightButton;

@property NSIndexPath* indexPath;

- (void) updateForMessage: (PFObject*) message displaySender: (BOOL) displaySender;
- (void) showLeftButton;
- (void) hideLeftButton;

+ (CGFloat) cellHeight;

@end