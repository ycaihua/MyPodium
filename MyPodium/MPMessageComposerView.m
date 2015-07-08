//
//  MPMessageComposerView.m
//  MyPodium
//
//  Created by Connor Neville on 7/6/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPLimitConstants.h"
#import "UIColor+MPColor.h"

#import "MPMessageComposerView.h"
#import "MPTextField.h"
#import "MPLabel.h"
#import "MPBottomEdgeButton.h"
#import "MPMenu.h"

@implementation MPMessageComposerView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPMessageComposerView defaultSubtitle]];
    if(self) {
        [self makeControls];
        [self bringSubviewToFront: self.menu];
        [self makeControlConstraints];
    }
    return self;
}

- (void) shiftVerticalConstraintsBy: (CGFloat) amount {
    for(NSLayoutConstraint* constraint in self.constraints) {
        if((constraint.firstAttribute == NSLayoutAttributeTop &&
            [constraint.firstItem isEqual: self.recipientsField]) ||
           (constraint.firstAttribute == NSLayoutAttributeBottom &&
            ([constraint.firstItem isEqual: self.cancelButton] ||
             [constraint.firstItem isEqual: self.sendButton])))
            constraint.constant += amount;
        if(constraint.firstAttribute == NSLayoutAttributeTop &&
           [constraint.firstItem isEqual: self.bodyView])
            [self removeConstraint: constraint];
    }
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.bodyView
                                  attribute:NSLayoutAttributeTop
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.menu
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1.0f
                                   constant:10.0f]];
}

- (void) restoreDefaultConstraints {
    for(NSLayoutConstraint* constraint in self.constraints) {
        if(constraint.firstAttribute == NSLayoutAttributeTop && [constraint.firstItem isEqual: self.recipientsField])
            constraint.constant = 10.0f;
        if(constraint.firstAttribute == NSLayoutAttributeBottom &&
           ([constraint.firstItem isEqual: self.cancelButton] ||
            [constraint.firstItem isEqual: self.sendButton]))
            constraint.constant = 0.0f;
        if(constraint.firstAttribute == NSLayoutAttributeTop &&
           [constraint.firstItem isEqual: self.bodyView])
            [self removeConstraint: constraint];
    }
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.bodyView
                                  attribute:NSLayoutAttributeTop
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.titleField
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1.0f
                                   constant:5.0f]];
}

- (void) makeControls {
    self.recipientsField = [[MPTextField alloc] initWithPlaceholder:@"RECIPIENTS"];
    self.recipientsField.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.recipientsField];
    
    self.recipientsLabel = [[MPLabel alloc] initWithText:[NSString stringWithFormat:@"Enter the names of the friends you wish to send a message to. Separate multiple users by commas. You can send a message to a maximum of %d friends at once.", [MPLimitConstants maxRecipientsPerMessage]]];
    self.recipientsLabel.textAlignment = NSTextAlignmentCenter;
    self.recipientsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.recipientsLabel];
    
    self.titleField = [[MPTextField alloc] initWithPlaceholder:@"TITLE"];
    self.titleField.clearButtonMode = UITextFieldViewModeNever;
    self.titleField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.titleField.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.titleField];
    
    self.titleLimitLabel = [[MPLabel alloc] initWithText:[NSString stringWithFormat:@"%d", [MPLimitConstants maxMessageTitleCharacters]]];
    self.titleLimitLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLimitLabel.textColor = [UIColor MPGreenColor];
    [self addSubview: self.titleLimitLabel];
    
    self.bodyView = [[UITextView alloc] init];
    self.bodyView.editable = YES;
    self.bodyView.selectable = YES;
    self.bodyView.layer.borderWidth = 1.0f;
    self.bodyView.layer.borderColor = [UIColor MPBlackColor].CGColor;
    self.bodyView.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
    self.bodyView.textColor = [UIColor MPBlackColor];
    self.bodyView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.bodyView];
    
    self.bodyLimitLabel = [[MPLabel alloc] initWithText:[NSString stringWithFormat:@"%d", [MPLimitConstants maxMessageBodyCharacters]]];
    self.bodyLimitLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.bodyLimitLabel.textColor = [UIColor MPGreenColor];
    [self addSubview: self.bodyLimitLabel];
    
    self.cancelButton = [[MPBottomEdgeButton alloc] init];
    [self.cancelButton setTitle:@"CANCEL" forState:UIControlStateNormal];
    self.cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.cancelButton];
    
    self.sendButton = [[MPBottomEdgeButton alloc] init];
    [self.sendButton setTitle:@"SEND" forState:UIControlStateNormal];
    self.sendButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.sendButton];
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.recipientsField
                           [NSLayoutConstraint constraintWithItem:self.recipientsField
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.recipientsField
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.recipientsField
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.menu
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:self.recipientsField
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardHeight]],
                           //self.recipientsLabel
                           [NSLayoutConstraint constraintWithItem:self.recipientsLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.recipientsLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.recipientsLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.recipientsField
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           //self.titleField
                           [NSLayoutConstraint constraintWithItem:self.titleField
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.titleField
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.titleField
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.recipientsLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.titleField
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardHeight]],
                           //self.titleLimitLabel
                           [NSLayoutConstraint constraintWithItem:self.titleLimitLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.titleField
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.titleLimitLabel
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.titleField
                                                        attribute:NSLayoutAttributeBottomMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.bodyView
                           [NSLayoutConstraint constraintWithItem:self.bodyView
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.bodyView
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.bodyView
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.titleField
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.bodyView
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.cancelButton
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:-10.0f],
                           //self.bodyLimitLabel
                           [NSLayoutConstraint constraintWithItem:self.bodyLimitLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.bodyView
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.bodyLimitLabel
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.bodyView
                                                        attribute:NSLayoutAttributeBottomMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.cancelButton
                           [NSLayoutConstraint constraintWithItem:self.cancelButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.cancelButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:-0.5f],
                           [NSLayoutConstraint constraintWithItem:self.cancelButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.cancelButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPBottomEdgeButton defaultHeight]],
                           //self.sendButton
                           [NSLayoutConstraint constraintWithItem:self.sendButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.5f],
                           [NSLayoutConstraint constraintWithItem:self.sendButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.sendButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.sendButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPBottomEdgeButton defaultHeight]],
                           ]];
}

+ (NSString*) defaultSubtitle { return @"Compose Message"; }

@end
