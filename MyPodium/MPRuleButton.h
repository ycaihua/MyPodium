//
//  MPRuleButton.h
//  MyPodium
//
//  Created by Connor Neville on 7/27/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPDualLabelButton.h"

@interface MPRuleButton : MPDualLabelButton

@property BOOL toggledOn;
@property NSString* toggledOnTitle;
@property NSString* toggledOnSubtitle;
@property NSString* toggledOffTitle;
@property NSString* toggledOffSubtitle;

- (void) toggleSelected;

- (id) initWithToggledOnTitle: (NSString*) onTitle onSubtitle: (NSString*) onSubtitle offTitle: (NSString*) offTitle offSubtitle: (NSString*) offSubtitle;

+ (CGFloat) defaultHeight;

@end


