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
@synthesize lastIndexPath;

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
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    if (indexPath.row == 0) {
        cell.textLabel.text = NSLocalizedString(@"Weeking Day", nil);
    }else{
        cell.textLabel.text = [self.arrWeeks objectAtIndex:indexPath.row - 1];
    }
    
    if (indexPath.row == 1 || indexPath.row == 7) {
        cell.textLabel.textColor = [UIColor redColor];
    }
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    //多选
    UITableViewCell *Cell = [tableView cellForRowAtIndexPath:indexPath];
    if (Cell.accessoryType != UITableViewCellAccessoryCheckmark) {
        Cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        [self.arrSelectedWeek addObject:[self.arrWeeks objectAtIndex:indexPath.row]];
        
        NSLog(@"selec = %@", self.arrSelectedWeek);
    }else{
        Cell.accessoryType = UITableViewCellAccessoryNone;
        [self.arrSelectedWeek removeObjectAtIndex:indexPath.row];
        NSLog(@"selec2 = %@", self.arrSelectedWeek);
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
