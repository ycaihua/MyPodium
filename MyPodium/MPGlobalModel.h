//
//  MPGlobalModel.h
//  MyPodium
//
//  Created by Connor Neville on 6/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface MPGlobalModel : NSObject

+ (NSArray*) usersContainingString: (NSString*) string;
+ (NSArray*) userSearchContainingString: (NSString*) string forUser: (PFUser*) user;
+ (NSArray*) userList: (NSArray*) users searchForString: (NSString*) string;

@end
