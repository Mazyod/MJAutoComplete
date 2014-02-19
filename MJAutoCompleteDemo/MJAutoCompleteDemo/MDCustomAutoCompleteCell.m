//
//  MDCustomAutoCompleteCell.m
//  MJAutoCompleteDemo
//
//  Created by Mazyad Alabduljaleel on 2/19/14.
//  Copyright (c) 2014 ArabianDevs. All rights reserved.
//

#import "MDCustomAutoCompleteCell.h"

@implementation MDCustomAutoCompleteCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.textLabel.font = [UIFont boldSystemFontOfSize:20];
    }
    return self;
}

@end
