//
//  MJAutoCompleteManager.m
//  MJAutoCompleteDemo
//
//  Created by Mazyad Alabduljaleel on 11/9/13.
//  Copyright (c) 2013 ArabianDevs. All rights reserved.
//

#import "MJAutoCompleteManager.h"
#import "MJAutoCompleteTC.h"
#import "MJAutoCompleteCell.h"

@interface MJAutoCompleteManager () <MJAutoCompleteTCDelegate>

/* keep a track of the currently processed string and delimiter. The string is the whole text sent by the developer. Accessed by the handler block. */
@property (strong, nonatomic) NSString* processingString;
/* The delimiters that would trigger an autoComplete cycle */
@property (strong, nonatomic) NSMutableSet *triggerSet;
/* The tableViewController associated with displaying the autoCompleteItems */
@property (strong, nonatomic) MJAutoCompleteTC *autoCompleteTC;

@end

@implementation MJAutoCompleteManager
@synthesize currentTrigger = _currentTrigger;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.triggerSet = [NSMutableSet setWithCapacity:5];
        
        _autoCompleteTC = [[MJAutoCompleteTC alloc] initWithDelegate:self];
    }
    return self;
}

- (NSSet *)triggers
{
    // protect the internal mutable array
    return [self.triggerSet copy];
}
/* Override setContainer: to add the tableView to new container */
- (void)setContainer:(UIView *)container
{
    _container = container;

    [self.autoCompleteTC.tableView removeFromSuperview];
    [self.autoCompleteTC.tableView setFrame:container.bounds];
    
    [container addSubview:self.autoCompleteTC.tableView];
}
/* Update the AutoCompleteItems list with new items using the dataSource to filter, or apply simple filter */
- (void)_updateAutoCompleteList:(NSArray *)list forTrigger:(MJAutoCompleteTrigger *)trigger withString:(NSString *)string
{
    self.currentTrigger = trigger;
    
    NSMutableArray* filteredList = [list mutableCopy];
    if ([self.dataSource respondsToSelector:@selector(autoCompleteManager:filterList:forTrigger:withString:)])
    {
        [self.dataSource autoCompleteManager:self filterList:filteredList forTrigger:trigger withString:string];
    }
    else
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"autoCompleteString beginswith[cd] %@", string];
        [filteredList filterUsingPredicate:predicate];
    }

    if ([self.delegate respondsToSelector:@selector(autoCompleteManagerViewWillAppear:)])
    {
        [self.delegate autoCompleteManagerViewWillAppear:self];
    }

    [_autoCompleteTC showAutoCompleteItems:filteredList reversed:self.isScrollDirectionReversed];
}

- (void)addAutoCompleteTrigger:(MJAutoCompleteTrigger *)trigger
{
    [self.triggerSet addObject:trigger];
}

- (void)removeAutoCompleteTrigger:(MJAutoCompleteTrigger *)trigger
{
    [self.triggerSet removeObject:trigger];
}

- (void)removeAllAutoCompleteTriggers
{
    [self.triggerSet removeAllObjects];
}

- (void)processString:(NSString *)string
{
    self.processingString = string;
    BOOL didTriggerAutoComplete = NO;
    // iterate the triggers, note how the order is significant
    for (MJAutoCompleteTrigger* trigger in self.triggerSet)
    {
        NSString *substring = [trigger substringToBeAutoCompletedInString:self.processingString];
        // if the trigger found a string to be autoCompleted
        if (substring)
        {
            // let's inform the delegate and update the list
            __weak MJAutoCompleteManager *weakSelf = self;
            MJAutoCompleteListCallback cb = ^(NSArray *list)
            {
                [weakSelf _updateAutoCompleteList:list forTrigger:trigger withString:substring];
            };
            
            if ([self.dataSource respondsToSelector:@selector(autoCompleteManager:itemListForTrigger:withString:callback:)])
            {
                /* get the list of items from the dataSource EVERY TIME. The user should be given the ability to implement a heuristic if the list is empty, for example, adding an autocorrect on top of autocomplete!) */
                [self.dataSource autoCompleteManager:self
                                  itemListForTrigger:trigger
                                          withString:substring
                                            callback:cb];
            }
            else
            {
                cb(trigger.autoCompleteItemList);
            }

            didTriggerAutoComplete = YES;
            break;
        }
    }
    // if there was no trigger invoked, get rid of the tableview
    if (!didTriggerAutoComplete)
    {
        if ([self.delegate respondsToSelector:@selector(autoCompleteManagerViewWillDisappear:)])
        {
            [self.delegate autoCompleteManagerViewWillDisappear:self];
        }

        [_autoCompleteTC showAutoCompleteItems:nil reversed:NO];
    }
}

#pragma mark - MJAutoCompleteTC Delegate Methods
/* Optionally inform the delegate when an item is about to be displayed. */
- (void)autoCompleteTableController:(MJAutoCompleteTC *)acTableController
                    willPresentCell:(MJAutoCompleteCell *)cell
{
    if ([self.delegate respondsToSelector:@selector(autoCompleteManager:willPresentCell:forTrigger:)])
    {
        [self.delegate autoCompleteManager:self willPresentCell:cell forTrigger:self.currentTrigger];
    }
}
/* send the new string, with the replaced autoComplete string, back to the user */
- (void)autoCompleteTableController:(MJAutoCompleteTC *)acTableController
                      didSelectItem:(MJAutoCompleteItem *)selectedItem
{
    NSString* autoCompleteString = selectedItem.autoCompleteString;
    NSString* delimiter = self.currentTrigger.delimiter;
    
    NSRange dlRange = [self.processingString rangeOfString:delimiter
                                                   options:NSBackwardsSearch];
    if (!delimiter.length)
    {
        dlRange = NSMakeRange(0, 0);
    }
    /* If the autoCompleteString already has the delimiter, let's strip it */
    NSInteger offset = [autoCompleteString hasPrefix:delimiter] ? delimiter.length : 0;
    NSInteger index = NSMaxRange(dlRange) - offset;
    
    NSString* prevString = [self.processingString substringToIndex:index];
    NSString* newString = [NSString stringWithFormat:@"%@%@ ", prevString, autoCompleteString];
    
    if ([self.delegate respondsToSelector:@selector(autoCompleteManager:shouldUpdateToText:selectedItem:)]) {
        [self.delegate autoCompleteManager:self shouldUpdateToText:newString selectedItem:selectedItem];
    } 
    else if ([self.delegate respondsToSelector:@selector(autoCompleteManager:shouldUpdateToText:)])
    {
        [self.delegate autoCompleteManager:self shouldUpdateToText:newString];
    }
    
    // process new string:
    [self processString:newString];
}

@end
