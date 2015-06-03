//
//  MPFriendsCell.m
//  MyPodium
//
//  Created by Connor Neville on 6/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPFriendsCell.h"
#import "UIColor+MPColor.h"

@implementation MPFriendsCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self removeExistingSubviews];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
    
}

- (void) removeExistingSubviews {
    for(UIView* view in self.subviews) {
        [view removeFromSuperview];
    }
}

- (void) updateForUser:(PFUser *)user {
    [self.friendUsernameLabel setText: [user username]];
    if(user[@"realName"]) {
        [self.friendRealNameLabel setText: user[@"realName"]];
        for(NSLayoutConstraint *constraint in self.constraints) {
            if([constraint.firstItem isEqual: self.friendUsernameLabel] &&
               constraint.firstAttribute == NSLayoutAttributeCenterY)
                [self removeConstraint: constraint];
        }
        [self addConstraint:
         [NSLayoutConstraint constraintWithItem:self.friendUsernameLabel
                                      attribute:NSLayoutAttributeTop
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self.solidColorView
                                      attribute:NSLayoutAttributeTopMargin
                                     multiplier:1.0f
                                       constant:0.0f]];
    }
    else {
        [self.friendRealNameLabel setText:@""];
        for(NSLayoutConstraint *constraint in self.constraints) {
            if([constraint.firstItem isEqual: self.friendUsernameLabel] &&
               constraint.firstAttribute == NSLayoutAttributeTop)
                [self removeConstraint: constraint];
        }
        [self addConstraint:
         [NSLayoutConstraint constraintWithItem:self.friendUsernameLabel
                                      attribute:NSLayoutAttributeCenterY
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self.solidColorView
                                      attribute:NSLayoutAttributeCenterY
                                     multiplier:1.0f
                                       constant:0.0f]];
    }
}

- (void) updateForIncomingRequest {
    UIImage* check = [UIImage imageNamed:@"button_check_green60.png"];
    [self.greenButton setImage: check forState:UIControlStateNormal];
}

- (void) updateForFriendOrOutgoingRequest {
    UIImage* info = [UIImage imageNamed:@"button_info_green60.png"];
    [self.greenButton setImage: info forState:UIControlStateNormal];
}

- (void) makeControls {
    //self.solidColorView
    self.solidColorView = [[UIView alloc] init];
    self.solidColorView.backgroundColor = [UIColor whiteColor];
    self.solidColorView.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview: self.solidColorView];
    
    //self.bottomBorder
    self.bottomBorder = [[UIView alloc] init];
    self.bottomBorder.backgroundColor = [UIColor MPDarkGrayColor];
    self.bottomBorder.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self.solidColorView addSubview: self.bottomBorder];
    
    //self.leadingBorder
    self.leadingBorder = [[UIView alloc] init];
    self.leadingBorder.backgroundColor = [UIColor MPYellowColor];
    self.leadingBorder.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self.solidColorView addSubview: self.leadingBorder];
    
    //self.friendUsernameLabel
    self.friendUsernameLabel = [[CNLabel alloc] initWithText:@"username"];
    self.friendUsernameLabel.font = [UIFont fontWithName:@"Lato-Bold" size:16.0f];
    self.friendUsernameLabel.textColor = [UIColor MPBlackColor];
    self.friendUsernameLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self.solidColorView addSubview: self.friendUsernameLabel];
    
    //self.friendRealNameLabel
    self.friendRealNameLabel = [[CNLabel alloc] initWithText:@""];
    self.friendRealNameLabel.font = [UIFont fontWithName:@"Lato-Regular" size:11.0f];
    self.friendRealNameLabel.textColor = [UIColor MPBlackColor];
    self.friendRealNameLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self.solidColorView addSubview: self.friendRealNameLabel];
    
    //self.redButton
    UIImage* minus = [UIImage imageNamed:@"button_minus_red60.png"];
    self.redButton = [[MPFriendsButton alloc] init];
    [self.redButton setImage: minus forState:UIControlStateNormal];
    self.redButton.backgroundColor = [UIColor MPRedColor];
    self.redButton.contentMode = UIViewContentModeCenter;
    self.redButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.redButton];
    
    //self.greenButton
    UIImage* info = [UIImage imageNamed:@"button_info_green60.png"];
    self.greenButton = [[MPFriendsButton alloc] init];
    [self.greenButton setImage: info forState:UIControlStateNormal];
    self.greenButton.backgroundColor = [UIColor MPGreenColor];
    self.redButton.contentMode = UIViewContentModeCenter;
    self.greenButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.greenButton];
}
- (void) makeControlConstraints {
    [self addConstraints:@[//self.solidColorView
                           [NSLayoutConstraint constraintWithItem:self.solidColorView
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.solidColorView
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.solidColorView
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTopMargin
                                                       multiplier:1.0f
                                                         constant:4.0f],
                           [NSLayoutConstraint constraintWithItem:self.solidColorView
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottomMargin
                                                       multiplier:1.0f
                                                         constant:4.0f],
                           //self.bottomBorder
                           [NSLayoutConstraint constraintWithItem:self.bottomBorder
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.solidColorView
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.bottomBorder
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.solidColorView
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.bottomBorder
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.solidColorView
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.bottomBorder
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:1.0f],
                           //self.leadingBorder
                           [NSLayoutConstraint constraintWithItem:self.leadingBorder
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.solidColorView
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.leadingBorder
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:2.0f],
                           [NSLayoutConstraint constraintWithItem:self.leadingBorder
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.solidColorView
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.leadingBorder
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.bottomBorder
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.friendUsernameLabel
                           [NSLayoutConstraint constraintWithItem:self.friendUsernameLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.leadingBorder
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           //Will be removed if a user's real name is specified
                           [NSLayoutConstraint constraintWithItem:self.friendUsernameLabel
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.solidColorView
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.friendRealNameLabel
                           [NSLayoutConstraint constraintWithItem:self.friendRealNameLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.leadingBorder
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.friendRealNameLabel
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.solidColorView
                                                        attribute:NSLayoutAttributeBottomMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.redButton
                           [NSLayoutConstraint constraintWithItem:self.redButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.solidColorView
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.redButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.solidColorView
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.redButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.solidColorView
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.redButton
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.redButton
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.greenButton
                           [NSLayoutConstraint constraintWithItem:self.greenButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.redButton
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.greenButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.solidColorView
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.greenButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.solidColorView
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.greenButton
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.greenButton
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:1.0f
                                                         constant:0.0f]
                           ]];
}

+ (CGFloat) cellHeight { return 60.0f; }

@end