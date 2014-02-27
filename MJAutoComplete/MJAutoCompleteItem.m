//
//  MJAutoCompleteItem.m
//  MJAutoCompleteDemo
//
//  Created by Mazyad Alabduljaleel on 11/10/13.
//  Copyright (c) 2013 ArabianDevs. All rights reserved.
//

#import "MJAutoCompleteItem.h"

@implementation MJAutoCompleteItem
@synthesize displayedString = _displayedString;

+ (NSArray *)autoCompleteCellModelFromStrings:(NSArray *)strings
{
    NSMutableArray* items = [NSMutableArray arrayWithCapacity:[strings count]];
    for (id obj in strings)
    {
        MJAutoCompleteItem* item = [[self alloc] init];
        item.autoCompleteString = [obj description];
        
        [items addObject:item];
    }
    
    return items;
}

- (NSString *)displayedString
{
    if (!_displayedString)
    {
        return self.autoCompleteString;
    }
    return _displayedString;
}

@end
