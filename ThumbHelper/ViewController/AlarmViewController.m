//
//  DetailViewController.m
//  ThumbHelper
//
//  Created by LiuLei on 12-4-11.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import "AlarmViewController.h"
#import "AddClockViewController.h"

@implementation AlarmViewController

@synthesize doneState;
@synthesize tbAlarmView;
@synthesize addClockViewController;
@synthesize alarmClockCount, activatyClockCount;

//Cell content
@synthesize lblAlarmClockTime, lblAlarmClockLabel, lblAlarmClockRepeat;
@synthesize strAlarnClockTime, strAlarmClockLabel, strAlarmClockRepeat;
@synthesize numberID, alarmClockSwitch;
@synthesize arrAlarmClock;

#pragma mark - Managing the detail item

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Add Alarm", @"Add Alarm");
        
        //the add btn for alarm
        UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showAddClockView)];
        self.navigationItem.rightBarButtonItem = addButtonItem;//
        
//        UIBarButtonItem *editButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(actionEdit)];
        UIBarButtonItem *editButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(actionBack)];
        
        self.navigationItem.leftBarButtonItem = editButtonItem;

    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)initData
{
    self.arrAlarmClock = [[NSMutableArray alloc] initWithCapacity:1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self initData];
    [self initClockCount];
	[self updateActivityClockCount];
    
    
    
    CGRect rect = CGRectMake(0.0, 0.0, SCREEN_FRAM_WIDTH, SCREEN_FRAM_HEIGHT);
    self.tbAlarmView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
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
    [self restoreMainGUI];
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
    [self.arrAlarmClock removeAllObjects];
    for (NSInteger i = 1; i <= self.alarmClockCount; i++) {
        NSString *alarmKey = [NSString stringWithFormat:@"%d", i];
        NSLog(@"sss %d = %@", i, [[NSUserDefaults standardUserDefaults] objectForKey:alarmKey]);
        [self.arrAlarmClock addObject:[[NSUserDefaults standardUserDefaults] objectForKey:alarmKey]];
    }
    
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
	self.activatyClockCount = [[UIApplication sharedApplication] applicationIconBadgeNumber];
	
	if (![userDefault objectForKey:@"ActivatyClockCount"])
		self.activatyClockCount = 0;
	else
		self.activatyClockCount = [[userDefault objectForKey:@"ActivatyClockCount"] intValue];
}

- (NSString *)updateHeaderTitle
{
	return [NSString stringWithFormat:@"Total: %d  Activity: %d", self.alarmClockCount, self.activatyClockCount];
}

- (void)updateActivityClockCount
{
	[[UIApplication sharedApplication] setApplicationIconBadgeNumber:self.activatyClockCount];
}

- (void)showAddClockView
{
    [self showAddClockView:nil];
}

- (void)actionBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)actionEdit
{
    self.doneState =! self.doneState;
    
	if (doneState) {
		[self.tbAlarmView setEditing:YES animated:YES];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(actionEdit)];
	}else {
		[self.tbAlarmView setEditing:NO animated:YES];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(actionEdit)];
    }
}
- (void)showAddClockView:(NSDictionary *)dic
{
    
    //判断闹铃个数是否达到最大值
	if (self.alarmClockCount == MAXCLOCKCOUNT) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Clock Warning!" message:[NSString stringWithFormat:@"You can not add clock more than %d!", MAXCLOCKCOUNT] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
		return;
	}
	addClockViewController = [[AddClockViewController alloc] init];
	addClockViewController.alarmViewCopntroller = self;
    addClockViewController.isFromAddAlarm = YES;
    //更新闹铃
	if ([dic count] > 0) {
        addClockViewController.alarmClockID = self.alarmClockCount;
        addClockViewController.dicAlarmClock = dic;
	}else{//新建闹铃
        addClockViewController.isAddNewAlarm = YES;
        addClockViewController.alarmClockID = self.alarmClockCount + 1;
    }
    
    [self.navigationController pushViewController:addClockViewController animated:YES];
}

- (void)startClock:(int)clockID
{
	//首先查找以前是否存在此本地通知,若存在,则删除以前的该本地通知,
	//再重新发出新的本地通知
	
	[self shutdownClock:clockID];
	//NSString *clockIDString = [NSString stringWithFormat:@"%d", clockID];
//	[(GeiniableClockAppDelegate *)[[UIApplication sharedApplication] delegate] postLocalNotification:clockIDString isFirst:YES];
    
}

- (void)shutdownClock:(int)clockID
{
	NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
	for(UILocalNotification *notification in localNotifications)
	{
		if ([[[notification userInfo] objectForKey:@"ActivatyClock"] intValue] == clockID) {
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
    NSLog(@"===%d", self.alarmClockCount);
    return self.alarmClockCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
							 SimpleTableIdentifier];
    //if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SimpleTableIdentifier];
    //}
    if ([self.arrAlarmClock count] > 0) {
        NSDictionary *dic = [self.arrAlarmClock objectAtIndex:indexPath.row];
        
        //Cell content
        UIColor *lblbbColor = [UIColor clearColor];
        
        CGRect lblRectTime = CGRectMake(10.0, 0.0, 80.0, 44.0);
        self.lblAlarmClockTime = [[UILabel alloc] initWithFrame:lblRectTime];
        self.lblAlarmClockTime.backgroundColor = lblbbColor;
        self.lblAlarmClockTime.font = [UIFont boldSystemFontOfSize:25.0];
        
        CGRect lblRectLabel = CGRectMake(100.0, 0.0, 150.0, 20.0);
        self.lblAlarmClockLabel = [[UILabel alloc] initWithFrame:lblRectLabel];
        self.lblAlarmClockLabel.backgroundColor = lblbbColor;
        self.lblAlarmClockLabel.font = [UIFont systemFontOfSize:16.0];
        
        CGRect lblRectRepeat = CGRectMake(100.0, 22.0, 180.0, 20.0);
        self.lblAlarmClockRepeat = [[UILabel alloc] initWithFrame:lblRectRepeat];
        self.lblAlarmClockRepeat.backgroundColor = lblbbColor;
        self.lblAlarmClockRepeat.font = [UIFont systemFontOfSize:13.0];
        
        self.lblAlarmClockTime.text = [dic objectForKey:@"ClockTime"];
        self.lblAlarmClockLabel.text = [dic objectForKey:@"ClockLabel"];
        self.lblAlarmClockRepeat.text = [dic objectForKey:@"ClockRepeat"];
        
        [cell.contentView addSubview:self.lblAlarmClockTime];
        [cell.contentView addSubview:self.lblAlarmClockLabel];
        [cell.contentView addSubview:self.lblAlarmClockRepeat];
    }
    
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
//	return @"Footer";
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.arrAlarmClock objectAtIndex:indexPath.row];
    [self showAddClockView:dic];
}

-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//	if(self.doneState){
		return YES;
//	}
//	return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSInteger index = indexPath.row + 1;
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];

        //闹铃index更改
        for (NSInteger i = index; i <= self.alarmClockCount; i++) {
            NSString *curAlarmClockID = [NSString stringWithFormat:@"%d", i];
            NSString *nxAlarmClockID = [NSString stringWithFormat:@"%d", i + 1];
            
            NSMutableDictionary *dic = [userDefault objectForKey:nxAlarmClockID];
            [userDefault removeObjectForKey:curAlarmClockID];
            [userDefault setObject:dic forKey:curAlarmClockID];
        }
        [userDefault setObject:[NSNumber numberWithInteger:--self.alarmClockCount] forKey:@"ClockCount"];
        
        //剩余的闹铃重新存入数组
        [self.arrAlarmClock removeAllObjects];
        for (NSInteger i = 1; i <= self.alarmClockCount; i++) {
            NSString *alarmKey = [NSString stringWithFormat:@"%d", i];
            [self.arrAlarmClock addObject:[[NSUserDefaults standardUserDefaults] objectForKey:alarmKey]];
        }
        [self.tbAlarmView reloadData];
        // Delete the row from the data source        
		//[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];

	}   
}




							
@end
