//
//  MJAutoCompleteDelimiter.h
//  MJAutoCompleteDemo
//
//  Created by Mazyad Alabduljaleel on 11/11/13.
//  Copyright (c) 2013 ArabianDevs. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
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

    IMPORTANT:
    ==========

        Assining an empty string as the delimiter will cause the 
    component to act as a general purpose search autoComplete engine. 
    For example, if the user types, "I like turtles", an autoComplete
    string will be fetched based on the WHOLE string. Hence, we get:
    "You are a great Zombie".
 
 **/

@interface MJAutoCompleteTrigger : NSObject
/** the delimiter that will activate the trigger **/
@property (copy, nonatomic) NSString *delimiter;
/** an optional autoCompleteItem array that would automatically be used for this trigger, if the dataSource doesn't implement itemListForTrigger **/
@property (copy, nonatomic) NSArray *autoCompleteItemList;
/** assign the cusotm cell class OR nib, NOT BOTH!! (allows different triggers show different cells) **/
@property (strong, nonatomic) NSString *cell;

/* I am a big fan of providing the user with multiple signatures, to save them as much typing as possible */
- (instancetype)initWithDelimiter:(NSString *)delimiter;
- (instancetype)initWithDelimiter:(NSString *)delimiter autoCompleteItems:(NSArray*)items;
- (instancetype)initWithDelimiter:(NSString *)delimiter autoCompleteItems:(NSArray*)items cell:(NSString *)cell;

/* get the string that fires this trigger, or nil if none */
- (NSString *)substringToBeAutoCompletedInString:(NSString *)string;

@end
