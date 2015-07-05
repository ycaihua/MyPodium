//
//  MPMessageReaderViewController.m
//  MyPodium
//
//  Created by Connor Neville on 7/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMessageReaderViewController.h"
#import "MPMessageReaderView.h"

#import <Parse/Parse.h>

@interface MPMessageReaderViewController ()

@end

@implementation MPMessageReaderViewController

- (id) initWithMessage: (PFObject*) message {
    self = [super init];
    if(self) {
        self.view = [[MPMessageReaderView alloc] init];
    }
    return self;
}

@end