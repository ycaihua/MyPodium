//
//  MPUserSearchView.h
//  MyPodium
//
//  Created by Connor Neville on 6/4/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"
#import "MPTextField.h"
#import "MPImageButton.h"

@interface MPUserSearchView : MPMenuView

@property UIView* searchView;
@property UIView* searchViewBottomBorder;
@property MPTextField* searchField;
@property MPImageButton* searchButton;

+ (NSString*) defaultSubtitle;

@end
