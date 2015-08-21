//
//  MPMakeEventViewController.m
//  MyPodium
//
//  Created by Connor Neville on 8/21/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPMakeEventView.h"

#import "MPMakeEventViewController.h"

@interface MPMakeEventViewController ()

@end

@implementation MPMakeEventViewController

- (id) init {
    self = [super init];
    if(self) {
        MPMakeEventView* view = [[MPMakeEventView alloc] init];
        self.view = view;
        [self makeControlActions];
    }
    return self;
}

- (void) makeControlActions {
    
}

@end
