//
//  MDViewController.h
//  MJAutoCompleteDemo
//
//  Created by Mazyad Alabduljaleel on 2/18/14.
//  Copyright (c) 2014 ArabianDevs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJAutoCompleteManager.h"

@interface MDViewController : UIViewController
<MJAutoCompleteManagerDataSource, MJAutoCompleteManagerDelegate, UITextViewDelegate>

@end
