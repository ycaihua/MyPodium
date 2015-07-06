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
@property UITextView* bodyView;
@property MPBottomEdgeButton* cancelButton;
@property MPBottomEdgeButton* sendButton;

@end
