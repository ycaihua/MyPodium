//
//  MPFormView.m
//  MyPodium
//
//  Created by Connor Neville on 8/5/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPFormView.h"

#import "UIColor+MPColor.h"

#import "MPLabel.h"
#import "MPTextField.h"
#import "MPBottomEdgeButton.h"

@implementation MPFormView

- (id) initWithTitleText:(NSString *)titleText subtitleText:(NSString *)subtitleText {
    self = [super initWithTitleText:titleText subtitleText:subtitleText];
    if(self) {
        self.slideViewIndex = 0;
        self.backgroundColor = [UIColor MPGrayColor];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
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

- (void) addSlideViews {
    //self.slideViews
    for(MPView* view in self.slideViews) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview: view];
    }
    
    [self makeSlideViewConstraints];
}

- (void) makeSlideViewConstraints {
    for(int i = 0; i < self.slideViews.count; i++) {
        //Constraints common to all slides
        [self addConstraints:@[[NSLayoutConstraint constraintWithItem:self.slideViews[i]
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.menu
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1.0f
                                                             constant:10.0f],
                               [NSLayoutConstraint constraintWithItem:self.slideViews[i]
                                                            attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.previousButton
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1.0f
                                                             constant:-10.0f],
                               [NSLayoutConstraint constraintWithItem:self.slideViews[i]
                                                            attribute:NSLayoutAttributeWidth
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeWidth
                                                           multiplier:1.0f
                                                             constant:-32.0f],
                               ]];
        if(i == 0)
            [self addConstraint:
             [NSLayoutConstraint constraintWithItem:self.slideViews[i]
                                          attribute:NSLayoutAttributeLeading
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:self
                                          attribute:NSLayoutAttributeLeadingMargin
                                         multiplier:1.0f
                                           constant:0.0f]];
        else
            [self addConstraint:
             [NSLayoutConstraint constraintWithItem:self.slideViews[i]
                                          attribute:NSLayoutAttributeLeading
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:self.slideViews[i-1]
                                          attribute:NSLayoutAttributeTrailing
                                         multiplier:1.0f
                                           constant:16.0f]];
        if(i < (self.slideViews.count - 1))
            [self addConstraint:
             [NSLayoutConstraint constraintWithItem:self.slideViews[i]
                                          attribute:NSLayoutAttributeTrailing
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:self.slideViews[i+1]
                                          attribute:NSLayoutAttributeLeading
                                         multiplier:1.0f
                                           constant:-16.0f]];
        
    }
}

- (void) advanceToNextSlide {
    self.slideViewIndex++;
    [self refreshConstraints];
}

- (void) returnToLastSlide {
    self.slideViewIndex--;
    [self refreshConstraints];
}

- (void) refreshConstraints {
    for(NSLayoutConstraint* constraint in self.constraints) {
        if([constraint.secondItem isEqual: self] &&
           constraint.secondAttribute == NSLayoutAttributeLeadingMargin) {
            [self removeConstraint: constraint];
            break;
        }
    }
    
    MPView* newDisplayedView = [self currentSlide];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:newDisplayedView
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

- (MPView*) slideWithClass: (Class) slideClass {
    for(MPView* view in self.slideViews) {
        if([view isKindOfClass: slideClass])
            return view;
    }
    return nil;
}

- (MPView*) currentSlide {
    return  self.slideViews[self.slideViewIndex];
}

@end