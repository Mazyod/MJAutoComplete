//
//  MJAutoCompleteTC.h
//  MJAutoCompleteDemo
//
//  Created by Mazyad Alabduljaleel on 11/9/13.
//  Copyright (c) 2013 ArabianDevs. All rights reserved.
//

@import UIKit;
#import "MJAutoCompleteItem.h"

/* In order to simplify the message passing between the manager and the TC, we simply define block handlers when an item will be presented and when an item is selected */

typedef void(^MJAutoCompleteTCDisplayHandler)(MJAutoCompleteItem *displayedItem);
typedef void(^MJAutoCompleteTCSelectionHandler)(MJAutoCompleteItem *selectedItem);

@interface MJAutoCompleteTC : UITableViewController
/* The contents of this table view is expected to be an array of NSStrings */
@property (strong, nonatomic) NSArray* contents;

- (instancetype)initWithDisplayHandler:(MJAutoCompleteTCDisplayHandler)display
                      selectionHandler:(MJAutoCompleteTCSelectionHandler)selection;

@end
