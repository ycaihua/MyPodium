//
//  MPTableHeader.h
//  MyPodium
//
//  Created by Connor Neville on 6/3/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPView.h"

#import <UIKit/UIKit.h>

@class MPLabel;

@interface MPTableHeader : MPView

- (id) initWithText: (NSString*) text;

@property UIView* bottomBorder;
@property MPLabel* headerLabel;

+ (CGFloat) headerHeight;

@end
