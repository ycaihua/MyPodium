//
//  MPRuleNameView.h
//  MyPodium
//
//  Created by Connor Neville on 7/27/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPView.h"

@class MPLabel;
@class MPTextField;

@interface MPRuleNameView : MPView

@property MPLabel* titleLabel;
@property MPLabel* infoLabel;
@property MPTextField* nameField;

- (void) adjustForKeyboardShowing: (BOOL) keyboardShowing;

@end
