//
//  MPForgotPasswordViewController.m
//  MyPodium
//
//  Created by Connor Neville on 5/15/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPForgotPasswordViewController.h"
#import "MPForgotPasswordView.h"

@interface MPForgotPasswordViewController ()

@end

@implementation MPForgotPasswordViewController

- (id) init {
    self = [super init];
    if(self) {
        self.view = [[MPForgotPasswordView alloc] init];
    }
    return self;
}

@end
