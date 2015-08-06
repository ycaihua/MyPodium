//
//  MPRegisterUsernameView.h
//  MyPodium
//
//  Created by Connor Neville on 8/6/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPView.h"

@class MPLabel;
@class MPTextField;

@interface MPRegisterUsernameView : MPView

@property MPLabel* titleLabel;
@property MPLabel* infoLabel;
@property MPTextField* usernameField;

@end