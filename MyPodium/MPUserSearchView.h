//
//  MPUserSearchView.h
//  MyPodium
//
//  Created by Connor Neville on 6/4/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"
#import "MPTextField.h"

@interface MPUserSearchView : MPMenuView

@property MPTextField* searchField;

+ (NSString*) defaultSubtitle;

@end
