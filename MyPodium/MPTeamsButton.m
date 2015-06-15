//
//  MPTeamsButton.m
//  MyPodium
//
//  Created by Connor Neville on 6/14/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPTeamsButton.h"
#import "UIColor+MPColor.h"

@implementation MPTeamsButton

- (id) init {
    self = [super init];
    if(self) {
        self.backgroundColor = [UIColor MPBlackColor];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont fontWithName:@"Oswald-Bold" size:22.0f]];
    }
    return self;
}

- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if(highlighted) {
        self.backgroundColor = [UIColor MPDarkGrayColor];
    }
    else {
        self.backgroundColor = [UIColor MPBlackColor];
    }
}

+ (CGFloat) defaultHeight { return 45.0f; }

@end
