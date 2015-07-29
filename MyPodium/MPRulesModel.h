//
//  MPRulesModel.h
//  MyPodium
//
//  Created by Connor Neville on 7/20/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PFUser;

@interface MPRulesModel : NSObject

+ (BOOL) ruleNameInUse: (NSString*) name forUser: (PFUser*) user;

+ (NSArray*) rulesForUser: (PFUser*) user;

+ (NSInteger) countRulesForUser: (PFUser*) user;

@end
