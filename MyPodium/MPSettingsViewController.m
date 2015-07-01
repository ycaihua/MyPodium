//
//  MPSettingsViewController.m
//  MyPodium
//
//  Created by Connor Neville on 7/1/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPSettingsView.h"

#import "MPSettingsViewController.h"

@interface MPSettingsViewController ()

@end

@implementation MPSettingsViewController

- (id) init {
    self = [super init];
    if(self) {
        MPSettingsView* view = [[MPSettingsView alloc] init];
        self.view = view;
    }
    return self;
}

@end
