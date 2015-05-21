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
    MPProfileView* view = (MPProfileView*) self.view;
    MPProfileSubview* friendsSubview = view.friendsSubview;
    [friendsSubview.sidebarButton addTarget:self action:@selector(sidebarButtonPressDown:) forControlEvents:UIControlEventTouchDown];
    [friendsSubview.sidebarButton addTarget:self action:@selector(sidebarButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [friendsSubview.sidebarButton addTarget:self action:@selector(sidebarButtonTouchCancel:) forControlEvents:UIControlEventTouchCancel];
    
    MPProfileSubview* eventsSubview = view.eventsSubview;
    [eventsSubview.sidebarButton addTarget:self action:@selector(sidebarButtonPressDown:) forControlEvents:UIControlEventTouchDown];
    [eventsSubview.sidebarButton addTarget:self action:@selector(sidebarButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [eventsSubview.sidebarButton addTarget:self action:@selector(sidebarButtonTouchCancel:) forControlEvents:UIControlEventTouchCancel];
    
    MPProfileSubview* modesSubview = view.modesSubview;
    [modesSubview.sidebarButton addTarget:self action:@selector(sidebarButtonPressDown:) forControlEvents:UIControlEventTouchDown];
    [modesSubview.sidebarButton addTarget:self action:@selector(sidebarButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [modesSubview.sidebarButton addTarget:self action:@selector(sidebarButtonTouchCancel:) forControlEvents:UIControlEventTouchCancel];
}

- (void) sidebarButtonPressDown: (id) sender {
    MPProfileSubviewButton* button = (MPProfileSubviewButton*) sender;
    [button applyPressDownStyle];
}

- (void) sidebarButtonTouchCancel: (id) sender {
    MPProfileSubviewButton* button = (MPProfileSubviewButton*) sender;
    [button revertPressDownStyle];
}

- (void) sidebarButtonTouchUpInside: (id) sender {
    MPProfileSubviewButton* button = (MPProfileSubviewButton*) sender;
    [button revertPressDownStyle];
    //Should also segue
}

@end
