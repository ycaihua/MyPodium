//
//  MPSidebarViewCell.m
//  MyPodium
//
//  Created by Connor Neville on 5/30/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"

#import "MPSidebarViewCell.h"
#import "MPSidebarButton.h"

@implementation MPSidebarViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self removeExistingSubviews];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
    
}

- (void) removeExistingSubviews {
    for(UIView* view in self.subviews) {
        [view removeFromSuperview];
    }
}

- (void) updateWithRow: (int) row {
    self.cellButton.rowIndex = row;
    self.cellButton.customTitleLabel.text = [MPSidebarViewCell cellLabelStrings][row];
}

- (void) makeControls {
    //self.cellButton
    self.cellButton = [[MPSidebarButton alloc] init];
    self.cellButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.cellButton];
}

- (void) makeControlConstraints {
    [self addConstraints: @[//self.cellButton
                            [NSLayoutConstraint constraintWithItem:self.cellButton
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeadingMargin
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.cellButton
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeBottomMargin
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.cellButton
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTopMargin
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.cellButton
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTrailingMargin
                                                        multiplier:1.0f
                                                          constant:0.0f]
                            ]];
}

+ (CGFloat) cellHeight { return 45.0f; }

+ (NSArray*) cellLabelStrings {
    return @[@"Home", @"Friends", @"Teams", @"New Team", @"Events",
             @"User Search", @"Settings", @"Help", @"About",
             @"Log Out"];
}

@end
