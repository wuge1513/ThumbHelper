//
//  SetRepeatViewController.m
//  ThumbHelper
//
//  Created by LiuLei on 12-4-19.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import "SetMusicViewController.h"
#import "AddClockViewController.h"

@implementation SetMusicViewController

@synthesize delegate;
@synthesize lastIndexPath;
@synthesize strSelectedMusic;
@synthesize arrMusics;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        NSString *strSun = NSLocalizedString(@"音乐一", nil);
        NSString *strMon = NSLocalizedString(@"音乐二", nil);
        NSString *strTues = NSLocalizedString(@"音乐三", nil);
        NSString *strWed = NSLocalizedString(@"音乐四", nil);
        NSString *strThurs = NSLocalizedString(@"音乐五", nil);
        NSString *strFri = NSLocalizedString(@"音乐六", nil);
        NSString *strSat = NSLocalizedString(@"音乐七", nil);
        self.arrMusics = [[NSArray alloc] initWithObjects: strSun, strMon, strTues, strWed, strThurs, strFri, strSat, nil];

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
    return [self.arrMusics count];
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
    
    cell.textLabel.text = [self.arrMusics objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    //单选
    int newRow = [indexPath row];
    int oldRow = (self.lastIndexPath != nil) ? [self.lastIndexPath row] : -1;
    if (newRow != oldRow) {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
		
        self.strSelectedMusic = [self.arrMusics objectAtIndex:indexPath.row];
        NSLog(@"self.strSelectedMusic1 = %@", self.strSelectedMusic);
        
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath: self.lastIndexPath];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        self.lastIndexPath = indexPath;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [self.delegate setAlarmMusic:self.strSelectedMusic];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
