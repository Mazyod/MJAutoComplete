//
//  MJAutoCompleteTC.m
//  MJAutoCompleteDemo
//
//  Created by Mazyad Alabduljaleel on 11/9/13.
//  Copyright (c) 2013 ArabianDevs. All rights reserved.
//

#import "MJAutoCompleteTC.h"
#import "MJAutoCompleteCell.h"
#import "MJAutoCompleteTrigger.h"

static NSString *MJAutoCompleteCellReuseIdentifier = @"AutoCompleteCell";

@interface MJAutoCompleteTC ()

@property (weak, nonatomic) id<MJAutoCompleteTCDelegate> delegate;
/* The contents of this table view is expected to be an array of MJAutoCompleteItems */
@property (readonly, nonatomic) NSArray* contents;
/* Height of a cell, retreived from the NIB, or +[MJAutoCompleteCell height] */
@property (nonatomic) CGFloat cellHeight;

@end

@implementation MJAutoCompleteTC

- (instancetype)initWithDelegate:(id<MJAutoCompleteTCDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        self.delegate = delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView registerClass:[MJAutoCompleteCell class] forCellReuseIdentifier:MJAutoCompleteCellReuseIdentifier];
    [self.tableView setHidden:self.contents == nil];
    // make sure the table view fits the container
    [self.tableView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth)];
}

- (void)showAutoCompleteItems:(NSArray *)items reversed:(BOOL)reverse
{
    /* Resolve the trigger parameter and cellHeight */
    self.cellHeight = [MJAutoCompleteCell height];
    MJAutoCompleteTrigger *trigger = self.delegate.currentTrigger;
    if (trigger.cell)
    {
        if ([[NSBundle mainBundle] pathForResource:trigger.cell ofType:@"nib"])
        {
            UINib *nib = [UINib nibWithNibName:trigger.cell bundle:nil];
            /* attempt to retreive the height of the cell */
            NSArray *objects = [nib instantiateWithOwner:nil options:nil];
            NSAssert([objects count] == 1, @"The Cell NIB %@ has more than one object!", trigger.cell);
            self.cellHeight = CGRectGetHeight([(UIView *)objects[0] bounds]);
            
            [self.tableView registerNib:nib forCellReuseIdentifier:trigger.cell];
        }
        else
        {
            Class cls = NSClassFromString(trigger.cell);
            NSAssert([cls isSubclassOfClass:[MJAutoCompleteCell class]], @"%@ must be MJAutoCompleteCell subclass", trigger.cell);
            self.cellHeight = [cls height];
            
            [self.tableView registerClass:cls forCellReuseIdentifier:trigger.cell];
        }
    }
    
    /* Resolve the reverse parameter */
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
        /* if the frame of the table is smaller than the container, position it at the bottom and disable scrolling */
        CGFloat contentHeight = self.cellHeight * [items count];
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

    /* resolve the items parameter set to self.contents */
    [self.tableView setHidden:self.contents == nil];
    [self.tableView reloadData];
    /* update after reloading the data */
    if ([items count] && reverse)
    {
        NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:[items count]-1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:lastIndexPath
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:NO];
    }
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MJAutoCompleteCell *cell = [tableView dequeueReusableCellWithIdentifier:self.delegate.currentTrigger.cell];
    if (!cell)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:MJAutoCompleteCellReuseIdentifier];
        NSAssert(cell, @"Cell couldn't be instantiated for identifier: %@", MJAutoCompleteCellReuseIdentifier);
    }
    
    MJAutoCompleteItem* item = self.contents[indexPath.row];
    [cell setAutoCompleteItem:item];
    
    [self.delegate autoCompleteTableController:self willPresentCell:cell];
    
    return cell;
}

#pragma mark - Table view delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate autoCompleteTableController:self didSelectItem:self.contents[indexPath.row]];
}

#pragma mark -

@end
