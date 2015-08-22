//
//  MPEventsModel.h
//  MyPodium
//
//  Created by Connor Neville on 8/20/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PFUser;
@class PFObject;

@interface MPEventsModel : NSObject

+ (BOOL) deleteEvent: (PFObject*) event;
+ (BOOL) eventNameInUse: (NSString*) name forUser: (PFUser*) user;

+ (NSArray*) eventsOwnedByUser: (PFUser*) user;
+ (NSArray*) eventsWithParticipatingUser: (PFUser*) user;
+ (NSArray*) eventsInvitingUser: (PFUser*) user;

+ (NSInteger) countEventsForUser: (PFUser*) user;

@end
