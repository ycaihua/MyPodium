//
//  MPSearchControl.h
//  MyPodium
//
//  Created by Connor Neville on 6/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPView.h"

#import <UIKit/UIKit.h>

@class MPTextField;

@interface MPSearchControl : MPView

@property UIView* bottomBorder;
@property MPTextField* searchField;
@property UIButton* searchButton;

+ (CGFloat) standardHeight;

@end
