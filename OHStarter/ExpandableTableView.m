//
//  ExpandableTableView.m
//  OHStarter
//
//  Created by John La Barge on 11/24/13.
//  Copyright (c) 2013 John La Barge. All rights reserved.
//

#import "ExpandableTableView.h"

@interface ExpandableTableView()
@property (nonatomic, assign) BOOL expanded;
@property (nonatomic, assign) CGFloat expandedAmount;
@end

@implementation ExpandableTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(BOOL) isExpanded
{
    return _expanded;
}


-(void) expand
{
    if (!self.expanded){
        self.expanded = YES;
        [self reloadData];
        CGFloat contentHeight = self.contentSize.height;
        CGFloat twoCells = self.rowHeight *2;
        CGFloat overlap = contentHeight - self.frame.size.height;
        
        if (overlap > twoCells) {
            overlap = twoCells;
        }
        
    
        
       [self.superview bringSubviewToFront:self]; //make sure it's in front
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = self.frame;
            frame.size.height+= overlap;
            self.frame = frame;
            
        } completion:^(BOOL finished) {
            if (finished) {
              
                self.expandedAmount = overlap;
            }
        }];
    }
}

-(void) retract
{
    if (self.expanded) {
        self.expanded = NO;
        [self reloadData];
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height-self.expandedAmount);
            
        } completion:^(BOOL finished) {
            if (finished) {

            }
        }];
    }
}

@end
