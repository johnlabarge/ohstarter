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
@property (nonatomic, strong) NSMutableDictionary * itemsBeingEdited;
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
    self.itemsBeingEdited = [[NSMutableDictionary alloc] initWithCapacity:10];
    
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

-(void) setupMeal
{
    if (!self.meal) {
        self.meal = [[Meal alloc] init];
        self.meal.name = @"lunch";
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

-(void) addText
{
    if (self.itemTextField.text) {
        [self.meal.foodItems addObject:self.itemTextField.text];
        [self.foodTable reloadData];
        [self.itemTextField resignFirstResponder];
        self.itemTextField.text = nil;
    }
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    if (indexPath.section == 0)
    {
        NSUInteger index = indexPath.row;
        NSString * foodItem = [self.meal.foodItems objectAtIndex:index];
        FoodItemTableCell *foodCell =  (FoodItemTableCell *) [tableView dequeueReusableCellWithIdentifier:@"FoodItem" forIndexPath:indexPath];
        foodCell.foodName.text = foodItem;
        foodCell.parentTable = self.foodTable;
        foodCell.isEditing = [self isEditingItem:index];
        


        cell = foodCell;
    }
    return cell;
}

-(BOOL) isEditingItem:(NSInteger)index
{
    NSNumber * obj = [self.itemsBeingEdited objectForKey:[NSNumber numberWithInt:index]];
    return (obj != nil);
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
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{       NSInteger index = indexPath.row;
        [self.meal.foodItems removeObjectAtIndex:index];
        [self.itemsBeingEdited removeObjectForKey:[NSNumber numberWithInteger:indexPath.row]];
        [self.foodTable reloadData];
}

#pragma mark UITableViewDelegate
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


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

-(void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.itemsBeingEdited setObject:[NSNumber numberWithBool:YES] forKey:[NSNumber numberWithInteger:indexPath.row]];
}

-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.itemsBeingEdited removeObjectForKey:[NSNumber numberWithInteger:indexPath.row]];
}

#pragma mark UITextFieldDelegate
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


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self addText];
    return YES;
}

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark slider action
- (IBAction)sliderChanged:(id)sender {
    self.meal.healthiness = self.healthSlider.value;
}
@end
