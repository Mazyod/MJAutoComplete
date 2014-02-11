//
//  MJAutoCompleteDelimiter.m
//  MJAutoCompleteDemo
//
//  Created by Mazyad Alabduljaleel on 11/11/13.
//  Copyright (c) 2013 ArabianDevs. All rights reserved.
//

#import "MJAutoCompleteTrigger.h"

@implementation MJAutoCompleteTrigger

- (instancetype)initWithDelimiter:(NSString *)delimiter
{
    return [self initWithDelimiter:delimiter];
}

- (instancetype)initWithDelimiter:(NSString *)delimiter autoCompleteItems:(NSArray *)items
{
    self = [super init];
    if (self)
    {
        self.delimiter = delimiter;
        self.autoCompleteItemList = items;
    }
    return self;
}
/* Implement isEqual to help the NSSet make sure the triggers are unique */
- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[self class]])
    {
        return [[object delimiter] isEqual:self.delimiter];
    }
    
    return NO;
}

- (NSUInteger)hash
{
    return [self.delimiter hash];
}

@end
