//
//  MPRegisterViewController.m
//  MyPodium
//
//  Created by Connor Neville on 5/14/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPRegisterViewController.h"
#import "MPRegisterView.h"

@interface MPRegisterViewController ()

@end

@implementation MPRegisterViewController

- (id) init {
    self = [super init];
    if(self) {
        self.view = [[MPRegisterView alloc] init];
    }
    return self;
}

@end
