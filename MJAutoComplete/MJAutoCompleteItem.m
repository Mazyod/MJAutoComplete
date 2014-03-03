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

+ (NSArray *)autoCompleteCellModelFromObjects:(NSArray *)objs
{
    NSMutableArray* items = [NSMutableArray arrayWithCapacity:[objs count]];
    for (id obj in objs)
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

- (NSString *)description
{
    return self.autoCompleteString;
}

@end
