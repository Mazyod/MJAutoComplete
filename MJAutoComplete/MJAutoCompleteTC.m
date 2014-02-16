//
//  MJAutoCompleteTC.m
//  MJAutoCompleteDemo
//
//  Created by Mazyad Alabduljaleel on 11/9/13.
//  Copyright (c) 2013 ArabianDevs. All rights reserved.
//

#import "MJAutoCompleteTC.h"
#import "MJAutoCompleteCell.h"

const CGFloat MJAutoCompleteTCCellHeight = 44.f;

@interface MJAutoCompleteTC ()

@property (copy, nonatomic) MJAutoCompleteTCDisplayHandler displayHandler;
@property (copy, nonatomic) MJAutoCompleteTCSelectionHandler selectionHandler;

@end

@implementation MJAutoCompleteTC

- (instancetype)initWithDisplayHandler:(MJAutoCompleteTCDisplayHandler)display
                      selectionHandler:(MJAutoCompleteTCSelectionHandler)selection
{
    self = [super init];
    if (self)
    {
        self.displayHandler = display;
        self.selectionHandler = selection;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView registerClass:[MJAutoCompleteCell class] forCellReuseIdentifier:@"AutoCompleteCell"];
    [self.tableView setHidden:self.contents == nil];
    // make sure the table view fits the container
    [self.tableView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth)];
}

- (void)showAutoCompleteItems:(NSArray *)items reversed:(BOOL)reverse
{
    if (!reverse)
    {
        _contents = items;
    }
    else
    {
        /* First, reverse the model we got */
        NSMutableArray *reversed = [NSMutableArray arrayWithCapacity:items.count];
        for (id obj in items.reverseObjectEnumerator)
        {
            [reversed addObject:obj];
        }
        _contents = reversed;
        /* Then, let's adjust the tableView */
        /* 1 - if the frame of the table is smaller than the container, position it at the bottom */
        CGFloat contentHeight = MJAutoCompleteTCCellHeight * [items count];
        if (contentHeight < CGRectGetHeight(self.tableView.superview.bounds))
        {
            CGRect frame = self.tableView.frame;
            frame.origin.y = CGRectGetHeight(self.tableView.superview.bounds) - contentHeight;
            frame.size.height = contentHeight;

            self.tableView.frame = frame;
            self.tableView.scrollEnabled = NO;
        }
        else
        {
            self.tableView.frame = self.tableView.superview.bounds;
            self.tableView.scrollEnabled = YES;
        }
    }

    [self.tableView setHidden:self.contents == nil];
    [self.tableView reloadData];

    if (items)
    {
        NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:[items count]-1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:lastIndexPath
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:NO];
    }
}

#pragma mark - Table view data source -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_contents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AutoCompleteCell";
    MJAutoCompleteCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                               forIndexPath:indexPath];
    
    MJAutoCompleteItem* item = self.contents[indexPath.row];
    if (self.displayHandler)
    {
        self.displayHandler(item);
    }
    
    [cell setAutoCompleteItem:item];
    
    return cell;
}

#pragma mark - Table view delegate methods -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectionHandler)
    {
        self.selectionHandler(self.contents[indexPath.row]);
    }
}

@end
