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

@end
