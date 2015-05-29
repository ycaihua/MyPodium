//
//  MPHomeView.h
//  MyPodium
//
//  Created by Connor Neville on 5/29/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"
#import "MPButtonWithSubtitle.h"

@interface MPHomeView : MPMenuView

//Each of 4 buttons will have a random background
//color, done by shuffling below mutable array
@property NSMutableArray* buttonColors;

@property MPButtonWithSubtitle* friendsButton;
@property MPButtonWithSubtitle* teamsButton;
@property MPButtonWithSubtitle* gameModesButton;
@property MPButtonWithSubtitle* eventsButton;

@end
