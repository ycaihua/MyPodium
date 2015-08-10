//
//  MPTableViewCell.h
//  MyPodium
//
//  Created by Connor Neville on 8/10/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MPLabel;

@interface MPTableViewCell : UITableViewCell

@property UIView* solidColorView;
@property UIView* bottomBorder;
@property UIView* leadingBorder;

@property MPLabel* titleLabel;
@property MPLabel* subtitleLabel;

@property NSMutableArray* buttons;
@property int visibleButtons;

@property NSIndexPath* indexPath;

- (void) setNumberOfButtons: (int) numberOfButtons;

+ (CGFloat) cellHeight;

@end
