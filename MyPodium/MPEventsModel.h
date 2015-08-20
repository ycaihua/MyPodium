//
//  MPEventsModel.h
//  MyPodium
//
//  Created by Connor Neville on 8/20/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PFUser;

@interface MPEventsModel : NSObject

+ (NSArray*) eventsOwnedByUser: (PFUser*) user;

+ (NSInteger) countEventsForUser: (PFUser*) user;

@end
