//
//  MPMatchModel.h
//  MyPodium
//
//  Created by Connor Neville on 8/28/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PFObject;

@interface MPMatchModel : NSObject

+ (BOOL) createMatchesForEvent: (PFObject*) match;

@end