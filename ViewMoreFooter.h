//
//  ViewMoreTableCell.h
//  OHStarter
//
//  Created by John La Barge on 11/24/13.
//  Copyright (c) 2013 John La Barge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpandableView.h"

@interface ViewMoreFooter : UIView
@property (strong, nonatomic) IBOutlet UIButton *viewImageButton;
@property (nonatomic, weak) id <ExpandableView> expandableTableView;
@property (strong, nonatomic) IBOutlet UIButton *viewButton;
-(void) setExpandedState:(BOOL)expanded;
@end
