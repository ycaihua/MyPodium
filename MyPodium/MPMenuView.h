//
//  MPViewWithMenu.h
//  MyPodium
//
//  Created by Connor Neville on 5/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenu.h"
#import "MPView.h"

@interface MPMenuView : MPView

@property MPMenu* menu;

- (id) initWithTitleText: (NSString*) titleText subtitleText: (NSString*) subtitleText;

@end
