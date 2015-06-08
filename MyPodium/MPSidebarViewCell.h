//
//  MPSidebarViewCell.h
//  MyPodium
//
//  Created by Connor Neville on 5/30/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPSidebarButton;

@interface MPSidebarViewCell : UITableViewCell

@property MPSidebarButton* cellButton;

- (void) updateWithRow: (int) row;

+ (NSArray*) cellLabelStrings;
+ (CGFloat) cellHeight;

@end
