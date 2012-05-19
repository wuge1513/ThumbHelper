//
//  SetRepeatViewController.m
//  ThumbHelper
//
//  Created by LiuLei on 12-4-19.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import "SetRepeatViewController.h"


@implementation SetRepeatViewController
@synthesize arrWeeks, arrShortweeks, arrSelectedWeek, arrWorkingDay, arrLastWeeks, arrCurWeeks, arrDayEn;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        //left button go back
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(actionBack)]; 
        
        self.arrSelectedWeek = [[NSMutableArray alloc] initWithCapacity:1];
        self.arrLastWeeks = [[NSMutableArray alloc] initWithCapacity:1];
        
        //用于显示，本地化语言
        NSString *strSun = NSLocalizedString(@"Sunday", nil);
        NSString *strMon = NSLocalizedString(@"Monday", nil);
        NSString *strTues = NSLocalizedString(@"Tuesday", nil);
        NSString *strWed = NSLocalizedString(@"Wednesday", nil);
        NSString *strThurs = NSLocalizedString(@"Thursday", nil);
        NSString *strFri = NSLocalizedString(@"Friday", nil);
        NSString *strSat = NSLocalizedString(@"Saturday", nil);
        self.arrWeeks = [[NSArray alloc] initWithObjects: strSun, strMon, strTues, strWed, strThurs, strFri, strSat, nil];
        
        //用于存储 通用英语
        NSString *strSuns = @"Sun";//NSLocalizedString(@"Sun", nil);
        NSString *strMons = @"Mon";//NSLocalizedString(@"Mon", nil);
        NSString *strTuess = @"Tues";//NSLocalizedString(@"Tues", nil);
        NSString *strWeds = @"Wed";//NSLocalizedString(@"Wed", nil);
        NSString *strThurss = @"Thurs";//NSLocalizedString(@"Thurs", nil);
        NSString *strFris = @"Fri";//NSLocalizedString(@"Fri", nil);
        NSString *strSats = @"Sat";//NSLocalizedString(@"Sat", nil);
        self.arrShortweeks = [[NSArray alloc] initWithObjects:strSuns, strMons, strTuess, strWeds, strThurss, strFris, strSats, nil];
        
        //下面两个暂时未使用
        self.arrDayEn = [[NSArray alloc] initWithObjects:@"Sun", @"Mon", @"Tues", @"Wed", @"Thurs", @"Fri", @"Sat", nil];
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
    //NSLog(@"self.arrSelectWeeks = %@",self.arrSelectedWeek);
    NSLog(@"self.arrLastWeeks = %@", self.arrLastWeeks);
    self.arrCurWeeks = [[NSMutableArray alloc] initWithArray:self.arrLastWeeks];
    NSLog(@"self.arrCurWeeks = %@", self.arrCurWeeks);
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

- (void)actionBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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

    
    cell.textLabel.text = [self.arrWeeks objectAtIndex:indexPath.row];
    
    for (NSString *str in self.arrCurWeeks) {
        if ([[self.arrShortweeks objectAtIndex:indexPath.row] isEqualToString:str]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [self.arrSelectedWeek removeAllObjects];
            //选择的星期
            [self.arrSelectedWeek addObjectsFromArray:self.arrCurWeeks];
            //本地化
            [[NSUserDefaults standardUserDefaults] setObject:self.arrSelectedWeek forKey:@"Repeat"];
        }
    }
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
    if (indexPath.row == 0 || indexPath.row == 6) {
        cell.textLabel.textColor = [UIColor redColor];
    }
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    UITableViewCell *Cell = [tableView cellForRowAtIndexPath:indexPath];
        
    if (Cell.accessoryType == UITableViewCellAccessoryNone) {//如果未标记，则标记
        Cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.arrCurWeeks addObject:[self.arrShortweeks objectAtIndex:indexPath.row]];
    }else{//如果已经标记，则去除标记
        Cell.accessoryType = UITableViewCellAccessoryNone;
        NSString *strTmp = [self.arrShortweeks objectAtIndex:indexPath.row];
        [self.arrCurWeeks removeObject:strTmp];
    }
    
    [self.arrSelectedWeek removeAllObjects];
    //选择的星期
    [self.arrSelectedWeek addObjectsFromArray:self.arrCurWeeks];
    //本地化
    [[NSUserDefaults standardUserDefaults] setObject:self.arrSelectedWeek forKey:@"Repeat"];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
