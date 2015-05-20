//
//  MPProfileView.m
//  MyPodium
//
//  Created by Connor Neville on 5/18/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPProfileView.h"

@implementation MPProfileView

- (id) init {
    self = [super initWithTitleText:@"USERNAME" subtitleText:@"profile"];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        [self makeProfileControls];
    }
    return self;
}

//Source of frustration! Subclasses of MPMenuView will accidentally
//override makeControls. Best approach is probably using some other name
//(don't want to have to call [super makeControls] again).
- (void) makeProfileControls {
    [self makeFriendsSubview];
    [self makeEventsSubview];
    [self makeModesSubview];
}

- (void) makeFriendsSubview {
    self.friendsSubview = [[MPProfileSubview alloc] init];
    self.friendsSubview.sidebarButton.subtitleLabel.text = @"FRIENDS";
    self.friendsSubview.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.friendsSubview];
    [self makeFriendsSubviewConstraints];
}

- (void) makeFriendsSubviewConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.friendsSubview
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.menu
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0f
                                                           constant:8.0f],
                             [NSLayoutConstraint constraintWithItem:self.friendsSubview
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeLeadingMargin
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.friendsSubview
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTrailingMargin
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.friendsSubview
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.25f
                                                           constant:0.0f]
                             ];
    [self addConstraints: constraints];
    
}

- (void) makeEventsSubview {
    self.eventsSubview = [[MPProfileSubview alloc] init];
    self.eventsSubview.sidebarButton.subtitleLabel.text = @"EVENTS";
    self.eventsSubview.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.eventsSubview];
    [self makeEventsSubviewConstraints];
}

- (void) makeEventsSubviewConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.eventsSubview
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.friendsSubview
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0f
                                                           constant:8.0f],
                             [NSLayoutConstraint constraintWithItem:self.eventsSubview
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeLeadingMargin
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.eventsSubview
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTrailingMargin
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.eventsSubview
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.25f
                                                           constant:0.0f]
                             ];
    [self addConstraints: constraints];
}

- (void) makeModesSubview {
    self.modesSubview = [[MPProfileSubview alloc] init];
    self.modesSubview.sidebarButton.subtitleLabel.text = @"GAME MODES";
    self.modesSubview.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.modesSubview];
    [self makeModesSubviewConstraints];
}

- (void) makeModesSubviewConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.modesSubview
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.eventsSubview
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0f
                                                           constant:8.0f],
                             [NSLayoutConstraint constraintWithItem:self.modesSubview
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeLeadingMargin
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.modesSubview
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTrailingMargin
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.modesSubview
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.25f
                                                           constant:0.0f]
                             ];
    [self addConstraints: constraints];
}

@end
