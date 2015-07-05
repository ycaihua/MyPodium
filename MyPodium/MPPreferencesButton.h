//
//  MPPreferencesButton.h
//  MyPodium
//
//  Created by Connor Neville on 7/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPDualLabelButton.h"

@interface MPPreferencesButton : MPDualLabelButton

@property BOOL toggledOn;
@property UIImageView* referenceImage;

- (void) toggleSelected;

@end
