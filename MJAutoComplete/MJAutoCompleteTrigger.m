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
    return [self initWithDelimiter:delimiter autoCompleteItems:nil];
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

- (NSString *)substringToBeAutoCompletedInString:(NSString *)string
{
    // short circuit for an empty delimiter string
    if (!self.delimiter.count)
    {
        return string;
    }

    // make sure to search backwards, since that's where the user it typing
    NSCharacterSet *breakSet = [[NSCharacterSet letterCharacterSet] invertedSet];
    NSRange brRange = [string rangeOfCharacterFromSet:breakSet
                                              options:NSBackwardsSearch];
    
    NSRange dlRange = [string rangeOfString:trigger.delimiter options:NSBackwardsSearch];
    // non alphanumeric breaks the autoComplete suggestions
    if (dlRange.location != NSNotFound &&
        (dlRange.location >= brRange.location || brRange.location == NSNotFound))
    {
        return [string substringFromIndex:dlRange.location+1];
    }

    return nil;
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
