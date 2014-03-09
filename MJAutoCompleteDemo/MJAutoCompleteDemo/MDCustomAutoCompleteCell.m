//
//  MDCustomAutoCompleteCell.m
//  MJAutoCompleteDemo
//
//  Created by Mazyad Alabduljaleel on 2/19/14.
//  Copyright (c) 2014 ArabianDevs. All rights reserved.
//

#import "MDCustomAutoCompleteCell.h"

@interface MDCustomAutoCompleteCell ()

@end

@implementation MDCustomAutoCompleteCell

/* override the setter to assign the subtitle label */
- (void)setAutoCompleteItem:(MJAutoCompleteItem *)autoCompleteItem
{
    // I bet you didn't know this was possible :p
    super.autoCompleteItem = autoCompleteItem;
    /* Superclass will set the text label to displayString, we don't want that. */
    self.textLabel.hidden = YES;
    
    NSDictionary *context = autoCompleteItem.context;
    self.titleLabel.text = DICT_GET(context, @"title");
    self.subtitleLabel.text = DICT_GET(context, @"emotion");
    self.viewsLabel.text = [DICT_GET(context, @"views") description];
    self.censoredLabel.hidden = ![DICT_GET(context, @"is_censored") boolValue];
}

@end
