//
//  MPViewWithMenu.h
//  MyPodium
//
//  Created by Connor Neville on 5/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPView.h"

@class MPMenu;

@interface MPMenuView : MPView

@property MPMenu* menu;

- (id) initWithTitleText: (NSString*) titleText subtitleText: (NSString*) subtitleText;

- (void) startLoading;
- (void) finishLoading;

+ (NSString*) defaultSubtitle;

@end
