//
//  UIButton+MPImage.h
//  MyPodium
//
//  Created by Connor Neville on 6/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (MPImage)

- (void)    setImageString: (NSString*) imageString
           withColorString: (NSString*) defaultColorString
withHighlightedColorString: (NSString*) highlightedColorString;

+ (CGFloat) standardWidthAndHeight;

@end
