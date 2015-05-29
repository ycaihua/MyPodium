//
//  MPHomeView.h
//  MyPodium
//
//  Created by Connor Neville on 5/29/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"
#import "MPHomeButton.h"

@interface MPHomeView : MPMenuView

//Each of 4 buttons will have a random background
//color, done by shuffling below mutable array
@property NSMutableArray* buttonColors;

@property MPHomeButton* friendsButton;
@property MPHomeButton* teamsButton;
@property MPHomeButton* modesButton;
@property MPHomeButton* eventsButton;

@end
