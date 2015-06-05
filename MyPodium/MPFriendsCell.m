//
//  MPFriendsCell.m
//  MyPodium
//
//  Created by Connor Neville on 6/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPFriendsCell.h"
#import "UIColor+MPColor.h"

@implementation MPFriendsCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if(self) {
    }
    return self;
    
}

- (void) updateForIncomingRequest {
    [self.leftButton setImageString:@"check_green"];
}

- (void) updateForFriendOrOutgoingRequest {
    [self.leftButton setImageString:@"info_green"];
}

@end
