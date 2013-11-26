//
//  Meal.m
//  OHStarter
//
//  Created by John La Barge on 11/22/13.
//  Copyright (c) 2013 John La Barge. All rights reserved.
//

#import "Meal.h"

@implementation Meal
-(instancetype) init {
    self = [super init];
    self.foodItems = [[NSMutableArray alloc] init];
    self.size = 0;
    self.healthiness = 0;
    return self;
}
@end
