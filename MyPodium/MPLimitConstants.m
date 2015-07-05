//
//  MPLimitConstants.m
//  MyPodium
//
//  Created by Connor Neville on 6/30/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPLimitConstants.h"

@implementation MPLimitConstants

+ (int) maxUsernameCharacters { return 12; }
+ (int) minUsernameCharacters { return 3; }

+ (int) maxPasswordCharacters { return 18; }
+ (int) minPasswordCharacters { return 4; }

+ (int) maxTeamNameCharacters { return 28; }
+ (int) minTeamNameCharacters { return 3; }

+ (int) maxRealNameCharacters { return 18; }
+ (int) minRealNameCharacters { return 3; }

+ (int) maxUsersPerTeam { return 12; }

+ (int) maxMessageTitleCharacters { return 50; }
+ (int) maxMessageBodyCharacters { return 500; }

@end
