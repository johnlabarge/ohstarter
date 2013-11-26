//
//  ExpandableTableView.h
//  OHStarter
//
//  Created by John La Barge on 11/24/13.
//  Copyright (c) 2013 John La Barge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpandableView.h"

@interface ExpandableTableView : UITableView <ExpandableView>
@property (nonatomic, assign) CGFloat expandAmount;
-(void) expand;
-(void) retract;
-(BOOL) isExpanded;
@end
