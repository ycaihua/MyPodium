//
//  MPProfileSubviewButton.h
//  MyPodium
//
//  Created by Connor Neville on 5/19/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNLabel.h"

@interface MPProfileSubviewButton : UIButton

@property CNLabel* numericTitleLabel;
@property CNLabel* subtitleLabel;
@property CNLabel* tapToViewLabel;
@property UIView* grayBorder;

@end
