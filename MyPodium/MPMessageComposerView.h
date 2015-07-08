//
//  MPMessageComposerView.h
//  MyPodium
//
//  Created by Connor Neville on 7/6/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class MPTextField;
@class MPLabel;
@class MPBottomEdgeButton;

@interface MPMessageComposerView : MPMenuView

@property MPTextField* recipientsField;
@property MPLabel* recipientsLabel;
@property MPTextField* titleField;
@property MPLabel* titleLimitLabel;
@property UITextView* bodyView;
@property MPLabel* bodyLimitLabel;
@property MPBottomEdgeButton* cancelButton;
@property MPBottomEdgeButton* sendButton;

- (void) shiftVerticalConstraintsBy: (CGFloat) amount;
- (void) restoreDefaultConstraints;
+ (NSString*) defaultSubtitle;

@end
