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
}

- (void) makeFriendsSubview {
    self.friendsSubview = [[MPProfileSubview alloc] init];
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
@end
