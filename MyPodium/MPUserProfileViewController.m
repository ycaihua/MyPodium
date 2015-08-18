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

#import "MPMessageComposerView.h"
#import "MPUserProfileView.h"
#import "MPProfileControlBlock.h"
#import "MPBottomEdgeButton.h"
#import "MPMenu.h"
#import "MPLabel.h"
#import "MPTextField.h"

#import "MPUserProfileViewController.h"
#import "MPSettingsViewController.h"
#import "MPMessageComposerViewController.h"
#import "MPMakeTeamViewController.h"

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
                [self addMenuActions];
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

    dispatch_async(dispatch_get_main_queue(), ^{
        [view refreshControlsForUser];
        [view.leftBottomButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
        [view.rightBottomButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
        [view.leftBottomButton addTarget:self action:@selector(goBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        switch (friendStatus) {
            case MPFriendStatusNotFriends:
                [view.rightBottomButton addTarget:self action:@selector(sendFriendRequestButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case MPFriendStatusIncomingPending:
                [view.rightBottomButton addTarget:self action:@selector(acceptOrDenyIncomingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case MPFriendStatusOutgoingPending:
                [view.rightBottomButton addTarget:self action:@selector(cancelOutgoingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case MPFriendStatusFriends:
                [view.rightBottomButton addTarget:self action:@selector(removeFriendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [view.controlBlock.buttons[0] addTarget:self action:@selector(messageUserButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [view.controlBlock.buttons[1] addTarget:self action:@selector(newTeamButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case MPFriendStatusSameUser:
                [view.rightBottomButton addTarget:self action:@selector(settingsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
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

- (void) removeFriendButtonPressed: (id) sender {
    MPUserProfileView* view = (MPUserProfileView*) self.view;
    [view startLoading];
    dispatch_async(dispatch_queue_create("RemoveFriendQueue", 0), ^{
        BOOL success = [MPFriendsModel removeFriendRelationWithFirstUser:self.displayedUser secondUser:[PFUser currentUser]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(success)
                [self reloadDataWithCompletionBlock:^{
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    view.menu.subtitleLabel.persistentText = [MPUserProfileView defaultSubtitle];
                    [view.menu.subtitleLabel displayMessage:
                     [NSString stringWithFormat:@"You removed %@ as a friend.",
                      self.displayedUser.username]
                                                revertAfter:YES
                                                  withColor:[UIColor MPGreenColor]];
                }];
            else
                [self reloadDataWithCompletionBlock:^{
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    view.menu.subtitleLabel.persistentText = [MPUserProfileView defaultSubtitle];
                    [view.menu.subtitleLabel displayMessage:
                     [NSString stringWithFormat:@"There was an error removing %@ as a friend. Please try again later.",
                      self.displayedUser.username]
                                                revertAfter:YES
                                                  withColor:[UIColor MPRedColor]];
                }];
        });
    });
}

- (void) acceptOrDenyIncomingButtonPressed: (id) sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Respond to Request" message:
                                [NSString stringWithFormat:@"Do you wish to accept or deny %@'s friend request?",
                                 self.displayedUser.username] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* acceptAction = [UIAlertAction actionWithTitle:@"Accept" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler) {
        MPUserProfileView* view = (MPUserProfileView*) self.view;
        [view startLoading];
        dispatch_async(dispatch_queue_create("AcceptFriendQueue", 0), ^{
            BOOL success = [MPFriendsModel acceptRequestFromUser:self.displayedUser toUser:[PFUser currentUser] canReverse:NO];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(success)
                    [self reloadDataWithCompletionBlock:^{
                        view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                        view.menu.subtitleLabel.persistentText = [MPUserProfileView defaultSubtitle];
                        [view.menu.subtitleLabel displayMessage:
                         [NSString stringWithFormat:@"You accepted %@'s friend request.",
                          self.displayedUser.username] revertAfter:YES withColor:[UIColor MPGreenColor]];
                    }];
                else
                    [self reloadDataWithCompletionBlock:^{
                        view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                        view.menu.subtitleLabel.persistentText = [MPUserProfileView defaultSubtitle];
                        [view.menu.subtitleLabel displayMessage:
                         [NSString stringWithFormat:@"There was an error accepting %@'s request. Please try again later.", self.displayedUser.username] revertAfter:YES withColor:[UIColor MPRedColor]];
                    }];
            });
        });
        
    }];
    UIAlertAction* denyAction = [UIAlertAction actionWithTitle:@"Deny" style:UIAlertActionStyleDestructive handler:^(UIAlertAction* handler) {
        MPUserProfileView* view = (MPUserProfileView*) self.view;
        [view startLoading];
        dispatch_async(dispatch_queue_create("DenyFriendQueue", 0), ^{
            BOOL success = [MPFriendsModel removeRequestFromUser:self.displayedUser toUser:[PFUser currentUser] canReverse:NO];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(success)
                    [self reloadDataWithCompletionBlock:^{
                        view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                        view.menu.subtitleLabel.persistentText = [MPUserProfileView defaultSubtitle];
                        [view.menu.subtitleLabel displayMessage:
                         [NSString stringWithFormat:@"You denied %@'s friend request.",
                          self.displayedUser.username] revertAfter:YES withColor:[UIColor MPGreenColor]];
                    }];
                else
                    [self reloadDataWithCompletionBlock:^{
                        view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                        view.menu.subtitleLabel.persistentText = [MPUserProfileView defaultSubtitle];
                        [view.menu.subtitleLabel displayMessage:
                         [NSString stringWithFormat:@"There was an error denying %@'s request. Please try again later.", self.displayedUser.username] revertAfter:YES withColor:[UIColor MPRedColor]];
                    }];
            });
        });
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction: acceptAction];
    [alert addAction: denyAction];
    [alert addAction: cancelAction];
    [self presentViewController: alert animated:YES completion:nil];
}

- (void) cancelOutgoingButtonPressed: (id) sender {
    MPUserProfileView* view = (MPUserProfileView*) self.view;
    [view startLoading];
    dispatch_async(dispatch_queue_create("CancelRequestQueue", 0), ^{
        BOOL success = [MPFriendsModel removeRequestFromUser:[PFUser currentUser] toUser:self.displayedUser canReverse:NO];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(success)
                [self reloadDataWithCompletionBlock:^{
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    view.menu.subtitleLabel.persistentText = [MPUserProfileView defaultSubtitle];
                    [view.menu.subtitleLabel displayMessage:
                     [NSString stringWithFormat:@"You cancelled your friend request to %@.",
                      self.displayedUser.username] revertAfter:YES withColor:[UIColor MPGreenColor]];
                }];
            else
                [self reloadDataWithCompletionBlock:^{
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    view.menu.subtitleLabel.persistentText = [MPUserProfileView defaultSubtitle];
                    [view.menu.subtitleLabel displayMessage:
                     [NSString stringWithFormat:@"There was an error cancelling your request to %@. Please try again later", self.displayedUser.username] revertAfter:YES withColor:[UIColor MPRedColor]];
                }];
        });
    });
}

- (void) settingsButtonPressed: (id) sender {
    [MPControllerManager presentViewController:[[MPSettingsViewController alloc] init] fromController:self];
}

- (void) messageUserButtonPressed: (id) sender {
    MPMessageComposerViewController* destination = [[MPMessageComposerViewController alloc] init];
    MPMessageComposerView* view = (MPMessageComposerView*)destination.view;
    view.recipientsField.text = self.displayedUser.username;
    [MPControllerManager presentViewController:destination fromController:self];
}

- (void) newTeamButtonPressed: (id) sender {
    [MPControllerManager presentViewController:[[MPMakeTeamViewController alloc] initWithSelectedUser:self.displayedUser] fromController:self];
}

@end
