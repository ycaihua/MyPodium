//
//  MPViewController.m
//  MyPodium
//
//  Base class for all controllers in MyPodium,
//  containing any behaviors used in
//  all other controller subclasses.
//
//  Created by Connor Neville on 5/13/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPViewController.h"
#import "MPView.h"

@interface MPViewController ()

@end

@implementation MPViewController

- (id) init {
    self = [super init];
    if(self) {
        MPView* newView = [[MPView alloc] init];
        self.view = newView;
    }
    return self;
}
@end
