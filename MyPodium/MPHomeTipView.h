//
//  MPHomeTipView.h
//  MyPodium
//
//  Created by Connor Neville on 7/10/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPLabel;

@interface MPHomeTipView : UIControl

@property MPLabel* tipDescriptionLabel;
@property MPLabel* tipContentLabel;
@property MPLabel* showOrHideLabel;

@property NSArray* allTips;
@property BOOL expanded;

- (void) toggleExpanded;
- (void) displayRandomTip;

+ (CGFloat) defaultHeight;
+ (CGFloat) collapsedHeight;

@end
