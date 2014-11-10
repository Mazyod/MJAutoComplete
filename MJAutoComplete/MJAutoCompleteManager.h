//
//  MJAutoCompleteManager.h
//  MJAutoCompleteDemo
//
//  Created by Mazyad Alabduljaleel on 11/9/13.
//  Copyright (c) 2013 ArabianDevs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJAutoCompleteItem.h"
#import "MJAutoCompleteTrigger.h"

@class MJAutoCompleteManager;
@class MJAutoCompleteTC;

typedef void(^MJAutoCompleteListCallback)(NSArray* list);

/**
 The dataSource is completely optional. You can assign the items in advance with the triggers, or implement these methods to provide the list as they are required.
 
 NOTE:
 • The list of strings can be accomplished by creating an item list and just assigning the stringValue.
 **/
@protocol MJAutoCompleteManagerDataSource <NSObject>
@optional
/** This method requests the list of items to be shown based on the delimiter and string associated. A callback block is provided to give the convenience of fetching the list asynchronously, if needed **/
- (void)autoCompleteManager:(MJAutoCompleteManager *)acManager
         itemListForTrigger:(MJAutoCompleteTrigger *)trigger
                 withString:(NSString *)string
                   callback:(MJAutoCompleteListCallback)callback;

/** After the list is retrieved from the dataSource, it is sent back again to the dataSource to be filtered using whichever algorithm the dataSource prefers. If not implemented, it defaults to simple string matching the list retrieved with the captured string **/
- (void)autoCompleteManager:(MJAutoCompleteManager *)acManager
                 filterList:(NSMutableArray *)list
                 forTrigger:(MJAutoCompleteTrigger *)trigger
                 withString:(NSString *)string;

@end

@protocol MJAutoCompleteManagerDelegate <NSObject>

@optional
/** The user has selected an item on the autoComplete table view, and we inform the delegate through one of the methods below. You must implement one of them! **/
- (void)autoCompleteManager:(MJAutoCompleteManager *)acManager
         shouldUpdateToText:(NSString *)newText;

- (void)autoCompleteManager:(MJAutoCompleteManager *)acManager
         shouldUpdateToText:(NSString *)newText
               selectedItem:(MJAutoCompleteItem *)selectedItem;

/** For the sake of lazy loading, we notify the delegate when an autoComplete cell will be presented, so the developer can postpone fetching the image until the cell is actually going to be presented to the user. **/
- (void)autoCompleteManager:(MJAutoCompleteManager *)acManager
            willPresentCell:(id)autoCompleteCell
                 forTrigger:(MJAutoCompleteTrigger *)trigger;
/** Additional delegate methods when the autoComplete view will (dis)appear. **/
- (void)autoCompleteManagerViewWillAppear:(MJAutoCompleteManager *)acManager;
- (void)autoCompleteManagerViewWillDisappear:(MJAutoCompleteManager *)acManager;

@end

/**
    CLASS DESCRIPTION:
    ==================
 
        This is a single entry point for the developer who
    wants to use the MJAutoCompleteComponent. An instance of
    this class should be instantiated and retained by the 
    developer to control the overall behavior of the component
    as well as pass data back and forth between the developer's
    code and the component.
 
        Even though the autoComplete component is mostly a list
    of items, making the component's top level object a 
    tableViewController might cause rigidness and break the SRP
    design.
 
    STEPS:
    ------
        1 - Instantiate an instance or add in NIB
        2 - Assign a datasource & delegate
        3 - When avaiable, assign the container view.
        4 - Add some delimiters
        5 - call (processString:) directly.
        6 - On delimiter, itemListForDelimiter: is called if found, or trigger.list is used.
        7 - shouldUpdateText: is called with the WHOLE text. Just replace what you have.
 
 **/

@interface MJAutoCompleteManager : NSObject

/*=== COMPONENT SETUP ===*/
@property (weak, nonatomic) IBOutlet id<MJAutoCompleteManagerDataSource> dataSource;
@property (weak, nonatomic) IBOutlet id<MJAutoCompleteManagerDelegate> delegate;
/** The container must be set so the auto complete manager knows where to position it's table view. The table view will have an autoresizing mask of flexible width | flexible height to change with the container. **/
@property (weak, nonatomic) IBOutlet UIView* container;

/*=== COMPONENT CUSTOMIZATION ===*/
/** Context set by the component owner, and can be accessed by the delegate/datasource for custom action **/
@property (strong, nonatomic) NSDictionary *context;
/** Only for checking what triggers were added. Use -addAutoCompleteDelimiter: and removeAutoCompleteDelimiter: to indirectly manipulate the array **/
@property (readonly, nonatomic) NSSet* triggers;
/** Ability to reverse autocomplete table scroll direction **/
@property (getter=isScrollDirectionReversed, nonatomic) BOOL scrollDirectionReversed;
/** Use explicit methods to add and remove delimiters to enforce type checking and protect the internal mutable array. **/
- (void)addAutoCompleteTrigger:(MJAutoCompleteTrigger *)trigger;
- (void)removeAutoCompleteTrigger:(MJAutoCompleteTrigger *)trigger;
- (void)removeAllAutoCompleteTriggers;
/** Send the string as it is typed by the user, and the autoComplete table will be displayed when a delimiter is found at the end of the string **/
- (void)processString:(NSString *)string;

@end
