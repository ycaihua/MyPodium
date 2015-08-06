//
//  MPRegisterPasswordView.m
//  MyPodium
//
//  Created by Connor Neville on 8/6/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPLimitConstants.h"

#import "MPRegisterPasswordView.h"
#import "MPLabel.h"
#import "MPTextField.h"

@implementation MPRegisterPasswordView

- (id) init {
    self = [super init];
    if(self) {
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.titleLabel
    self.titleLabel = [[MPLabel alloc] initWithText:@"PASSWORD"];
    self.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.titleLabel];
    
    //self.passwordLabel
    self.passwordLabel = [[MPLabel alloc] initWithText:[NSString stringWithFormat:@"You will need a password to log in. Enter it below. %d-%d characters, all characters allowed.", [MPLimitConstants minPasswordCharacters], [MPLimitConstants maxPasswordCharacters]]];
    self.passwordLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.passwordLabel];
    
    //self.passwordField
    self.passwordField = [[MPTextField alloc] initWithPlaceholder:@"PASSWORD"];
    self.passwordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.passwordField.returnKeyType = UIReturnKeyNext;
    self.passwordField.secureTextEntry = YES;
    self.passwordField.clearButtonMode = UITextFieldViewModeNever;
    self.confirmPasswordField.clearsOnBeginEditing = YES;
    self.passwordField.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.passwordField];
    
    //self.confirmLabel
    self.confirmLabel = [[MPLabel alloc] initWithText:@"Re-enter your desired password below to confirm it."];
    self.confirmLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.confirmLabel];
    
    //self.confirmPasswordField
    self.confirmPasswordField = [[MPTextField alloc] initWithPlaceholder:@"CONFIRM PASSWORD"];
    self.confirmPasswordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.confirmPasswordField.returnKeyType = UIReturnKeyGo;
    self.confirmPasswordField.secureTextEntry = YES;
    self.confirmPasswordField.clearButtonMode = UITextFieldViewModeNever;
    self.confirmPasswordField.clearsOnBeginEditing = YES;
    self.confirmPasswordField.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.confirmPasswordField];
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
                           //self.passwordLabel
                           [NSLayoutConstraint constraintWithItem:self.passwordLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.passwordLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.passwordLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.titleLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           //self.passwordField
                           [NSLayoutConstraint constraintWithItem:self.passwordField
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.passwordField
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.passwordLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:self.passwordField
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardWidth]],
                           [NSLayoutConstraint constraintWithItem:self.passwordField
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardHeight]],
                           //self.confirmLabel
                           [NSLayoutConstraint constraintWithItem:self.confirmLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.confirmLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.confirmLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.passwordField
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           //self.confirmPasswordField
                           [NSLayoutConstraint constraintWithItem:self.confirmPasswordField
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.confirmPasswordField
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.confirmLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.confirmPasswordField
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardWidth]],
                           [NSLayoutConstraint constraintWithItem:self.confirmPasswordField
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardHeight]]
                           ]];
    
}

- (void) adjustForKeyboardShowing: (BOOL) keyboardShowing {
    for(NSLayoutConstraint* constraint in self.constraints) {
        if([constraint.firstItem isEqual: self.confirmLabel] &&
           constraint.firstAttribute == NSLayoutAttributeTop) {
            [self removeConstraint: constraint];
            break;
        }
    }
    if(keyboardShowing) {
        for(UIView* view in @[self.passwordLabel, self.passwordField]) {
            view.hidden = YES;
        }
        [self addConstraint:
         [NSLayoutConstraint constraintWithItem:self.confirmLabel
                                      attribute:NSLayoutAttributeTop
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self.titleLabel
                                      attribute:NSLayoutAttributeBottom
                                     multiplier:1.0f
                                       constant:5.0f]];
    }
    else {
        [self addConstraint:
         [NSLayoutConstraint constraintWithItem:self.confirmLabel
                                      attribute:NSLayoutAttributeTop
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self.passwordField
                                      attribute:NSLayoutAttributeBottom
                                     multiplier:1.0f
                                       constant:5.0f]];
        
    }
    [self setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.75f animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if(!keyboardShowing){
            for(UIView* view in @[self.passwordLabel, self.passwordField]) {
                view.hidden = NO;
            }
        }
    }];
}

@end