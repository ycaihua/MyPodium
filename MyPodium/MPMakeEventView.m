//
//  MPMakeEventView.m
//  MyPodium
//
//  Created by Connor Neville on 8/21/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"

#import "MPMakeEventView.h"
#import "MPFormView.h"
#import "MPEventNameView.h"
#import "MPEventTypeView.h"
#import "MPEventRuleView.h"
#import "MPEventParticipantsView.h"
#import "MPTextField.h"

@implementation MPMakeEventView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPMakeEventView defaultSubtitle]];
    if(self) {
        self.backgroundColor = [UIColor MPGrayColor];
        [self makeControls];
        [self makeControlConstraints];
        [self makeSlides];
        [self setFirstResponder];
    }
    return self;
}

- (void) makeControls {
    //self.form
    self.form = [[MPFormView alloc] init];
    self.form.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.form];
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.form
                           [NSLayoutConstraint constraintWithItem:self.form
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.menu
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:self.form
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.form
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.form
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f]
                           
                           ]];
}

- (void) makeSlides {
    self.form.slideViews = @[[[MPEventNameView alloc] init], [[MPEventTypeView alloc] init],
                             [[MPEventRuleView alloc] initWithEventType:MPEventTypeMatch],
                             [[MPEventParticipantsView alloc] init]];
    [self.form addSlideViews];
}

- (void) setFirstResponder {
    MPEventNameView* nameView = (MPEventNameView*)[self.form slideWithClass:[MPEventNameView class]];
    [nameView.nameField becomeFirstResponder];
}

+ (NSString*) defaultSubtitle { return @"Create Event"; }

@end
