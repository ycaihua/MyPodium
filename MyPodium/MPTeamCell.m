//
//  MPTeamCell.m
//  MyPodium
//
//  Created by Connor Neville on 6/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"
#import "UIButton+MPImage.h"

#import "MPTeamCell.h"
#import "MPLabel.h"

@implementation MPTeamCell

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

- (void) updateForTeam:(PFObject *)team {
    [self.teamNameLabel setText: team[@"teamName"]];
    [team[@"creator"] fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        PFUser* creator = (PFUser*)object;
        [self.teamOwnerLabel setText: [NSString stringWithFormat:@"owner: %@", creator.username]];
    }];
    NSArray* members = team[@"teamMembers"];
    [self.numPlayersLabel setText:[NSString stringWithFormat:@"%lu players", (unsigned long)members.count]];
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
    
    //self.teamNameLabel
    self.teamNameLabel = [[MPLabel alloc] initWithText:@"team name"];
    self.teamNameLabel.font = [UIFont fontWithName:@"Lato-Bold" size:16.0f];
    self.teamNameLabel.textColor = [UIColor MPBlackColor];
    self.teamNameLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    self.teamNameLabel.numberOfLines = 1;
    self.teamNameLabel.adjustsFontSizeToFitWidth = NO;
    self.teamNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.solidColorView addSubview: self.teamNameLabel];
    
    //self.teamOwnerLabel
    self.teamOwnerLabel = [[MPLabel alloc] initWithText:@"owner"];
    self.teamOwnerLabel.font = [UIFont fontWithName:@"Lato-Bold" size:11.0f];
    self.teamOwnerLabel.textColor = [UIColor MPBlackColor];
    self.teamOwnerLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    self.teamOwnerLabel.numberOfLines = 1;
    self.teamOwnerLabel.adjustsFontSizeToFitWidth = NO;
    self.teamOwnerLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.solidColorView addSubview: self.teamOwnerLabel];
    
    //self.numPlayersLabel
    self.numPlayersLabel = [[MPLabel alloc] initWithText:@"0 players"];
    self.numPlayersLabel.font = [UIFont fontWithName:@"Lato-Regular" size:11.0f];
    self.numPlayersLabel.textColor = [UIColor MPBlackColor];
    self.numPlayersLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self.solidColorView addSubview: self.numPlayersLabel];
    
    //self.rightButton
    self.rightButton = [[UIButton alloc] init];
    [self.rightButton setImageString:@"x" withColorString:@"red" withHighlightedColorString:@"black"];
    self.rightButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.rightButton];
    
    //self.centerButton
    self.centerButton = [[UIButton alloc] init];
    [self.centerButton setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
    self.centerButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.centerButton];
    
    //self.leftButton
    self.leftButton = [[UIButton alloc] init];
    [self.leftButton setImageString:@"check" withColorString:@"green" withHighlightedColorString:@"black"];
    self.leftButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.leftButton];
    [self hideLeftButton];
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
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTeamCell cellContentHeight]],
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
                           //self.teamNameLabel
                           [NSLayoutConstraint constraintWithItem:self.teamNameLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.leadingBorder
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.teamNameLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationLessThanOrEqual
                                                           toItem:self.leftButton
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.teamNameLabel
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.solidColorView
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.teamOwnerLabel
                           [NSLayoutConstraint constraintWithItem:self.teamOwnerLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.leadingBorder
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.teamOwnerLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationLessThanOrEqual
                                                           toItem:self.leftButton
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.teamOwnerLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.teamNameLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.numPlayersLabel
                           [NSLayoutConstraint constraintWithItem:self.numPlayersLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.centerButton
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:-5.0f],
                           [NSLayoutConstraint constraintWithItem:self.numPlayersLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.teamNameLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.rightButton
                           [NSLayoutConstraint constraintWithItem:self.rightButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.solidColorView
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.rightButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.solidColorView
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.rightButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.solidColorView
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.rightButton
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.rightButton
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.centerButton
                           [NSLayoutConstraint constraintWithItem:self.centerButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.rightButton
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.centerButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.solidColorView
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.centerButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.solidColorView
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.centerButton
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.centerButton
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.leftButton
                           [NSLayoutConstraint constraintWithItem:self.leftButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.centerButton
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.leftButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.solidColorView
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.leftButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.solidColorView
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.leftButton
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.leftButton
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:1.0f
                                                         constant:0.0f]
                           ]];
}

- (void) showLeftButton {
    for(NSLayoutConstraint* constraint in self.constraints) {
        if(constraint.firstAttribute == NSLayoutAttributeTrailing &&
           constraint.relation == NSLayoutRelationLessThanOrEqual)
            [self removeConstraint: constraint];
    }
    [self addConstraints:@[
     [NSLayoutConstraint constraintWithItem:self.teamNameLabel
                                  attribute:NSLayoutAttributeTrailing
                                  relatedBy:NSLayoutRelationLessThanOrEqual
                                     toItem:self.leftButton
                                  attribute:NSLayoutAttributeLeading
                                 multiplier:1.0f
                                   constant:0.0f],
     [NSLayoutConstraint constraintWithItem:self.teamOwnerLabel
                                  attribute:NSLayoutAttributeTrailing
                                  relatedBy:NSLayoutRelationLessThanOrEqual
                                     toItem:self.leftButton
                                  attribute:NSLayoutAttributeLeading
                                 multiplier:1.0f
                                   constant:0.0f],]];
    self.leftButton.alpha = 1.0f;
    self.numPlayersLabel.alpha = 0.0f;
}

- (void) hideLeftButton {
    for(NSLayoutConstraint* constraint in self.constraints) {
        if(constraint.firstAttribute == NSLayoutAttributeTrailing &&
           constraint.relation == NSLayoutRelationLessThanOrEqual)
            [self removeConstraint: constraint];
    }
    [self addConstraints:@[
                           [NSLayoutConstraint constraintWithItem:self.teamNameLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationLessThanOrEqual
                                                           toItem:self.centerButton
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.teamOwnerLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationLessThanOrEqual
                                                           toItem:self.numPlayersLabel
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],]];
    self.leftButton.alpha = 0.0f;
    self.numPlayersLabel.alpha = 1.0f;
}

+ (CGFloat) cellHeight { return 60.0f; }
+ (CGFloat) cellContentHeight { return 45.0f; }

@end