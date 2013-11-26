//
//  ohstarterViewController.m
//  OHStarter
//
//  Created by John La Barge on 11/22/13.
//  Copyright (c) 2013 John La Barge. All rights reserved.
//

#import "MealFormViewController.h"
#import "FoodItemTableCell.h"
#import "ViewMoreFooter.h"
@interface MealFormViewController ()
@property (nonatomic, assign) BOOL expanded;
@property (nonatomic, strong) ViewMoreFooter * tableFooter;
@end

@implementation MealFormViewController

- (void)viewDidLoad
{
 
    [super viewDidLoad];
    [self setupMeal];
    [self setupMealTitle];
   
    [self setupTableFooter];


    [self setupTableCells];
    
    [self setupPlaceholderText];
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(void) setupMealTitle
{
    self.healthinessSliderLabel.text = [NSString stringWithFormat:@"How healthy was %@?",self.meal.name];
    self.navBar.topItem.title = [self.meal.name capitalizedString];
}
-(void) setupTableFooter
{
    self.tableFooter = [[[NSBundle mainBundle] loadNibNamed:@"ViewMoreFooter" owner:self options:nil] objectAtIndex:0];
    self.tableFooter.expandableTableView = self.foodTable;
}
-(void) setupTableCells
{
    UINib * foodItemCell = [UINib  nibWithNibName:@"FoodItemTableCell" bundle:nil];
    [self.foodTable registerNib:foodItemCell forCellReuseIdentifier:@"FoodItem"];
    
}
-(void) setupPlaceholderText
{
    if ([self.itemTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        NSString * placeHolderText = self.itemTextField.placeholder;
        UIColor *color = [UIColor colorWithRed:153/255.0 green:158/255.0 blue:166/255.0 alpha:1.0];
        self.itemTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolderText attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addItem:(id)sender {
    if ([self.itemTextField isFirstResponder]) {
        [self addText];
    } else {
        [self.itemTextField becomeFirstResponder];
    }
   
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footer = nil;
    if ([self.foodTable isExpanded] || (self.meal.foodItems.count > 4)) {
        footer = self.tableFooter;
    }
    return footer;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat height = 0.0;
    if ([self.foodTable isExpanded] || (self.meal.foodItems.count > 4)) {
        height = self.foodTable.rowHeight;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    if (indexPath.section == 0)
    {
        FoodItemTableCell *foodCell =  (FoodItemTableCell *) [tableView dequeueReusableCellWithIdentifier:@"FoodItem" forIndexPath:indexPath];
        foodCell.foodName.text = [self.meal.foodItems objectAtIndex:[indexPath row]];
        cell = foodCell;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    if ([self.foodTable isExpanded] || self.meal.foodItems.count < 4)
        rows = self.meal.foodItems.count;
    else
        rows = 4;
    return rows;
}
-(void) setupMeal
{
    if (!self.meal) {
        self.meal = [[Meal alloc] init];
        self.meal.name = @"lunch";
    }
}
-(void) addText
{
    if (self.itemTextField.text) {
        [self.meal.foodItems addObject:self.itemTextField.text];
        [self.foodTable reloadData];
        [self.itemTextField resignFirstResponder];
        self.itemTextField.text = nil;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self addText];
    return YES;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
        return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if ((editingStyle == UITableViewCellEditingStyleDelete) && (self.meal.foodItems.count > row)) {
        [self.meal.foodItems removeObjectAtIndex:indexPath.row];
        [self.foodTable reloadData];
    }
    
}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.5 animations:^{
        self.addButton.center = CGPointMake(self.addButton.center.x+250, self.addButton.center.y);
        
    }];
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.5 animations:^{
        self.addButton.center = CGPointMake(self.addButton.center.x-250, self.addButton.center.y);
    }];
}

- (IBAction)sliderChanged:(id)sender {
    self.meal.healthiness = self.healthSlider.value;
}
@end
