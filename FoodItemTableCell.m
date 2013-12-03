//
//  FoodItemTableCell.m
//  OHStarter
//
//  Created by John La Barge on 11/22/13.
//  Copyright (c) 2013 John La Barge. All rights reserved.
//

#import "FoodItemTableCell.h"

@interface FoodItemTableCell()
@property (nonatomic, assign) CGPoint nonEditCenter;
@property (nonatomic, assign) CGPoint editCenter;
@property (nonatomic, strong) UIPanGestureRecognizer * panRecognizer;
@property (readonly) NSIndexPath * indexPath;
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
    self.panRecognizer.delegate = self;
    self.nonEditCenter = self.topView.center;
    self.editCenter = CGPointMake(self.topView.center.x - self.deleteView.frame.size.width, self.topView.center.y);
    [self.topView addGestureRecognizer:self.panRecognizer];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) setIsEditing:(BOOL)isEditing
{
    
    if (isEditing) {
        [self startEditing];
    } else {
        [self stopEditing];
    }
    _isEditing = isEditing;
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (IBAction)panGestureAction:(id)sender {

    
    UIPanGestureRecognizer * panGesture = (UIPanGestureRecognizer *)sender;
    BOOL panLeft = ([panGesture velocityInView:self.topView].x < 0);
    BOOL panRight = !panLeft;
    CGPoint translatedPoint = [panGesture translationInView:self.topView];
    

    if ((panLeft && !self.isEditing) || (panRight && self.isEditing)) {  //alllowed to move
        self.topView.center=CGPointMake(translatedPoint.x+self.topView.center.x, self.topView.center.y);
    }

    if ([panGesture state] == UIGestureRecognizerStateEnded)
    {
        CGFloat deleteViewWidth = self.deleteView.frame.size.width;
        CGPoint velocity = [panGesture velocityInView:self.topView];
       
        if (velocity.x < -1.0 * deleteViewWidth) {
            self.isEditing = YES;
        } else {
            self.isEditing = NO;
        }
    }
}

-(void) startEditing
{
    [self moveCell:self.editCenter];
    id <UITableViewDelegate> delegate = self.parentTable.delegate;
    [delegate tableView:self.parentTable willBeginEditingRowAtIndexPath:[self.parentTable indexPathForCell:self]];
    
}



-(void) stopEditing
{
    [self moveCell:self.nonEditCenter];
    id <UITableViewDelegate> delegate = self.parentTable.delegate;
    [delegate tableView:self.parentTable didEndEditingRowAtIndexPath:[self.parentTable indexPathForCell:self]];
    
}
- (IBAction)delete:(id)sender {
    if ([self.parentTable.dataSource respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        [self.parentTable.dataSource  tableView:self.parentTable commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:self.indexPath];
    }
    
}
-(void) moveCell:(CGPoint)newCenter
{
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:1.0f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.topView.center = newCenter;
    } completion:NULL];
}
     
-(NSIndexPath *) indexPath
{
    return [self.parentTable indexPathForCell:self];
}



@end
