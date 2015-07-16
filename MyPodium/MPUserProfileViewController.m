//
//  MPUserProfileViewController.m
//  MyPodium
//
//  Created by Connor Neville on 6/17/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPControllerManager.h"
#import "UIColor+MPColor.h"

#import "MPFriendsModel.h"

#import "MPUserProfileView.h"
#import "MPBottomEdgeButton.h"
#import "MPMenu.h"
#import "MPLabel.h"

#import "MPUserProfileViewController.h"

@interface MPUserProfileViewController ()

@end

@implementation MPUserProfileViewController

- (id) initWithUser: (PFUser*)user {
    self = [super init];
    if(self) {
        MPUserProfileView* view = [[MPUserProfileView alloc] initWithUser: user];
        self.view = view;
        self.displayedUser = user;
        [self makeControlActions];
    }
    return self;
}

- (void) makeControlActions {
    MPUserProfileView* view = (MPUserProfileView*) self.view;
    dispatch_async(dispatch_queue_create("ProfileControllerQueue", 0), ^{
        MPFriendStatus friendStatus = [MPFriendsModel friendStatusFromUser:[PFUser currentUser] toUser:self.displayedUser];
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (friendStatus) {
                case MPFriendStatusNotFriends:
                    [view.leftBottomButton addTarget:self action:@selector(goBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                    [view.rightBottomButton addTarget:self action:@selector(sendFriendRequestButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                    break;
                    
                default:
                    break;
            }
        });
    });
}

- (void) goBackButtonPressed: (id) sender {
    [MPControllerManager dismissViewController: self];
}

- (void) sendFriendRequestButtonPressed: (id) sender {
    MPUserProfileView* view = (MPUserProfileView*) self.view;
    [view startLoading];
    dispatch_async(dispatch_queue_create("AddFriendQueue", 0), ^{
        BOOL success = [MPFriendsModel sendRequestFromUser:[PFUser currentUser] toUser:self.displayedUser];
        dispatch_async(dispatch_get_main_queue(), ^{
            [view finishLoading];
            if(success)
                [view.menu.subtitleLabel displayMessage:
                 [NSString stringWithFormat:@"You sent %@ a friend request.",
                  self.displayedUser.username]
                                            revertAfter:YES
                                              withColor:[UIColor MPGreenColor]];
            else
                [view.menu.subtitleLabel displayMessage:
                 @"There was an error sending your request. Please try again later."
                                            revertAfter:YES
                                              withColor:[UIColor MPRedColor]];
        });
    });
}

@end
