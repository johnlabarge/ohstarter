//
//  ViewMoreTableCell.m
//  OHStarter
//
//  Created by John La Barge on 11/24/13.
//  Copyright (c) 2013 John La Barge. All rights reserved.
//

#import "ViewMoreFooter.h"

@interface ViewMoreFooter()
@property (nonatomic, strong) UIImage *retractImage;
@property (nonatomic, strong) UIImage *expandImage;
@end
@implementation ViewMoreFooter

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
-(instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
    
}
-(void) setup {
    self.retractImage = [UIImage imageNamed:@"retract"];
    self.expandImage  = [UIImage imageNamed:@"expand"];
}
- (IBAction)expandRetract:(id)sender {
    [self setExpandedState:![self.expandableTableView isExpanded]];
    if ([self.expandableTableView isExpanded]) {
        [self.expandableTableView retract];
    } else {
        [self.expandableTableView expand];
    }
}

-(void) setExpandedState:(BOOL)expanded
{
    if (!expanded) {
        NSLog(@"expanded state = not");
        [self.viewButton setTitle:@"View More" forState:UIControlStateNormal];
        self.viewImageButton.imageView.image = self.expandImage;
    } else {
         NSLog(@"expanded state = yes");
        [self.viewButton setTitle:@"View Less" forState:UIControlStateNormal];
        self.viewImageButton.imageView.image = self.retractImage;
    }

}

@end
