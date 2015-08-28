//
//  MPEventsModel.h
//  MyPodium
//
//  Created by Connor Neville on 8/20/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPEventTypeView.h"

@class PFUser;
@class PFObject;

@interface MPEventsModel : NSObject

+ (BOOL) deleteEvent: (PFObject*) event;
+ (BOOL) eventNameInUse: (NSString*) name forUser: (PFUser*) user;
+ (BOOL) createEventWithName: (NSString*) name withOwner: (PFObject*) user withType: (MPEventType) type withRule: (PFObject*) rule withParticipants: (NSArray*) participants;

+ (NSArray*) eventsOwnedByUser: (PFUser*) user;
+ (NSArray*) eventsWithParticipatingUser: (PFUser*) user;
+ (NSArray*) eventsInvitingUser: (PFUser*) user;

+ (NSInteger) countEventsForUser: (PFUser*) user;

+ (MPEventType) typeOfEvent: (PFObject*) event;

@end
