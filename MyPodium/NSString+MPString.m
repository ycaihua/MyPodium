//
//  NSString+MPString.m
//  MyPodium
//
//  Created by Connor Neville on 5/15/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "NSString+MPString.h"

@implementation NSString (MPString)

//Checks whether a string is a valid email
//for registration/password retrieval
- (BOOL) isValidEmail {
    //Can test with one of two regex expressions
    BOOL stricterFilter = NO;
    
    NSString *strictFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxFilterString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    
    NSString *emailRegex = stricterFilter ? strictFilterString : laxFilterString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

//Checks whether a string is a valid username
//for registration - can only contain
//letters, numbers, underscores
- (BOOL) isValidUsername {
    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_"];
    
    s = [s invertedSet];
    NSRange r = [self rangeOfCharacterFromSet:s];
    return (r.location == NSNotFound);
}

@end
