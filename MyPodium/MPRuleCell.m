//
//  MPRuleCell.m
//  MyPodium
//
//  Created by Connor Neville on 6/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"
#import "UIButton+MPImage.h"

#import "MPRuleCell.h"
#import "MPLabel.h"

@implementation MPRuleCell

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

- (void) updateForRule:(PFObject *)rule {
    [self.modeNameLabel setText: rule[@"name"]];
    BOOL teamParticipants = [rule[@"usesTeamParticipants"] boolValue];
    if(teamParticipants)
        self.modeDetailsLabel.text = @"Team vs. team";
    else
        self.modeDetailsLabel.text = @"Player vs. player";
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
    
    //self.modeNameLabel
    self.modeNameLabel = [[MPLabel alloc] initWithText:@"mode name"];
    self.modeNameLabel.font = [UIFont fontWithName:@"Lato-Bold" size:16.0f];
    self.modeNameLabel.textColor = [UIColor MPBlackColor];
    self.modeNameLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    self.modeNameLabel.numberOfLines = 1;
    self.modeNameLabel.adjustsFontSizeToFitWidth = NO;
    self.modeNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.solidColorView addSubview: self.modeNameLabel];
    
    //self.modeDetailsLabel
    self.modeDetailsLabel = [[MPLabel alloc] initWithText:@"details"];
    self.modeDetailsLabel.font = [UIFont fontWithName:@"Lato-Bold" size:11.0f];
    self.modeDetailsLabel.textColor = [UIColor MPBlackColor];
    self.modeDetailsLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    self.modeDetailsLabel.numberOfLines = 1;
    self.modeDetailsLabel.adjustsFontSizeToFitWidth = NO;
    self.modeDetailsLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.solidColorView addSubview: self.modeDetailsLabel];
    
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
                                                         constant:[MPRuleCell cellContentHeight]],
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
                           //self.modeNameLabel
                           [NSLayoutConstraint constraintWithItem:self.modeNameLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.leadingBorder
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.modeNameLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationLessThanOrEqual
                                                           toItem:self.leftButton
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.modeNameLabel
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.solidColorView
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.modeDetailsLabel
                           [NSLayoutConstraint constraintWithItem:self.modeDetailsLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.leadingBorder
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.modeDetailsLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationLessThanOrEqual
                                                           toItem:self.leftButton
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.modeDetailsLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.modeNameLabel
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
                           [NSLayoutConstraint constraintWithItem:self.modeNameLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationLessThanOrEqual
                                                           toItem:self.leftButton
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.modeNameLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationLessThanOrEqual
                                                           toItem:self.leftButton
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],]];
    self.leftButton.alpha = 1.0f;
}

- (void) hideLeftButton {
    for(NSLayoutConstraint* constraint in self.constraints) {
        if(constraint.firstAttribute == NSLayoutAttributeTrailing &&
           constraint.relation == NSLayoutRelationLessThanOrEqual)
            [self removeConstraint: constraint];
    }
    [self addConstraints:@[
                           [NSLayoutConstraint constraintWithItem:self.modeNameLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationLessThanOrEqual
                                                           toItem:self.centerButton
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.modeNameLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationLessThanOrEqual
                                                           toItem:self.centerButton
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],]];
    self.leftButton.alpha = 0.0f;
}

+ (CGFloat) cellHeight { return 60.0f; }
+ (CGFloat) cellContentHeight { return 45.0f; }

@end