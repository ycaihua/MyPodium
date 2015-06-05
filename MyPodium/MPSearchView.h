//
//  MPSearchView.h
//  MyPodium
//
//  Created by Connor Neville on 6/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPTextField.h"
#import "MPImageButton.h"

@interface MPSearchView : UIView

@property UIView* bottomBorder;
@property MPTextField* searchField;
@property MPImageButton* searchButton;

+ (CGFloat) standardHeight;

@end
