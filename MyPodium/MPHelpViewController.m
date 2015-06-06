//
//  MPHelpViewController.m
//  MyPodium
//
//  Created by Connor Neville on 6/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPHelpViewController.h"
#import "MPLoginView.h"
#import "MPHelpView.h"

@interface MPHelpViewController ()

@end

@implementation MPHelpViewController

- (id) init {
    self = [super init];
    if(self) {
        self.view = [[MPHelpView alloc] init];
        [self addControlActions];
    }
    return self;
}

- (void) addControlActions {
    MPHelpView* view = (MPHelpView*) self.view;
    [view.logoButton addTarget:self action:@selector(logoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) logoButtonPressed: (id) sender {
    MPLoginView* presenterView = (MPLoginView*) self.presentingViewController.view;
    [presenterView revertAnimation];
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
