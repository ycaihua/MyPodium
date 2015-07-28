//
//  MPMakeRuleView.m
//  MyPodium
//
//  Created by Connor Neville on 7/22/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPLabel.h"
#import "MPTextField.h"
#import "MPMakeRuleView.h"
#import "MPMakeRuleSubviews.h"
#import "MPRuleNameView.h"
#import "MPRuleParticipantView.h"
#import "MPBottomEdgeButton.h"

@implementation MPMakeRuleView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPMakeRuleView defaultSubtitle]];
    if(self) {
        self.subviewIndex = 0;
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.ruleSubviews
    self.ruleSubviews = @[[[MPRuleNameView alloc] init], [[MPRuleParticipantView alloc] init], [MPMakeRuleSubviews statView]];
    for(MPView* view in self.ruleSubviews) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview: view];
    }
    
    //self.previousButton
    self.previousButton = [[MPBottomEdgeButton alloc] init];
    [self.previousButton setTitle:@"CANCEL" forState:UIControlStateNormal];
    self.previousButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.previousButton];
    
    //self.nextButton
    self.nextButton = [[MPBottomEdgeButton alloc] init];
    [self.nextButton setTitle:@"NEXT" forState:UIControlStateNormal];
    self.nextButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.nextButton];
}

- (void) makeControlConstraints {
    for(int i = 0; i < self.ruleSubviews.count; i++) {
        //Constraints common to all subviews
        [self addConstraints:@[[NSLayoutConstraint constraintWithItem:self.ruleSubviews[i]
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.menu
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1.0f
                                                             constant:10.0f],
                               [NSLayoutConstraint constraintWithItem:self.ruleSubviews[i]
                                                            attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.previousButton
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1.0f
                                                             constant:-10.0f],
                               [NSLayoutConstraint constraintWithItem:self.ruleSubviews[i]
                                                            attribute:NSLayoutAttributeWidth
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeWidth
                                                           multiplier:1.0f
                                                             constant:-32.0f],
                               ]];
        if(i == 0)
            [self addConstraint:
             [NSLayoutConstraint constraintWithItem:self.ruleSubviews[i]
                                          attribute:NSLayoutAttributeLeading
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:self
                                          attribute:NSLayoutAttributeLeadingMargin
                                         multiplier:1.0f
                                           constant:0.0f]];
        else
            [self addConstraint:
             [NSLayoutConstraint constraintWithItem:self.ruleSubviews[i]
                                          attribute:NSLayoutAttributeLeading
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:self.ruleSubviews[i-1]
                                          attribute:NSLayoutAttributeTrailing
                                         multiplier:1.0f
                                           constant:16.0f]];
        if(i < (self.ruleSubviews.count - 1))
            [self addConstraint:
             [NSLayoutConstraint constraintWithItem:self.ruleSubviews[i]
                                          attribute:NSLayoutAttributeTrailing
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:self.ruleSubviews[i+1]
                                          attribute:NSLayoutAttributeLeading
                                         multiplier:1.0f
                                           constant:-16.0f]];
            
    }
    [self addConstraints:@[//self.previousButton
                           [NSLayoutConstraint constraintWithItem:self.previousButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.previousButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.previousButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:-0.5f],
                           [NSLayoutConstraint constraintWithItem:self.previousButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPBottomEdgeButton defaultHeight]],
                           //self.nextButton
                           [NSLayoutConstraint constraintWithItem:self.nextButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.nextButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.5f],
                           [NSLayoutConstraint constraintWithItem:self.nextButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.nextButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPBottomEdgeButton defaultHeight]],
                           ]];
}

- (void) advanceToNextSubview {
    for(NSLayoutConstraint* constraint in self.constraints) {
        if([constraint.secondItem isEqual: self] &&
           constraint.secondAttribute == NSLayoutAttributeLeadingMargin) {
            [self removeConstraint: constraint];
            break;
        }
    }
    self.subviewIndex++;
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.ruleSubviews[self.subviewIndex]
                                  attribute:NSLayoutAttributeLeading
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeLeadingMargin
                                 multiplier:1.0f
                                   constant:0.0f]];
    
    [self setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.75f animations:^{
        [self layoutIfNeeded];
    }];
}

- (void) returnToLastSubview {
    for(NSLayoutConstraint* constraint in self.constraints) {
        if([constraint.secondItem isEqual: self] &&
           constraint.secondAttribute == NSLayoutAttributeLeadingMargin) {
            [self removeConstraint: constraint];
            break;
        }
    }
    self.subviewIndex--;
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.ruleSubviews[self.subviewIndex]
                                  attribute:NSLayoutAttributeLeading
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeLeadingMargin
                                 multiplier:1.0f
                                   constant:0.0f]];
    
    [self setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.75f animations:^{
        [self layoutIfNeeded];
    }];
}

- (void) adjustStatSubviewForKeyboardShowing: (BOOL) keyboardShowing withField: (MPTextField*) field {
    NSInteger tagNumber = field.tag;
    MPView* superview = (MPView*)field.superview;
    for(NSLayoutConstraint* constraint in superview.constraints) {
        if([constraint.firstItem isEqual: field] &&
           constraint.firstAttribute == NSLayoutAttributeTop) {
            [superview removeConstraint: constraint];
            break;
        }
    }
    if(keyboardShowing) {
        for(int i = 2; i < tagNumber; i++) {
            [superview viewWithTag:i].hidden = YES;
        }
        MPLabel* titleLabel = (MPLabel*)[superview viewWithTag:1];
        [superview addConstraint:
         [NSLayoutConstraint constraintWithItem:field
                                      attribute:NSLayoutAttributeTop
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:titleLabel
                                      attribute:NSLayoutAttributeBottom
                                     multiplier:1.0f
                                       constant:5.0f]];
    }
    else {
        UIView* previousView = [superview viewWithTag:tagNumber-1];
        [superview addConstraint:
         [NSLayoutConstraint constraintWithItem:field
                                      attribute:NSLayoutAttributeTop
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:previousView
                                      attribute:NSLayoutAttributeBottom
                                     multiplier:1.0f
                                       constant:5.0f]];
        
    }
    [self setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.75f animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if(!keyboardShowing){
            for(int i = 2; i < tagNumber; i++) {
                [superview viewWithTag:i].hidden = NO;
            }
        }
    }];
}

+ (NSString*) defaultSubtitle { return @"New Rule"; }

@end
