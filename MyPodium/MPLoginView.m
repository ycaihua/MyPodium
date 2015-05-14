//
//  MPLoginView.m
//  MyPodium
//
//  Created by Connor Neville on 5/14/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPLoginView.h"

@implementation MPLoginView

- (id) init {
    self = [super init];
    if(self) {
        [self createLogoView];
    }
    return self;
}

- (void) createLogoView {
    UIImage* image = [UIImage imageNamed:@"logo600_flat.png"];
    self.logoView = [[UIImageView alloc] initWithImage:image];
    self.logoView.image = image;
    self.logoView.translatesAutoresizingMaskIntoConstraints = FALSE;
    self.logoView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.logoView];
    [self createLogoViewConstraints];
}

//We don't need a constraint for height, because the
//content mode is set above to aspect fit
- (void) createLogoViewConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.logoView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTopMargin
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.logoView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.logoView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationLessThanOrEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0f
                                                           constant:0.0f]
                             ];
    [self addConstraints: constraints];

}

@end
