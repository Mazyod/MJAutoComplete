//
//  MJAutoCompleteCell.h
//  MJAutoCompleteDemo
//
//  Created by Mazyad Alabduljaleel on 11/11/13.
//  Copyright (c) 2013 ArabianDevs. All rights reserved.
//

#import "MJAutoCompleteItem.h"

@interface MJAutoCompleteCell : UITableViewCell

@property (strong, nonatomic) MJAutoCompleteItem *autoCompleteItem;
/* You can customize the tableView height through subclassing */
+ (CGFloat)height;

@end
