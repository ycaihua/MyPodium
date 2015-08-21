//
//  MPEventNameView.h
//  MyPodium
//
//  Created by Connor Neville on 8/21/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPView.h"

@class MPLabel;
@class MPTextField;

@interface MPEventNameView : MPView

@property MPLabel* titleLabel;
@property MPLabel* infoLabel;
@property MPTextField* nameField;

@end