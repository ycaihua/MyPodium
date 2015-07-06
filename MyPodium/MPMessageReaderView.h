//
//  MPMessageReaderView.h
//  MyPodium
//
//  Created by Connor Neville on 7/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class MPLabel;
@class MPBottomEdgeButton;
@class PFObject;

@interface MPMessageReaderView : MPMenuView

@property MPLabel* titleLabel;
@property MPLabel* senderLabel;
@property MPLabel* receiverLabel;
@property MPLabel* timestampLabel;
@property UITextView* bodyView;

@property MPBottomEdgeButton* deleteButton;
@property MPBottomEdgeButton* replyButton;

- (void) updateForMessage: (PFObject*) message;

@end
