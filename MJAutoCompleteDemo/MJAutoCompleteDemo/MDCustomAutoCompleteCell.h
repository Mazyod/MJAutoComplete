//
//  MDCustomAutoCompleteCell.h
//  MJAutoCompleteDemo
//
//  Created by Mazyad Alabduljaleel on 2/19/14.
//  Copyright (c) 2014 ArabianDevs. All rights reserved.
//

#import "MJAutoCompleteCell.h"

@interface MDCustomAutoCompleteCell : MJAutoCompleteCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *censoredLabel;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@end
