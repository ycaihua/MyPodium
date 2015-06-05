//
//  MPUserSearchViewController.m
//  MyPodium
//
//  Created by Connor Neville on 6/4/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPUserSearchViewController.h"
#import "MPUserSearchView.h"

@interface MPUserSearchViewController ()

@end

@implementation MPUserSearchViewController

- (id) init {
    self = [super init];
    if(self) {
        MPUserSearchView* view = [[MPUserSearchView alloc] init];
        self.view = view;
    }
    return self;
}

@end
