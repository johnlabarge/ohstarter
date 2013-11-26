//
//  FoodItemTableCell.m
//  OHStarter
//
//  Created by John La Barge on 11/22/13.
//  Copyright (c) 2013 John La Barge. All rights reserved.
//

#import "FoodItemTableCell.h"

@interface FoodItemTableCell()
@property (nonatomic, assign) CGPoint originalCenter;
@property (nonatomic, strong) UIPanGestureRecognizer * panRecognizer;
@property (nonatomic, assign) BOOL isEditing;
@end
@implementation FoodItemTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

-(void)awakeFromNib
{
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    
    [self.topView addGestureRecognizer:self.panRecognizer];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)panGestureAction:(id)sender {

    UIPanGestureRecognizer * panGesture = (UIPanGestureRecognizer *)sender;
    BOOL left = ([panGesture velocityInView:self.topView].x < 0);
    
    CGPoint translatedPoint = [panGesture translationInView:self.topView];
   
    if ([panGesture state] == UIGestureRecognizerStateBegan){
        self.originalCenter = self.topView.center;
    }
    if (left || self.isEditing) {
        self.topView.center=CGPointMake(translatedPoint.x+self.topView.center.x, self.topView.center.y);
    }

    if ([panGesture state] == UIGestureRecognizerStateEnded)
    {
        CGPoint newCenter;
        CGFloat deleteViewWidth = self.deleteView.frame.size.width;
        CGPoint velocity = [panGesture velocityInView:self.topView];
       
        if (velocity.x < -1.0f * deleteViewWidth) {
            newCenter = CGPointMake(self.originalCenter.x-deleteViewWidth,self.center.y);
            self.isEditing = YES;
            [self moveCell:newCenter];
        } else {
            if (self.isEditing) {
                newCenter = CGPointMake(self.originalCenter.x+deleteViewWidth, self.center.y);
                self.isEditing = NO;
                [self moveCell:newCenter];

            }
        }
    }
}
- (IBAction)delete:(id)sender {
    self.deleteAction(); 
}

-(void) moveCell:(CGPoint)newCenter
{
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:1.0f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.topView.center = newCenter;
    } completion:NULL];
}

@end
