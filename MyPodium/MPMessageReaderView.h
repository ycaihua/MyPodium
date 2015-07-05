//
//  MPMessageReaderView.h
//  MyPodium
//
//  Created by Connor Neville on 7/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class MPLabel;

@interface MPMessageReaderView : MPMenuView

@property MPLabel* titleLabel;
@property MPLabel* senderLabel;
@property MPLabel* receiverLabel;
@property MPLabel* timestampLabel;

@end
