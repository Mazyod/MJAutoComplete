//
//  MJAutoCompleteTC.m
//  MJAutoCompleteDemo
//
//  Created by Mazyad Alabduljaleel on 11/9/13.
//  Copyright (c) 2013 ArabianDevs. All rights reserved.
//

#import "MJAutoCompleteTC.h"
#import "MJAutoCompleteCell.h"

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
    
    [self.tableView registerClass:[MJAutoCompleteCell class] forCellReuseIdentifier:@"AutoCompleteCell"];
    [self.tableView setHidden:self.contents == nil];
    // make sure the table view fits the container
    [self.tableView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth)];
}

- (void)setContents:(NSArray *)contents
{
    _contents = contents;
    // do not load the view unecessarily.
    if (self.isViewLoaded)
    {        
        [self.tableView setHidden:self.contents == nil];
        [self.tableView reloadData];
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
