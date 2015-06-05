//
//  MPTableHeader.h
//  MyPodium
//
//  Created by Connor Neville on 6/3/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNLabel.h"
#import "MPView.h"

@interface MPTableHeader : MPView

- (id) initWithText: (NSString*) text;

@property UIView* bottomBorder;
@property CNLabel* headerLabel;

+ (CGFloat) headerHeight;

@end
