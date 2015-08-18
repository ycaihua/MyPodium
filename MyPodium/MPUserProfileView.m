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
#import "MPBottomEdgeButton.h"
#import "MPProfileControlBlock.h"

#import <Parse/Parse.h>

@implementation MPUserProfileView

- (id) initWithUser: (PFUser*) user withStatus: (MPFriendStatus) status acceptingRequests:(BOOL)acceptingRequests {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText: [MPUserProfileView defaultSubtitle]];
    if(self) {
            self.displayedUser = user;
            self.userStatus = status;
            self.userAcceptingRequests = acceptingRequests;
            self.backgroundColor = [UIColor whiteColor];
            [self makeControls];
            [self makeControlConstraints];
            [self refreshControlsForUser];
    }
    return self;
}

- (void) makeControls {
    //self.usernameLabel
    self.usernameLabel = [[MPLabel alloc] initWithText: self.displayedUser.username.uppercaseString];
    self.usernameLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.usernameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.usernameLabel];
    
    //self.realNameLabel
    self.realNameLabel = [[MPLabel alloc] initWithText: @"Display name not available"];
    if((self.userStatus == MPFriendStatusFriends || MPFriendStatusSameUser) && self.displayedUser[@"realName"]) {
        self.realNameLabel.text = self.displayedUser[@"realName"];
    }
    self.realNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.realNameLabel];
    
    //self.creationDateLabel
    self.creationDateLabel = [[MPLabel alloc] initWithText:
                              [NSString stringWithFormat:@"Joined %@",
                               [NSDateFormatter localizedStringFromDate:[self.displayedUser createdAt]
                                                             dateStyle:NSDateFormatterShortStyle
                                                             timeStyle:NSDateFormatterShortStyle]]];
    self.creationDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.creationDateLabel];
    
    //self.friendStatusLabel
    self.friendStatusLabel = [[MPLabel alloc] init];
    self.friendStatusLabel.numberOfLines = 0;
    self.friendStatusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.friendStatusLabel];
    
    //self.controlBlock
    self.controlBlock = [[MPProfileControlBlock alloc] init];
    self.controlBlock.layer.cornerRadius = 10.0f;
    self.controlBlock.clipsToBounds = YES;
    self.controlBlock.translatesAutoresizingMaskIntoConstraints = NO;
    self.controlBlock.hidden = YES;
    [self addSubview: self.controlBlock];
    
    //self.leftBottomButton
    self.leftBottomButton = [[MPBottomEdgeButton alloc] init];
    [self.leftBottomButton setTitle:@"Left" forState:UIControlStateNormal];
    self.leftBottomButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.leftBottomButton];
    
    //self.rightBottomButton
    self.rightBottomButton = [[MPBottomEdgeButton alloc] init];
    [self.rightBottomButton setTitle:@"Right" forState:UIControlStateNormal];
    self.rightBottomButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.rightBottomButton];
}

- (void) refreshControlsForUser {
    self.usernameLabel.text = self.displayedUser.username.uppercaseString;
    self.realNameLabel.text = @"Display name not available";
    if((self.userStatus == MPFriendStatusFriends || self.userStatus == MPFriendStatusSameUser) && self.displayedUser[@"realName"]) {
        self.realNameLabel.text = self.displayedUser[@"realName"];
    }
    self.creationDateLabel.text = [NSString stringWithFormat:@"Joined %@",
                                   [NSDateFormatter localizedStringFromDate:[self.displayedUser createdAt]
                                                                  dateStyle:NSDateFormatterShortStyle
                                                                  timeStyle:NSDateFormatterShortStyle]];
    switch (self.userStatus) {
        case MPFriendStatusFriends:
            self.friendStatusLabel.text = [NSString stringWithFormat:@"You are friends with %@.", self.displayedUser.username];
            [self.leftBottomButton setTitle:@"GO BACK" forState:UIControlStateNormal];
            [self.rightBottomButton setTitle:@"REMOVE FRIEND" forState:UIControlStateNormal];
            self.controlBlock.hidden = NO;
            [self.controlBlock setButtonTitles:@[@"SEND MESSAGE", @"NEW TEAM", @"NEW EVENT", @"VIEW STATS"]];
            break;
        case MPFriendStatusNotFriends:
            self.friendStatusLabel.text = [NSString stringWithFormat:@"You are not currently friends. If you know %@, send this user a friend request.", self.displayedUser.username];
            [self.leftBottomButton setTitle:@"GO BACK" forState:UIControlStateNormal];
            [self.rightBottomButton setTitle:@"ADD FRIEND" forState:UIControlStateNormal];
            self.controlBlock.hidden = YES;
            break;
        case MPFriendStatusIncomingPending:
            self.friendStatusLabel.text = @"You have an incoming friend request from this user.";
            [self.leftBottomButton setTitle:@"GO BACK" forState:UIControlStateNormal];
            [self.rightBottomButton setTitle:@"ACCEPT/DENY" forState:UIControlStateNormal];
            self.controlBlock.hidden = YES;
            break;
        case MPFriendStatusOutgoingPending:
            self.friendStatusLabel.text = @"You have sent this user a request. Until he or she accepts it, you cannot see more details about this user.";
            [self.leftBottomButton setTitle:@"GO BACK" forState:UIControlStateNormal];
            [self.rightBottomButton setTitle:@"CANCEL REQUEST" forState:UIControlStateNormal];
            self.controlBlock.hidden = YES;
            break;
        case MPFriendStatusSameUser:
            self.friendStatusLabel.text = @"This is your profile page.";
            [self.leftBottomButton setTitle:@"GO BACK" forState:UIControlStateNormal];
            [self.rightBottomButton setTitle:@"MY SETTINGS" forState:UIControlStateNormal];
            self.controlBlock.hidden = YES;
            break;
        default:
            break;
    }
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.usernameLabel
                           [NSLayoutConstraint constraintWithItem:self.usernameLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.usernameLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.usernameLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.menu
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           //self.realNameLabel
                           [NSLayoutConstraint constraintWithItem:self.realNameLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:self.realNameLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.realNameLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.usernameLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           //self.creationDateLabel
                           [NSLayoutConstraint constraintWithItem:self.creationDateLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:self.creationDateLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.creationDateLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.realNameLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           //self.friendStatusLabel
                           [NSLayoutConstraint constraintWithItem:self.friendStatusLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.friendStatusLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.friendStatusLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.creationDateLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           //self.controlBlock
                           [NSLayoutConstraint constraintWithItem:self.controlBlock
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.controlBlock
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeWidth
                                                       multiplier:0.75f
                                                         constant:1.0f],
                           [NSLayoutConstraint constraintWithItem:self.controlBlock
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.friendStatusLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:25.0f],
                           [NSLayoutConstraint constraintWithItem:self.controlBlock
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.leftBottomButton
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:-25.0f],
                           //self.leftBottomButton
                           [NSLayoutConstraint constraintWithItem:self.leftBottomButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.leftBottomButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:-0.5f],
                           [NSLayoutConstraint constraintWithItem:self.leftBottomButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.leftBottomButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPBottomEdgeButton defaultHeight]],
                           //self.rightBottomButton
                           [NSLayoutConstraint constraintWithItem:self.rightBottomButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.5f],
                           [NSLayoutConstraint constraintWithItem:self.rightBottomButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.rightBottomButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.rightBottomButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPBottomEdgeButton defaultHeight]]
                           ]];
}

+ (NSString*) defaultSubtitle { return @"User Profile"; }

@end
