//
//  MPRuleButton.h
//  MyPodium
//
//  Created by Connor Neville on 7/27/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPDualLabelButton.h"

@interface MPRuleButton : MPDualLabelButton

@property BOOL playerModeSelected;

- (void) toggleSelected;

+ (CGFloat) defaultHeight;

@end
