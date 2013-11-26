//
//  ExpandableTableView.h
//  OHStarter
//
//  Created by John La Barge on 11/24/13.
//  Copyright (c) 2013 John La Barge. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ExpandableView <NSObject>
-(BOOL) isExpanded;
-(void) expand;
-(void) retract;
@end
