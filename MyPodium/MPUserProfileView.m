//
//  MPUserProfileView.m
//  MyPodium
//
//  Created by Connor Neville on 6/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPFriendsModel.h"

#import "MPLabel.h"
#import "MPUserProfileView.h"

#import <Parse/Parse.h>

@implementation MPUserProfileView

- (id) initWithUser: (PFUser*) user {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:
            [NSString stringWithFormat:@"User Profile: %@", user.username]];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        self.displayedUser = user;
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    MPFriendStatus status = [MPFriendsModel friendStatusFromUser:[PFUser currentUser] toUser:self.displayedUser];
    
    //self.friendStatusLabel
    self.friendStatusLabel = [[MPLabel alloc] init];
    switch (status) {
        case MPFriendStatusFriends:
            self.friendStatusLabel.text = @"Your friend";
            break;
        case MPFriendStatusNotFriends:
            self.friendStatusLabel.text = @"You are not currently friends";
            break;
        case MPFriendStatusIncomingPending:
            self.friendStatusLabel.text = @"You have sent the user a request";
            break;
        case MPFriendStatusOutgoingPending:
            self.friendStatusLabel.text = @"You have a friend request from this user";
            break;
        case MPFriendStatusSameUser:
            self.friendStatusLabel.text = @"Your profile";
            break;
        default:
            break;
    }
    self.friendStatusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.friendStatusLabel];
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.friendStatusLabel
                           [NSLayoutConstraint constraintWithItem:self.friendStatusLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.friendStatusLabel
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.0f
                                                         constant:0.0f]
                           ]];
}

@end
