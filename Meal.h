//
//  Meal.h
//  OHStarter
//
//  Created by John La Barge on 11/22/13.
//  Copyright (c) 2013 John La Barge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Meal : NSObject
@property (nonatomic, strong) NSMutableArray * foodItems;
@property (nonatomic, strong) NSString * name;
@property (readwrite) NSInteger healthiness;
@property (readwrite) NSInteger size;


@end
