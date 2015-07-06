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

@implementation MPMessageComposerView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPMessageComposerView defaultSubtitle]];
    if(self) {
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
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
    self.titleField.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.titleField];
    
    self.bodyView = [[UITextView alloc] init];
    self.bodyView.layer.borderWidth = 1.0f;
    self.bodyView.layer.borderColor = [UIColor MPBlackColor].CGColor;
    self.bodyView.font = [UIFont fontWithName:@"Lato-Bold" size:15.0f];
    self.bodyView.textColor = [UIColor lightGrayColor];
    self.bodyView.text = @"ENTER YOUR MESSAGE HERE";
    self.bodyView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.bodyView];
    
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
