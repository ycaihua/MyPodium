//
//  MPEventTypeView.h
//  MyPodium
//
//  Created by Connor Neville on 8/21/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPView.h"
#import "MPLabel.h"

@interface MPEventTypeView : MPView

typedef NS_ENUM(NSInteger, MPEventType) {
    MPEventTypeMatch = 0,
    MPEventTypeTournament = 1,
    MPEventTypeLeague = 2,
    MPEventTypeLadder = 3
};

@property NSArray* allImages;
@property NSArray* allSmallImages;
@property NSArray* allTitles;
@property NSArray* allDescriptions;
@property NSMutableArray* smallImageColors;
@property NSArray* allButtons;
@property NSInteger selectedIndex;

@property MPLabel* titleLabel;
@property UIImageView* currentImageView;
@property MPLabel* currentTitle;
@property MPLabel* currentDescription;

- (void) changeIndexSelected: (int) newIndex;
- (MPEventType) selectedEventType;

@end
