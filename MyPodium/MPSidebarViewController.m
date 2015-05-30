//
//  MPSidebarViewController.m
//  MyPodium
//
//  Created by Connor Neville on 5/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPSidebarViewController.h"
#import "MPSidebarView.h"

@interface MPSidebarViewController ()

@end

@implementation MPSidebarViewController

- (id) init {
    self = [super init];
    if(self) {
        self.view = [[MPSidebarView alloc] init];
    }
    return self;
}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
