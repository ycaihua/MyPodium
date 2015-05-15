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
        [self addControlActions];
    }
    return self;
}

- (void) addControlActions {
    MPLoginView* view = (MPLoginView*)self.view;
    [view.loginButton addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) loginButtonPressed: (id) sender {
    NSLog(@"Login button press");
}
@end
