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
        dispatch_async(dispatch_queue_create("UserInfoQueue", 0), ^{
            MPFriendStatus friendStatus = [MPFriendsModel friendStatusFromUser:[PFUser currentUser]
                                                                        toUser:user];
            BOOL acceptingRequests = [user[@"pref_friendRequests"] boolValue];
            dispatch_async(dispatch_get_main_queue(), ^{
                MPUserProfileView* view = [[MPUserProfileView alloc] initWithUser: user withStatus:friendStatus acceptingRequests:acceptingRequests];
                self.view = view;
                self.displayedUser = user;
                self.delegate = self;
                [self reloadData];
                
            });
        });
    }
    return self;
}

- (void) refreshDataForController:(MPMenuViewController *)controller {
    MPUserProfileViewController* userProfileVC = (MPUserProfileViewController*)controller;
    MPUserProfileView* view = (MPUserProfileView*) userProfileVC.view;
    
    MPFriendStatus friendStatus = [MPFriendsModel friendStatusFromUser:[PFUser currentUser]
                                                                toUser:self.displayedUser];
    
    view.displayedUser = userProfileVC.displayedUser;
    view.userStatus = friendStatus;
    view.userAcceptingRequests = [userProfileVC.displayedUser[@"pref_friendRequests"] boolValue];
    
    [view refreshControlsForUser];
    
    [view.leftBottomButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [view.rightBottomButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    
    
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
}

- (UITableView*) tableViewToRefreshForController:(MPMenuViewController *)controller {
    return nil;
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
                [self reloadDataWithCompletionBlock:^{
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    view.menu.subtitleLabel.persistentText = [MPUserProfileView defaultSubtitle];
                    [view.menu.subtitleLabel displayMessage:
                     [NSString stringWithFormat:@"You sent %@ a friend request.",
                      self.displayedUser.username]
                                                revertAfter:YES
                                                  withColor:[UIColor MPGreenColor]];
                }];
            else
                [self reloadDataWithCompletionBlock:^{
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    view.menu.subtitleLabel.persistentText = [MPUserProfileView defaultSubtitle];
                    [view.menu.subtitleLabel displayMessage:
                     [NSString stringWithFormat:@"There was an error sending %@ a request. Please try again later.",
                      self.displayedUser.username]
                                                revertAfter:YES
                                                  withColor:[UIColor MPRedColor]];
                }];
        });
    });
}

@end
