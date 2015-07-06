//
//  MPMessageReaderView.m
//  MyPodium
//
//  Created by Connor Neville on 7/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPLabel.h"
#import "MPMessageReaderView.h"
#import "UIButton+MPImage.h"
#import "MPBottomEdgeButton.h"

#import <Parse/Parse.h>

@implementation MPMessageReaderView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPMessageReaderView defaultSubtitle]];
    if(self) {
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.titleLabel
    self.titleLabel = [[MPLabel alloc] initWithText:@"Message Title Displayed Here"];
    self.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:20.0f];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.titleLabel];
    
    //self.senderLabel
    self.senderLabel = [[MPLabel alloc] initWithText:@"From User1"];
    self.senderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.senderLabel];
    
    //self.receiverLabel
    self.receiverLabel = [[MPLabel alloc] initWithText:@"To User2"];
    self.receiverLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.receiverLabel];
    
    //self.timestampLabel
    self.timestampLabel = [[MPLabel alloc] initWithText:@"Timestamp label"];
    self.timestampLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
    self.timestampLabel.textAlignment = NSTextAlignmentRight;
    self.timestampLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.timestampLabel];
    
    //self.bodyView
    self.bodyView = [[UITextView alloc] init];
    self.bodyView.text = @"Body text.";
    self.bodyView.editable = NO;
    self.bodyView.font = [UIFont fontWithName:@"Lato-Regular" size:14.0f];
    self.bodyView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.bodyView];
    
    //self.deleteButton
    self.deleteButton = [[MPBottomEdgeButton alloc] init];
    [self.deleteButton setTitle:@"DELETE" forState:UIControlStateNormal];
    self.deleteButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.deleteButton];
    
    //self.replyButton
    self.replyButton = [[MPBottomEdgeButton alloc] init];
    [self.replyButton setTitle:@"REPLY" forState:UIControlStateNormal];
    self.replyButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.replyButton];
}

- (void) updateForMessage: (PFObject*) message {
    dispatch_async(dispatch_queue_create("MessageQueue", 0), ^{
        [message[@"sender"] fetchIfNeeded];
        [message[@"receiver"] fetchIfNeeded];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.titleLabel.text = message[@"title"];
            self.senderLabel.text = [NSString stringWithFormat:@"from %@", [(PFUser*)message[@"sender"] username]];
            self.receiverLabel.text = [NSString stringWithFormat:@"to %@", [(PFUser*)message[@"receiver"] username]];
            self.timestampLabel.text = [NSDateFormatter localizedStringFromDate:[message createdAt]
                                                                      dateStyle:NSDateFormatterShortStyle
                                                                      timeStyle:NSDateFormatterShortStyle];;
            self.bodyView.text = message[@"body"];
        });
    });
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.titleLabel
                           [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.menu
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.senderLabel
                           [NSLayoutConstraint constraintWithItem:self.senderLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.titleLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.senderLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.senderLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.timestampLabel
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.receiverLabel
                           [NSLayoutConstraint constraintWithItem:self.receiverLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.senderLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.receiverLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.receiverLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.timestampLabel
                           [NSLayoutConstraint constraintWithItem:self.timestampLabel
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.senderLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.timestampLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.bodyView
                           [NSLayoutConstraint constraintWithItem:self.bodyView
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.receiverLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
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
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.replyButton
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:-10.0f],
                           //self.deleteButton
                           [NSLayoutConstraint constraintWithItem:self.deleteButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.deleteButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.deleteButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:-0.5f],
                           [NSLayoutConstraint constraintWithItem:self.deleteButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPBottomEdgeButton defaultHeight]],
                           //self.replyButton
                           [NSLayoutConstraint constraintWithItem:self.replyButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.replyButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.5f],
                           [NSLayoutConstraint constraintWithItem:self.replyButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.replyButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPBottomEdgeButton defaultHeight]],
                           ]];
}

+ (NSString*) defaultSubtitle { return @"View Message"; }
@end
