//
//  MPFriendsHeader.h
//  MyPodium
//
//  Created by Connor Neville on 6/3/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNLabel.h"

@interface MPFriendsHeader : UIView

- (id) initWithText: (NSString*) text;

@property UIView* bottomBorder;
@property CNLabel* headerLabel;

+ (CGFloat) headerHeight;

@end
