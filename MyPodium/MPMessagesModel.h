//
//  MPMessagesModel.h
//  MyPodium
//
//  Created by Connor Neville on 7/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PFUser;
@class PFObject;

@interface MPMessagesModel : NSObject

+ (NSArray*) newMessagesForUser: (PFUser*) user;
+ (NSArray*) readMessagesForUser: (PFUser*) user;
+ (NSArray*) sentMessagesForUser: (PFUser*) user;

+ (BOOL) markMessageRead: (PFObject*) message;
+ (BOOL) markMessageUnread: (PFObject*) message;
+ (BOOL) deleteMessage: (PFObject*) message;
+ (BOOL) hideMessageFromSender:(PFObject*) message;

@end
