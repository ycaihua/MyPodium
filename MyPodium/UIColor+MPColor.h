//
//  UIColor+MPColor.h
//  MyPodium
//
//  Created by Connor Neville on 5/14/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MPColor)

+ (UIColor*) colorFromHexString:(NSString *)hexString;

+ (UIColor*) MPBlackColor;
+ (UIColor*) MPGreenColor;
+ (UIColor*) MPYellowColor;
+ (UIColor*) MPRedColor;
+ (UIColor*) MPGrayColor;

@end