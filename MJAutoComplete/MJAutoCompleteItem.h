//
//  MJAutoCompleteItem.h
//  MJAutoCompleteDemo
//
//  Created by Mazyad Alabduljaleel on 11/10/13.
//  Copyright (c) 2013 ArabianDevs. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
    CLASS DESCRIPTION:
    ==================
    
        This class represents an item displayed in the autoComplete 
    list. An item must have a string set, which will is the autoComplete 
    option that is compared against the string when a trigger is fired. 
    The other strings, displayedString, can optionally be set, and it 
    will be the string displayed to the user rather than the autoComplete
    string.
 
    ex. 
        autoCompleteString: mazyod (my twitter handle)
        displayedString: Mazyad Alabduljaleel (my name)
 
        So, by entering "mazyad", nothing shows up, but when "mazyod" is
    entered, "Mazyad Alabduljaleel" will be shown as an option.
 
 */

@interface MJAutoCompleteItem : NSObject
/* You can specify the string that autoCompletes different from the string that is shown in the UI */
@property (strong, nonatomic) NSString *autoCompleteString;
@property (strong, nonatomic) NSString *displayedString;
/* Arbitrary data you might want to associate with the MJAutoCompleteItem */
@property (strong, nonatomic) NSDictionary *context;
// for convenience, -[NSObject description] will be called on all the items
+ (NSArray *)autoCompleteCellModelFromObjects:(NSArray *)objs;

@end
