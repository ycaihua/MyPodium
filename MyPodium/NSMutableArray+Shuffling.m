//
//  NSMutableArray+Shuffling.m
//  MyPodium
//
//  Created by Connor Neville on 5/29/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "NSMutableArray+Shuffling.h"

// Code from http://stackoverflow.com/questions/56648/whats-the-best-way-to-shuffle-an-nsmutablearray

@implementation NSMutableArray (Shuffling)

- (void)shuffle
{
    NSUInteger count = [self count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [self exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}

@end
