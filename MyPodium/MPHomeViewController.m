//
//  MPHomeViewController.m
//  MyPodium
//
//  Created by Connor Neville on 5/29/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPHomeViewController.h"
#import "MPHomeView.h"

@interface MPHomeViewController ()

@end

@implementation MPHomeViewController

- (id) init {
    //This is the one VC that can be initialized before its drawer
    //controller, so don't add menu actions on init.
    self = [super init];
    if(self) {
        self.view = [[MPHomeView alloc] init];
    }
    return self;
}

@end
