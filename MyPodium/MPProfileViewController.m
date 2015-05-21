//
//  MPProfileViewController.m
//  MyPodium
//
//  Created by Connor Neville on 5/18/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPProfileViewController.h"
#import "MPProfileView.h"

@interface MPProfileViewController ()

@end

@implementation MPProfileViewController

- (id) initWithUser: (PFUser*) user {
    self = [super init];
    if(self) {
        MPProfileView* view = [[MPProfileView alloc] init];
        view.menu.titleLabel.text = [user.username uppercaseString];
        self.view = view;
        [self addProfileControlActions];
    }
    return self;
}

- (id) init {
    self = [super init];
    if(self) {
        MPProfileView* view = [[MPProfileView alloc] init];
        view.menu.titleLabel.text = [[PFUser currentUser].username uppercaseString];
        self.view = view;
        [self addProfileControlActions];
    }
    return self;
}

- (void) addProfileControlActions {
    MPProfileView* view = (MPProfileView*) view;
}

@end
