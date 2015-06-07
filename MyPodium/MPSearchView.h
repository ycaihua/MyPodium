//
//  MPSearchView.h
//  MyPodium
//
//  Created by Connor Neville on 6/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPView.h"
@class MPTextField;

@interface MPSearchView : MPView

@property UIView* bottomBorder;
@property MPTextField* searchField;
@property UIButton* searchButton;

+ (CGFloat) standardHeight;

@end
