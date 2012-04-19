//
//  SetRepeatViewController.m
//  ThumbHelper
//
//  Created by LiuLei on 12-4-19.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import "SetRepeatViewController.h"


@implementation SetRepeatViewController
@synthesize arrWeeks,arrSelectedWeek, arrWorkingDay;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        self.arrSelectedWeek = [[NSMutableArray alloc] initWithCapacity:1];
        
        NSString *strSun = NSLocalizedString(@"Sunday", nil);
        NSString *strMon = NSLocalizedString(@"Monday", nil);
        NSString *strTues = NSLocalizedString(@"Tuesday", nil);
        NSString *strWed = NSLocalizedString(@"Wednesday", nil);
        NSString *strThurs = NSLocalizedString(@"Thursday", nil);
        NSString *strFri = NSLocalizedString(@"Friday", nil);
        NSString *strSat = NSLocalizedString(@"Saturday", nil);
        self.arrWeeks = [[NSArray alloc] initWithObjects: strSun, strMon, strTues, strWed, strThurs, strFri, strSat, nil];
        
        //weeking day
        self.arrWorkingDay = [[NSArray alloc] initWithObjects:strSun, strSat, nil];
        
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
//    if (section == 0) {
//        return 2;
//    }
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
//    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
//            cell.textLabel.text = NSLocalizedString(@"Weeking Day", nil);
//        }
//        if (indexPath.row == 1) {
//            cell.textLabel.text = NSLocalizedString(@"Custom", nil);
//        }
//    }
//    else{
        cell.textLabel.text = [self.arrWeeks objectAtIndex:indexPath.row];
        
        if (indexPath.row == 0 || indexPath.row == 6) {
            cell.textLabel.textColor = [UIColor redColor];
        }
    //}
    

    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.


        //多选
        UITableViewCell *Cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (Cell.accessoryType == UITableViewCellAccessoryNone) {
            Cell.accessoryType = UITableViewCellAccessoryCheckmark;
//            if (indexPath.section == 0) {
//                if (indexPath.row == 0) {
//                    [self.arrSelectedWeek addObjectsFromArray:self.arrWorkingDay];
//                }
//            }else{
                [self.arrSelectedWeek addObject:[self.arrWeeks objectAtIndex:indexPath.row]];
            //}
            
            NSLog(@"self.arrselect1 = %@", self.arrSelectedWeek);
        }else{
            Cell.accessoryType = UITableViewCellAccessoryNone;
//            if (indexPath.section == 0) {
//                if (indexPath.row == 0) {
//                    [self.arrSelectedWeek removeAllObjects];
//                }
//            }else{
                NSString *strTmp = [self.arrWeeks objectAtIndex:indexPath.row];
                [self.arrSelectedWeek removeObject:strTmp];
            //}
            
            NSLog(@"self.arrselect2 = %@", self.arrSelectedWeek);
        }

    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //单选
//    int newRow = [indexPath row];
//    int oldRow = (self.lastIndexPath != nil) ? [self.lastIndexPath row] : -1;
//    if (newRow != oldRow) {
//        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
//        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
//		
//        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath: self.lastIndexPath];
//        oldCell.accessoryType = UITableViewCellAccessoryNone;
//        lastIndexPath = indexPath;
//    }
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
