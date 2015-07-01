//
//  MPLimitConstants.h
//  MyPodium
//
//  Created by Connor Neville on 6/30/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPLimitConstants : NSObject

+ (int) maxUsernameCharacters;
+ (int) minUsernameCharacters;
+ (int) maxPasswordCharacters;
+ (int) minPasswordCharacters;
+ (int) maxTeamNameCharacters;
+ (int) minTeamNameCharacters;
+ (int) maxRealNameCharacters;
+ (int) minRealNameCharacters;
+ (int) maxUsersPerTeam;

@end
