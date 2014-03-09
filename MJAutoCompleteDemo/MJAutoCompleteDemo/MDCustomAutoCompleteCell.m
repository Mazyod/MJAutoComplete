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
    self.titleLabel.text = autoCompleteItem.displayedString;
    self.subtitleLabel.text = autoCompleteItem.autoCompleteString;
}

@end
