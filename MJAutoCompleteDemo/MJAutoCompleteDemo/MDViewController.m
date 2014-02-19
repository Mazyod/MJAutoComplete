//
//  MDViewController.m
//  MJAutoCompleteDemo
//
//  Created by Mazyad Alabduljaleel on 2/18/14.
//  Copyright (c) 2014 ArabianDevs. All rights reserved.
//

#import "MDViewController.h"
#import "MDCustomAutoCompleteCell.h"

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
        NSArray *items = [[NSArray arrayWithContentsOfFile:path] valueForKey:@"name"];
        items = [MJAutoCompleteItem autoCompleteCellModelFromStrings:items];
        // then assign them to the trigger
        MJAutoCompleteTrigger *trigger = [[MJAutoCompleteTrigger alloc] initWithDelimiter:@"#"
                                                                        autoCompleteItems:items];
        
        [self.autoCompleteMgr addAutoCompleteTrigger:trigger];
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

#pragma mark - UITextView delegate methods -

- (void)textViewDidChange:(UITextView *)textView
{
    [self.autoCompleteMgr processString:textView.text];
}

#pragma mark - MJAutoCompleteMgr Delegate methods -

- (void)autoCompleteManager:(MJAutoCompleteManager *)acManager shouldUpdateToText:(NSString *)newText
{
    [self.textView setText:newText];
}

@end
