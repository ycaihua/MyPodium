//
//  MPImageButton.m
//  MyPodium
//
//  Created by Connor Neville on 6/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPImageButton.h"

@implementation MPImageButton

- (id) init {
    self = [super init];
    if(self) {
        self.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (void) setImageString: (NSString*) imageString {
    UIImage* defaultImage = [UIImage imageNamed:
                             [NSString stringWithFormat:@"button_%@60.png", imageString]];
    [self setImage: defaultImage forState:UIControlStateNormal];
    UIImage* highlightedImage = [UIImage imageNamed:
                                [NSString stringWithFormat:@"button_%@_highlighted60.png", imageString]];
    [self setImage: highlightedImage forState:UIControlStateHighlighted];
}

+ (CGFloat) standardWidthAndHeight { return 60.0f; }

@end
