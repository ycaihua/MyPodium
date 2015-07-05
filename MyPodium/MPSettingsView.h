//
//  MPSettingsView.h
//  MyPodium
//
//  Created by Connor Neville on 7/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class MPBoldColorButton;

@interface MPSettingsView : MPMenuView

@property NSMutableArray* buttonColors;
@property MPBoldColorButton* accountDetailsButton;
@property MPBoldColorButton* accountPreferencesButton;

@end
