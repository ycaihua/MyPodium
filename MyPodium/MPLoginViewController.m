//
//  MPLoginViewController.m
//  MyPodium
//
//  Created by Connor Neville on 5/14/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPLoginViewController.h"
#import "MPLoginView.h"

@interface MPLoginViewController ()

@end

@implementation MPLoginViewController

- (id) init {
    self = [super init];
    if(self) {
        self.view = [[MPLoginView alloc] init];
    }
    return self;
}

@end
