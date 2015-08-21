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
@property NSArray* allTitles;
@property NSArray* allDescriptions;
@property NSInteger selectedIndex;

@property UIImageView* currentImageView;
@property MPLabel* currentTitle;
@property MPLabel* currentDescription;
@property MPLabel* infoLabel;
@property NSArray* unselectedImageViews;

@end
