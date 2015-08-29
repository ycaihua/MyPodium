//
//  MPMatchesModel.h
//  MyPodium
//
//  Created by Connor Neville on 8/28/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PFObject;

@interface MPMatchesModel : NSObject

+ (BOOL) createMatchesForEvent: (PFObject*) event;

@end