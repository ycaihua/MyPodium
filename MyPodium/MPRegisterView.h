//
//  MPRegisterView.h
//  MyPodium
//
//  Created by Connor Neville on 5/15/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPView.h"

#import <UIKit/UIKit.h>

@class MPLabel;
@class MPFormView;
@class MPTextField;

@interface MPRegisterView : MPView

@property MPLabel* titleLabel;
@property MPFormView* form;

@end
