//
//  ohstarterViewController.h
//  OHStarter
//
//  Created by John La Barge on 11/22/13.
//  Copyright (c) 2013 John La Barge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meal.h"
#import "ExpandableTableView.h"

@interface MealFormViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong) Meal * meal;
@property (strong, nonatomic) IBOutlet UITextField *itemTextField;
@property (strong, nonatomic) IBOutlet ExpandableTableView *foodTable;
@property (strong, nonatomic) IBOutlet UISlider *healthSlider;
@property (strong, nonatomic) IBOutlet UIView *slidersView;
@property (strong, nonatomic) IBOutlet UIButton *addButton;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) IBOutlet UILabel *healthinessSliderLabel;
@end


