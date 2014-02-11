//
//  MJAutoCompleteDelimiter.h
//  MJAutoCompleteDemo
//
//  Created by Mazyad Alabduljaleel on 11/11/13.
//  Copyright (c) 2013 ArabianDevs. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
    CLASS DESCRIPTION:
    ==================
        
        The autoComplete component is really a delimiter oriented
    component. Based on the delimiter, we would show a certain list.
    With that in mind, you can think of this class as a plugin enabler
    for the autoComplete component.
 
        The minimum requirement for the trigger is assigning the 
    delimiter.
 
        Assigning an AutoCompleteItem list is optional, and will take
    the burden of maintaining the list of your hands. If it is not set,
    you must implement the AutoCompleteManagerDataSource 
    itemListForTrigger:. If that method is implemented, it has higher
    priorty, and will be called. You can simply return trigger.list if
    you only want to customize one trigger.
 
 */

@interface MJAutoCompleteTrigger : NSObject
/* the delimiter that will activate the trigger */
@property (copy, nonatomic) NSString *delimiter;
/* an optional autoCompleteItem array that would automatically be used for this trigger, if the dataSource doesn't implement itemListForTrigger */
@property (copy, nonatomic) NSArray *autoCompleteItemList;

- (instancetype)initWithDelimiter:(NSString *)delimiter;
- (instancetype)initWithDelimiter:(NSString *)delimiter autoCompleteItems:(NSArray*)items;

@end
