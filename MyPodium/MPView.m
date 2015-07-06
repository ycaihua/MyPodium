//
//  MPView.m
//  MyPodium
//
//  Base class for all views in MyPodium,
//  containing any subviews or behaviors used in
//  all other view subclasses.
//
//  Created by Connor Neville on 5/14/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPView.h"

@implementation MPView

- (id) init {
    self = [super init];
    if(self) {
        [self createResponderButton];
    }
    return self;
}

- (void) createResponderButton {
    self.responderButton = [[UIButton alloc] init];
    self.responderButton.backgroundColor = [UIColor clearColor];
    self.responderButton.titleLabel.text = @"";
    self.responderButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview: self.responderButton];
    [self sendSubviewToBack:self.responderButton];
    [self createResponderButtonConstraints];
    [self.responderButton addTarget:self action:@selector(responderButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) createResponderButtonConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.responderButton
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.responderButton
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.responderButton
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.responderButton
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0f
                                                           constant:0.0f]
                             ];
    [self addConstraints: constraints];
}

//Button event: for all subviews, if they
//are a textfield, resign first responder.
- (void)responderButtonPressed:(id)sender {
    [MPView resignRespondersForSubviews: self];
}

+ (void) resignRespondersForSubviews: (UIView*) view {
    for(UIView* subview in view.subviews) {
        if ([subview isKindOfClass:[UITextField class]] ||
            [subview isKindOfClass:[UITextView class]]) {
            //Resign first responder
            UITextField* currentField = (UITextField*) subview;
            [currentField resignFirstResponder];
        }
        else if([subview isKindOfClass:[UIView class]]) {
            //Recursive call
            [MPView resignRespondersForSubviews: subview];
        }
    }
}

@end
