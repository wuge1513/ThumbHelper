//
//  DetailViewController.m
//  ThumbHelper
//
//  Created by LiuLei on 12-4-11.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import "AlarmViewController.h"
#import "AddClockViewCell.h"
#import "ClockCell.h"
#import "AddClockViewController.h"

@implementation AlarmViewController

@synthesize tbAlarmView;
@synthesize addClockViewController;
@synthesize alarmClockCount, activatyClockCount;

#pragma mark - Managing the detail item

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Set Alarm", @"Set Alarm");
        
        //the add btn for alarm
        UIBarButtonItem *selectButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showAddClockView)];
        self.navigationItem.rightBarButtonItem = selectButtonItem;//

    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self initClockCount];
	[self updateActivityClockCount];
    
    CGRect rect = CGRectMake(0.0, 0.0, SCREEN_FRAM_WIDTH, SCREEN_FRAM_HEIGHT);
    self.tbAlarmView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    self.tbAlarmView.delegate = self;
    self.tbAlarmView.dataSource = self;
    [self.view addSubview:self.tbAlarmView];
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - action methods
- (void)setActivityClockCount:(int)count
{
	self.activatyClockCount = count;
	if(count < 0)
		self.activatyClockCount = 0;
}

- (void)restoreMainGUI
{
	//self.mainNavigationBar.topItem.leftBarButtonItem = nil;
	[self.tbAlarmView setScrollEnabled:YES];
	[self.tbAlarmView reloadData];
}

- (void)initClockCount
{
	//从NSUserDefault中读取数据,填充表格
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
	if (![userDefault objectForKey:@"ClockCount"])
		self.alarmClockCount = 0;
	else
		self.alarmClockCount = [[userDefault objectForKey:@"ClockCount"] intValue];
	self.activityClockCount = [[UIApplication sharedApplication] applicationIconBadgeNumber];
	
	if (![userDefault objectForKey:@"ActivityClockCount"])
		self.activityClockCount = 0;
	else
		self.activityClockCount = [[userDefault objectForKey:@"ActivityClockCount"] intValue];
}

- (NSString *)updateHeaderTitle
{
	return [NSString stringWithFormat:@"(Total: %d  Activity: %d)", self.alarmClockCount, self.activatyClockCount];
}

- (void)updateActivityClockCount
{
	[[UIApplication sharedApplication] setApplicationIconBadgeNumber:self.activatyClockCount];
}
- (void)showAddClockView
{
    [self showAddClockView:nil];
}
- (void)showAddClockView:(ClockCell *)sender
{
	if (self.alarmClockCount == MAXCLOCKCOUNT && sender == nil) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Clock Warning!" message:[NSString stringWithFormat:@"You can not add clock more than %d!", MAXCLOCKCOUNT] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
		return;
	}
	addClockViewController = [[AddClockViewController alloc] init];//initWithNibName:@"AddClockViewController" bundle:nil
	addClockViewController.alarmViewCopntroller = self;

    
    [self.navigationController pushViewController:addClockViewController animated:YES];
    
	CGPoint point = addClockViewController.view.center;
	point.y += self.tbAlarmView.contentOffset.y;
	addClockViewController.view.center = point;
	[self.tbAlarmView setScrollEnabled:NO];
    
	addClockViewController.clockID = self.alarmClockCount + 1;
	if (sender) {
		addClockViewController.clockState.text = (sender.clockSwitch.on == YES ? @"开启" : @"关闭");
		addClockViewController.clockTime.text = sender.clockTimeLabel.text;
		addClockViewController.clockMode.text = sender.clockModeLabel.text;
		addClockViewController.clockScene.text = sender.clockSceneLabel.text;
		addClockViewController.clockMusic.text = sender.clockMusic;
		addClockViewController.rememberTextView.text = sender.clockRemember;
		addClockViewController.clockID = sender.numberID;
	}
}

- (void)startClock:(int)clockID
{
	//首先查找以前是否存在此本地通知,若存在,则删除以前的该本地通知,
	//再重新发出新的本地通知
	
	[self shutdownClock:clockID];
	
	NSString *clockIDString = [NSString stringWithFormat:@"%d", clockID];
//	[(GeiniableClockAppDelegate *)[[UIApplication sharedApplication] delegate] postLocalNotification:clockIDString isFirst:YES];
    
}

- (void)shutdownClock:(int)clockID
{
	NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
	for(UILocalNotification *notification in localNotifications)
	{
		if ([[[notification userInfo] objectForKey:@"ActivityClock"] intValue] == clockID) {
			NSLog(@"Shutdown localNotification:%@", [notification fireDate]);
			[[UIApplication sharedApplication] cancelLocalNotification:notification];
		}
	}
}

#pragma mark - UITableView 

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.alarmClockCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;
//	if (indexPath.row == 0) {
//		cell = (AddClockViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AddClockViewCell"];
//		if (!cell) {
//			cell = [[[NSBundle mainBundle] loadNibNamed:@"AddClockViewCell" owner:self options:nil] lastObject];
//		}
//		((AddClockViewCell *)cell).alarmViewController = self;
//	}
//	else {
		cell = (ClockCell *)[tableView dequeueReusableCellWithIdentifier:@"ClockCell"];
		if (!cell) {
			cell =[[[NSBundle mainBundle] loadNibNamed:@"ClockCell" owner:self options:nil] lastObject];
		}
		((ClockCell *)cell).alarmViewController = self;
		
		NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
		NSMutableDictionary *clockDictionary = [userDefault objectForKey:[NSString stringWithFormat:@"%d", indexPath.row]];
		((ClockCell *)cell).clockSwitch.on = [[clockDictionary objectForKey:@"ClockState"] isEqualToString:@"开启"] ? YES : NO;
		((ClockCell *)cell).clockTimeLabel.text = [clockDictionary objectForKey:@"ClockTime"];
		((ClockCell *)cell).clockModeLabel.text = [clockDictionary objectForKey:@"ClockMode"];
		((ClockCell *)cell).clockSceneLabel.text = [clockDictionary objectForKey:@"ClockScene"];
		((ClockCell *)cell).clockMusic = [clockDictionary objectForKey:@"ClockMusic"];
		((ClockCell *)cell).clockRemember = [clockDictionary objectForKey:@"ClockRemember"];
		((ClockCell *)cell).numberID = indexPath.row;
		[((ClockCell *)cell) setUIFontAndColor];
	//}
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.alarmClockCount > 0) {
        return [self updateHeaderTitle];
    }
	
    return nil;
}

//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//	return [self updateHeaderTitle];
//}


							
@end
