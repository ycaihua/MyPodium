//
//  MPHomeTipView.h
//  MyPodium
//
//  Created by Connor Neville on 7/10/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPLabel;

@interface MPHomeTipView : UIView

@property MPLabel* tipDescriptionLabel;
@property MPLabel* tipContentLabel;

@property NSArray* allTips;

+ (CGFloat) defaultHeight;

@end
