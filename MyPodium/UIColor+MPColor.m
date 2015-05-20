//
//  UIColor+MPColor.m
//  MyPodium
//
//  Created by Connor Neville on 5/14/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"

@implementation UIColor (MPColor)

//http://stackoverflow.com/questions/1560081/how-can-i-create-a-uicolor-from-a-hex-string
+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+ (UIColor*) MPBlackColor {
    return [UIColor colorFromHexString:@"#1F222A"];
}

+ (UIColor*) MPGreenColor {
    return [UIColor colorFromHexString:@"#45CBB1"];
}

+ (UIColor*) MPYellowColor {
    return [UIColor colorFromHexString:@"#FFCF32"];
}

+ (UIColor*) MPRedColor {
    return [UIColor colorFromHexString:@"#E93646"];
}

+ (UIColor*) MPGrayColor {
    return [UIColor colorFromHexString:@"#C4C4C4"];
}

@end
