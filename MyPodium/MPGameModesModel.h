//
//  MPGameModesModel.h
//  MyPodium
//
//  Created by Connor Neville on 7/20/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PFUser;

@interface MPGameModesModel : NSObject

+ (NSArray*) gameModesForUser: (PFUser*) user;

@end
