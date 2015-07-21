//
//  MPSettingsScrollView.m
//  MyPodium
//
//  Created by Connor Neville on 7/16/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPSettingsScrollView.h"

@implementation MPSettingsScrollView

- (id) init {
    self = [super init];
    if(self) {
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        singleTap.cancelsTouchesInView = NO;
        [self addGestureRecognizer:singleTap];
    }
    return self;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    return NO;
}

- (void) handleTap: (id) sender {
    [self.superview endEditing:YES];
}

@end
