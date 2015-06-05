//
//  UIButton+MPImage.m
//  MyPodium
//
//  Created by Connor Neville on 6/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIButton+MPImage.h"

@implementation UIButton (MPImage)

- (void)    setImageString:(NSString *)imageString
           withColorString:(NSString *)defaultColorString
withHighlightedColorString:(NSString *)highlightedColorString {
    
    UIImage* defaultImage = [UIImage imageNamed:
                             [NSString stringWithFormat:@"%@_%@.png", imageString, defaultColorString]];
    [self setImage: defaultImage forState:UIControlStateNormal];
    UIImage* highlightedImage = [UIImage imageNamed:
                                 [NSString stringWithFormat:@"%@_%@.png", imageString, highlightedColorString]];
    [self setImage: highlightedImage forState:UIControlStateHighlighted];
    [self setContentMode: UIViewContentModeCenter];
}

+ (CGFloat) standardWidthAndHeight { return 60.0f; }

@end
