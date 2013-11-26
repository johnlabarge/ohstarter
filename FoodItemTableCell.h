//
//  FoodItemTableCell.h
//  OHStarter
//
//  Created by John La Barge on 11/22/13.
//  Copyright (c) 2013 John La Barge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodItemTableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *foodName;
@property (strong, nonatomic) IBOutlet UIView *deleteView;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) void (^deleteAction)(void);
@end
