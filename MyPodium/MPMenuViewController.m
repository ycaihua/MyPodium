//
//  MPMenuViewController.m
//  MyPodium
//
//  Created by Connor Neville on 5/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuViewController.h"
#import "MPMenuView.h"

@interface MPMenuViewController ()

@end

@implementation MPMenuViewController

- (id) initWithTitle: (NSString*) title subtitle: (NSString*) subtitle {
    self = [super init];
    if(self) {
        self.view = [[MPMenuView alloc] init];
    }
    return self;
}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
