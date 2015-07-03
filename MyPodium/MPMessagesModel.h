//
//  MPMessagesModel.h
//  MyPodium
//
//  Created by Connor Neville on 7/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PFUser;

@interface MPMessagesModel : NSObject

+ (NSArray*) newMessagesForUser: (PFUser*) user;

@end
