//
//  MDViewController.m
//  MJAutoCompleteDemo
//
//  Created by Mazyad Alabduljaleel on 2/18/14.
//  Copyright (c) 2014 ArabianDevs. All rights reserved.
//

#import "MDViewController.h"
#import "MDCustomAutoCompleteCell.h"
#import "UIImageView+WebCache.h"

@interface MDViewController ()

@property (strong, nonatomic) MJAutoCompleteManager *autoCompleteMgr;

@property (weak, nonatomic) IBOutlet UIView *autoCompleteContainer;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation MDViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.autoCompleteMgr = [[MJAutoCompleteManager alloc] init];
        self.autoCompleteMgr.dataSource = self;
        self.autoCompleteMgr.delegate = self;
        /* Add some autoComplete triggers */
        // let's get the names of the countries
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Countries" ofType:@"plist"];
        NSArray *names = [[NSArray arrayWithContentsOfFile:path] valueForKey:@"name"];
        NSArray *items = [MJAutoCompleteItem autoCompleteCellModelFromObjects:names];

        // then assign them to the trigger
        MJAutoCompleteTrigger *hashTrigger = [[MJAutoCompleteTrigger alloc] initWithDelimiter:@"#"
                                                                            autoCompleteItems:items];
        
        MJAutoCompleteTrigger *atTrigger = [[MJAutoCompleteTrigger alloc] initWithDelimiter:@"@"
                                                                          autoCompleteItems:items];
        
        [self.autoCompleteMgr addAutoCompleteTrigger:hashTrigger];
        [self.autoCompleteMgr addAutoCompleteTrigger:atTrigger];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // assign our custom cell
    self.autoCompleteMgr.customAutoCompleteCell = [MDCustomAutoCompleteCell class];
    // hook up the container with the manager
    self.autoCompleteMgr.container = self.autoCompleteContainer;
    // and hook up the textView delegate
    self.textView.delegate = self;
}

#pragma mark - UITextView Delegate methods -

- (void)textViewDidChange:(UITextView *)textView
{
    [self.autoCompleteMgr processString:textView.text];
}

#pragma mark - MJAutoCompleteMgr Delegate methods -

- (void)autoCompleteManager:(MJAutoCompleteManager *)acManager willPresentCell:(id)autoCompleteCell
{
    MDCustomAutoCompleteCell *cell = autoCompleteCell;
    [cell.imageView setImageWithURL:[NSURL URLWithString:@"http://placehold.it/150x150"]
                   placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

- (void)autoCompleteManager:(MJAutoCompleteManager *)acManager shouldUpdateToText:(NSString *)newText
{
    self.textView.text = newText;
}

@end
