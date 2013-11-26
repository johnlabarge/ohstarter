//
//  HealthinessSlider.m
//  OHStarter
//
//  Created by John La Barge on 11/23/13.
//  Copyright (c) 2013 John La Barge. All rights reserved.
//

#import "TickSlider.h"
@interface TickSlider()
@property (nonatomic, strong) NSArray *minimumImages;
@end
@implementation TickSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];

    }
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}



-(void) setup
{
    self.value = 0;
    self. minimumImages = @[  [UIImage imageNamed:@"tick_min_slider_1"],
                              [UIImage imageNamed:@"tick_min_slider_1"],
                             [UIImage imageNamed:@"tick_min_slider_2"],
                             [UIImage imageNamed:@"tick_min_slider_3"],
                             [UIImage imageNamed:@"tick_min_slider_4"],
                             [UIImage imageNamed:@"tick_min_slider_5"]];

    [self setMaximumTrackImage:[UIImage imageNamed:@"tick_slider_base_big"] forState:UIControlStateNormal];
    [self setMinimumTrackImage:[[self.minimumImages objectAtIndex:0] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 2, 0, 2)] forState:UIControlStateNormal];

  [self addTarget:self action:@selector(snapToTick) forControlEvents:UIControlEventTouchUpInside];
}

-(void) updateMinimumTrackImageForValue:(NSInteger)val
{
    UIImage * image = [self.minimumImages objectAtIndex:val];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 2, 0, 0)];
     /*use the left hand image based on the value of the slider */
    [self setMinimumTrackImage:image forState:UIControlStateNormal];
}


-(void) snapToTick
{
    //Snap the value
    NSInteger intVal = round(self.value);
    [self setValue:intVal animated:NO];
    
    //update the left hand side image
    [self updateMinimumTrackImageForValue:intVal];
}


@end
