//
//  MPMakeTeamViewController.m
//  MyPodium
//
//  Created by Connor Neville on 6/15/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMakeTeamViewController.h"
#import "MPMakeTeamView.h"

@interface MPMakeTeamViewController ()

@end

@implementation MPMakeTeamViewController

- (id) init {
    self = [super init];
    if(self) {
        MPMakeTeamView* view = [[MPMakeTeamView alloc] init];
        self.view = view;
    }
    return self;
}

@end
