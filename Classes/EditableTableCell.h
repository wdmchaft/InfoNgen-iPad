//
//  TextFormCell.h
//  Untitled
//
//  Created by Robert Stewart on 2/22/10.
//  Copyright 2010 InfoNgen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EditableTableCell : UITableViewCell
{
    UITextField * textField;
}

@property (nonatomic, retain) UITextField *textField;

@end