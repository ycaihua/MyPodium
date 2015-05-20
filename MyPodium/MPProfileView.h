//
//  MPProfileView.h
//  MyPodium
//
//  Created by Connor Neville on 5/18/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"
#import "MPProfileSubview.h"

@interface MPProfileView : MPMenuView

@property MPProfileSubview* friendsSubview;
@property MPProfileSubview* eventsSubview;
@property MPProfileSubview* modesSubview;

@end
