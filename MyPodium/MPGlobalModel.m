//
//  MPGlobalModel.m
//  MyPodium
//
//  Created by Connor Neville on 6/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPGlobalModel.h"

@implementation MPGlobalModel

+ (NSArray*) usersContainingString: (NSString*) string {
    if(string.length == 0) return @[];
    PFQuery* query = [PFUser query];
    [query whereKey:@"username" containsString:string];
    return [query findObjects];
}

@end
