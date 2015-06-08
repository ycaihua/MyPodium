//
//  MPMenu.h
//  MyPodium
//
//  Created by Connor Neville on 5/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPView.h"

#import <UIKit/UIKit.h>

@class CNLabel;

@interface MPMenu : MPView

@property UIButton* sidebarButton;
@property UIButton* logOutButton;
@property UIButton* titleButton;
@property CNLabel* subtitleLabel;

- (void) displayTitlePressMessageForPageName: (NSString*) pageName;

+ (CGFloat) height;

@end
