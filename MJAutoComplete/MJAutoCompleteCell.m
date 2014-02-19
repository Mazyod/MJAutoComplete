//
//  MJAutoCompleteCell.m
//  MJAutoCompleteDemo
//
//  Created by Mazyad Alabduljaleel on 11/11/13.
//  Copyright (c) 2013 ArabianDevs. All rights reserved.
//

#import "MJAutoCompleteCell.h"

@implementation MJAutoCompleteCell

- (void)dealloc
{
    [self.autoCompleteItem removeObserver:self forKeyPath:@"image"];
}

- (void)setAutoCompleteItem:(MJAutoCompleteItem *)autoCompleteItem
{
    [self.autoCompleteItem removeObserver:self forKeyPath:@"image"];
    
    _autoCompleteItem = autoCompleteItem;
    // the image may not be readily available
    [autoCompleteItem addObserver:self
                       forKeyPath:@"image"
                          options:0
                          context:NULL];
    
    self.textLabel.text = autoCompleteItem.displayedString;
    
    if (autoCompleteItem.image)
    {
        self.imageView.image = autoCompleteItem.image;
    }
    else if (autoCompleteItem.placeholder)
    {
        self.imageView.image = [UIImage imageNamed:autoCompleteItem.placeholder];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.autoCompleteItem && [keyPath isEqual:@"image"])
    {
        // makes sure we update the views on the main thread
        dispatch_async(dispatch_get_main_queue(), ^
        {
            self.imageView.image = self.autoCompleteItem.image;
            [self setNeedsLayout];
        });
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
