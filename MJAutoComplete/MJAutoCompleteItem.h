//
//  MJAutoCompleteItem.h
//  MJAutoCompleteDemo
//
//  Created by Mazyad Alabduljaleel on 11/10/13.
//  Copyright (c) 2013 ArabianDevs. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
    CLASS DESCRIPTION:
    ==================
    
        This class represents an item displayed in the autoComplete 
    list. An item must have a string set, which will is the autoComplete 
    option shown to the user. 
 
        Optionally, the image property can be set, and that will populate 
    the tableViewCell image with the image.
        
        Alternatively, the imageURL can be set, and retrieval of the image
    can be done at a later time. 
 
        Finally, you can set the placeholder string to the name of a 
    placeholder image located in the main bundle, and it will be used while
    the image property is nil.
 
 */

@interface MJAutoCompleteItem : NSObject
/* You can specify the string that autoCompletes different from the string that is shown in the UI */
@property (strong, nonatomic) NSString *autoCompleteString;
@property (strong, nonatomic) NSString *displayedString;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString* placeholder;
// for convenience:
+ (NSArray *)autoCompleteCellModelFromStrings:(NSArray *)strings;

@end
