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
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        singleTap.cancelsTouchesInView = NO;
        [self addGestureRecognizer:singleTap];
        //[self createResponderButton];
    }
    return self;
}

- (void) handleTap: (id) sender {
    [self endEditing:YES];
}

@end
