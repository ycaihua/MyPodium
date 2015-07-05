//
//  MPMessageReaderViewController.h
//  MyPodium
//
//  Created by Connor Neville on 7/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuViewController.h"

@class PFObject;

@interface MPMessageReaderViewController : MPMenuViewController

- (id) initWithMessage: (PFObject*) message;

@end
