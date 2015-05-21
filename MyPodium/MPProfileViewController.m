//
//  MPProfileViewController.m
//  MyPodium
//
//  Created by Connor Neville on 5/18/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPProfileViewController.h"
#import "MPProfileView.h"
#import "MPProfileFriendsSubviewController.h"

@interface MPProfileViewController ()

@end

@implementation MPProfileViewController

- (id) initWithUser: (PFUser*) user {
    self = [super init];
    if(self) {
        MPProfileView* view = [[MPProfileView alloc] init];
        view.menu.titleLabel.text = [user.username uppercaseString];
        self.view = view;
        self.user = user;
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
        self.user = [PFUser currentUser];
        [self addProfileControlActions];
    }
    return self;
}

- (void) addProfileControlActions {
    MPProfileView* view = (MPProfileView*) self.view;
    MPProfileFriendsSubviewController* friendsController =
    [[MPProfileFriendsSubviewController alloc] initWithUser: self.user];
    [friendsController setView: view.friendsSubview.contentTable];
    [view.friendsSubview.contentTable setDataSource: friendsController];
    [view.friendsSubview.contentTable setDelegate: friendsController];
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
