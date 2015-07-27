//
//  MPHomeView.h
//  MyPodium
//
//  Created by Connor Neville on 5/29/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class MPHomeTipView;
@class MPBoldColorButton;

@interface MPHomeView : MPMenuView

//Each of 4 buttons will have a random background
//color, done by shuffling below mutable array
@property NSMutableArray* buttonColors;

@property MPBoldColorButton* friendsButton;
@property MPBoldColorButton* teamsButton;
@property MPBoldColorButton* rulesButton;
@property MPBoldColorButton* eventsButton;

@property MPHomeTipView* tipView;

- (void) toggleTips;

@end
