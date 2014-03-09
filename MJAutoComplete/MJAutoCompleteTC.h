//
//  MJAutoCompleteTC.h
//  MJAutoCompleteDemo
//
//  Created by Mazyad Alabduljaleel on 11/9/13.
//  Copyright (c) 2013 ArabianDevs. All rights reserved.
//

@import UIKit;
#import "MJAutoCompleteItem.h"

@class MJAutoCompleteTC, MJAutoCompleteCell, MJAutoCompleteTrigger;

@protocol MJAutoCompleteTCDelegate <NSObject>

@property (strong, nonatomic) MJAutoCompleteTrigger* currentTrigger;

- (void)autoCompleteTableController:(MJAutoCompleteTC *)acTableController
                    willPresentCell:(MJAutoCompleteCell *)cell;

- (void)autoCompleteTableController:(MJAutoCompleteTC *)acTableController
                      didSelectItem:(MJAutoCompleteItem *)selectedItem;

@end

@interface MJAutoCompleteTC : UITableViewController

- (instancetype)initWithDelegate:(id<MJAutoCompleteTCDelegate>)delegate;

- (void)showAutoCompleteItems:(NSArray *)items reversed:(BOOL)reverse;

@end
