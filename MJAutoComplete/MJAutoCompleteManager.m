//
//  MJAutoCompleteManager.m
//  MJAutoCompleteDemo
//
//  Created by Mazyad Alabduljaleel on 11/9/13.
//  Copyright (c) 2013 ArabianDevs. All rights reserved.
//

#import "MJAutoCompleteManager.h"
#import "MJAutoCompleteTC.h"

@interface MJAutoCompleteManager ()

/* keep a track of the currently processed string and delimiter. The string is the whole text sent by the developer. Accessed by the handler block. */
@property (strong, nonatomic) NSString* processingString;
@property (strong, nonatomic) MJAutoCompleteTrigger* currentTrigger;
/* The delimiters that would trigger an autoComplete cycle */
@property (strong, nonatomic) NSMutableSet *triggerSet;
/* The tableViewController associated with displaying the autoCompleteItems */
@property (strong, nonatomic) MJAutoCompleteTC *autoCompleteTC;

@end

@implementation MJAutoCompleteManager

- (id)init
{
    self = [super init];
    if (self)
    {
        self.triggerSet = [NSMutableSet setWithCapacity:5];
        /* we are retaining the tableViewController, so it shouldn't retain us */
        __weak MJAutoCompleteManager *weakSelf = self;
        /* Optionally inform the delegate when an item is about to be displayed. */
        MJAutoCompleteTCSelectionHandler display = ^(MJAutoCompleteItem *displayItem)
        {
            if ([weakSelf.delegate respondsToSelector:@selector(autoCompleteManager:willPresentItem:)])
            {
                [weakSelf.delegate autoCompleteManager:weakSelf willPresentItem:displayItem];
            }
        };
        /* send the new string, with the replaced autoComplete string, back to the user */
        MJAutoCompleteTCSelectionHandler selection = ^(MJAutoCompleteItem *selectedItem)
        {
            NSString* autoCompleteString = selectedItem.autoCompleteString;
            NSString* delimiter = weakSelf.currentTrigger.delimiter;
            
            NSRange dlRange = [weakSelf.processingString rangeOfString:delimiter options:NSBackwardsSearch];
            
            NSString* prevString = [weakSelf.processingString substringToIndex:dlRange.location+1];
            NSString* newString = [NSString stringWithFormat:@"%@%@ ", prevString, autoCompleteString];
            
            [weakSelf.delegate autoCompleteManager:weakSelf shouldUpdateToText:newString];
            // process new string:
            [weakSelf processString:newString];
        };
        
        _autoCompleteTC = [[MJAutoCompleteTC alloc] initWithDisplayHandler:display selectionHandler:selection];
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
    // NOTE: Don't use container.bounds
    CGRect bounds = container.frame;
    bounds.origin = CGPointZero;
    
    [self.autoCompleteTC.view removeFromSuperview];
    [self.autoCompleteTC.view setFrame:bounds];
    
    [container addSubview:self.autoCompleteTC.view];
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
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"autoCompleteString contains[cd] %@", string];
        [filteredList filterUsingPredicate:predicate];
    }
    [_autoCompleteTC setContents:filteredList];
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
                /* get the list of items from the dataSource EVERY TIME. The user should be able given the ability to implement a heuristic if the list is empty, for example, adding an autocorrect on top of autocomplete!) */
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
        [self.autoCompleteTC setContents:nil];
    }
}

@end
