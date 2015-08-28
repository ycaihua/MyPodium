//
//  MPEventRuleView.h
//  MyPodium
//
//  Created by Connor Neville on 8/24/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"

#import "MPEventRuleView.h"
#import "MPLabel.h"

@implementation MPEventRuleView

- (id) initWithEventType: (MPEventType) eventType {
    self = [super init];
    if(self) {
        [self makeControls];
        [self makeControlConstraints];
        [self updateForEventType: eventType];
    }
    return self;
}

- (void) makeControls {
    //self.titleLabel
    self.titleLabel = [[MPLabel alloc] initWithText:@"SELECT RULE"];
    self.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.titleLabel];
    
    //self.infoLabel
    self.infoLabel = [[MPLabel alloc] initWithText:@"Every event needs a set of rules to go by. Select one below from your rules."];
    self.infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.infoLabel];
    
    //self.warningLabel
    self.warningLabel = [[MPLabel alloc] initWithText:@""];
    self.warningLabel.textColor = [UIColor MPRedColor];
    self.warningLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.warningLabel];
    
    //self.rulesTable
    self.rulesTable = [[UITableView alloc] init];
    self.rulesTable.backgroundColor = [UIColor clearColor];
    self.rulesTable.translatesAutoresizingMaskIntoConstraints = NO;
    self.rulesTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rulesTable.scrollEnabled = YES;
    self.rulesTable.allowsSelection = YES;
    self.rulesTable.allowsMultipleSelection = NO;
    [self addSubview: self.rulesTable];
    
    //self.makeRuleButton
    self.makeRuleButton = [[UIButton alloc] init];
    self.makeRuleButton.backgroundColor = [UIColor MPGreenColor];
    [self.makeRuleButton setTitle:@"NEW RULE" forState:UIControlStateNormal];
    [self.makeRuleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.makeRuleButton setTitleColor:[UIColor MPBlackColor] forState:UIControlStateHighlighted];
    self.makeRuleButton.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    [self.makeRuleButton setImage:[UIImage imageNamed:@"plus_green.png"] forState:UIControlStateNormal];
    [self.makeRuleButton setImage:[UIImage imageNamed:@"plus_green.png"] forState:UIControlStateHighlighted];
    self.makeRuleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.makeRuleButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.makeRuleButton];
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.titleLabel
                           [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.infoLabel
                           [NSLayoutConstraint constraintWithItem:self.infoLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.infoLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.infoLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.titleLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           //self.warningLabel
                           [NSLayoutConstraint constraintWithItem:self.warningLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.warningLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.warningLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.infoLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           //self.rulesTable
                           [NSLayoutConstraint constraintWithItem:self.rulesTable
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.rulesTable
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.rulesTable
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.warningLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.rulesTable
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.makeRuleButton
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:-5.0f],
                           
                           //self.makeRuleButton
                           [NSLayoutConstraint constraintWithItem:self.makeRuleButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.makeRuleButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.makeRuleButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.rulesTable
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.makeRuleButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottomMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           ]];
}

- (void) updateForEventType: (MPEventType) eventType {
    if(eventType == MPEventTypeLeague) {
        self.warningLabel.text = @"Please note that since you chose a league as your event type, you can only use rules that have 2 participants per match.";
    }
    else if(eventType == MPEventTypeTournament) {
        self.warningLabel.text = @"Please note that since you chose a tournament as your event type, you can only use rules that have 2 participants per match.";
    }
    else {
        self.warningLabel.text = @"";
    }
}
@end
