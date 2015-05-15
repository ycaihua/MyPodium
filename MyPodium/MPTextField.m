//
//  MPTextField.m
//  MyPodium
//
//  Created by Connor Neville on 5/14/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPTextField.h"

@implementation MPTextField

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self applyDefaultStyle];
    }
    return self;
}

- (id) init {
    self = [super init];
    if(self) {
        [self applyDefaultStyle];
    }
    return self;
}

- (id) initWithPlaceholder: (NSString*) text {
    self = [super init];
    if(self) {
        [self applyDefaultStyle];
        [self setPlaceholder: text];
    }
    return self;
}

- (void) applyDefaultStyle {
    [self setBorderStyle:UITextBorderStyleLine];
    [self setFont: [UIFont fontWithName:@"Lato-Bold" size:15.0f]];
    [self setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self setAutocorrectionType: UITextAutocorrectionTypeNo];
}

//Overridden. Placeholder text always uppercase
- (void) setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:[placeholder uppercaseString]];
}

// Adds padding to placeholder text
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 10 , 10 );
}

// Adds padding to edited text
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 10 , 10 );
}

@end
