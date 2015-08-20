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
+ (NSArray*) teamList: (NSArray*) teams searchForString: (NSString*) string;
+ (NSArray*) messagesList: (NSArray*) messages searchForString: (NSString*) string;
+ (NSArray*) rulesList: (NSArray*) rules searchForString: (NSString*) string;
+ (NSArray*) eventList: (NSArray*) events searchForString: (NSString*) string;

+ (BOOL) usernameInUse: (NSString*) username;
+ (BOOL) emailInUse: (NSString*) email;

@end
