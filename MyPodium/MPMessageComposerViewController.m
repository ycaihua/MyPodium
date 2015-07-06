//
//  MPMessageComposerViewController.m
//  MyPodium
//
//  Created by Connor Neville on 7/6/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMessageComposerViewController.h"
#import "MPMessageComposerView.h"

@interface MPMessageComposerViewController ()

@end

@implementation MPMessageComposerViewController

- (id) init {
    self = [super init];
    if(self) {
        self.view = [[MPMessageComposerView alloc] init];
    }
    return self;
}

@end
