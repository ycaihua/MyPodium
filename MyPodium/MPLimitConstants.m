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

+ (int) maxPasswordCharacters { return 25; }
+ (int) minPasswordCharacters { return 4; }

+ (int) maxTeamNameCharacters { return 28; }
+ (int) minTeamNameCharacters { return 3; }

+ (int) maxRuleNameCharacters { return 28; }
+ (int) minRuleNameCharacters { return 3; }

+ (int) maxParticipantsPerMatch { return 6; }

+ (int) maxRealNameCharacters { return 18; }
+ (int) minRealNameCharacters { return 3; }

+ (int) maxPlayersPerTeam { return 12; }

+ (int) maxMessageTitleCharacters { return 50; }
+ (int) maxMessageBodyCharacters { return 500; }

+ (int) maxRecipientsPerMessage { return 5; }

@end
