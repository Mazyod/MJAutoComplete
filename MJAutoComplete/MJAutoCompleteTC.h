//
//  MJAutoCompleteTC.h
//  MJAutoCompleteDemo
//
//  Created by Mazyad Alabduljaleel on 11/9/13.
//  Copyright (c) 2013 ArabianDevs. All rights reserved.
//

@import UIKit;
#import "MJAutoCompleteItem.h"

@class MJAutoCompleteTC, MJAutoCompleteCell;

@protocol MJAutoCompleteTCDelegate <NSObject>

- (void)autoCompleteTableController:(MJAutoCompleteTC *)acTableController
                    willPresentCell:(MJAutoCompleteCell *)cell;

- (void)autoCompleteTableController:(MJAutoCompleteTC *)acTableController
                      didSelectItem:(MJAutoCompleteItem *)selectedItem;

@end

@interface MJAutoCompleteTC : UITableViewController
/* The contents of this table view is expected to be an array of MJAutoCompleteItems */
@property (readonly, nonatomic) NSArray* contents;

@property (weak, nonatomic) id<MJAutoCompleteTCDelegate> delegate;

- (instancetype)initWithDelegate:(id<MJAutoCompleteTCDelegate>)delegate;

- (void)showAutoCompleteItems:(NSArray *)items reversed:(BOOL)reverse;

@end
