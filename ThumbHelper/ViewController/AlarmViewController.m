//
//  DetailViewController.m
//  ThumbHelper
//
//  Created by LiuLei on 12-4-11.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import "AlarmViewController.h"
#import "AddClockViewController.h"
#import "Utility.h"

@implementation AlarmViewController

@synthesize doneState;
@synthesize tbAlarmView;
@synthesize addClockViewController;
@synthesize alarmClockCount, activatyClockCount;

//Cell content
@synthesize lblAlarmClockTime, lblAlarmClockLabel, lblAlarmClockRepeat;
@synthesize strAlarnClockTime, strAlarmClockLabel, strAlarmClockRepeat;
@synthesize numberID;
@synthesize arrAlarmClock;
@synthesize alarmSwitch, isAlarmOn;

#pragma mark - Managing the detail item

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //self.navigationController.navigationBar.barStyle = UIBarStyleBlack; 
        self.title = NSLocalizedString(@"Add Alarm", @"Add Alarm");
        
        //the add btn for alarm
        UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showAddClockView)];
        self.navigationItem.rightBarButtonItem = addButtonItem;//
        
        UIBarButtonItem *editButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(actionEdit)];
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
    
    CGRect rect = CGRectMake(0.0, 0.0, SCREEN_FRAM_WIDTH, SCREEN_FRAM_HEIGHT - 20.0 - 44.0 - 49.0);
    self.tbAlarmView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    self.tbAlarmView.delegate = self;
    self.tbAlarmView.dataSource = self;
    [self.view addSubview:self.tbAlarmView];
    
}

- (void)btnAction
{
    //设置定时器
    [self startClock:self.alarmClockCount];
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
    
    //设置定时器
    //[self startClock:self.alarmClockCount];
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
	return [NSString stringWithFormat:@"Total: %d", self.alarmClockCount];
}

- (void)updateActivityClockCount
{
	[[UIApplication sharedApplication] setApplicationIconBadgeNumber:self.activatyClockCount];
}

- (void)showAddClockView
{
    [self showAddClockView:nil index:0];
}


- (void)actionEdit
{
    self.doneState =! self.doneState;
    
	if (doneState) {
		[self.tbAlarmView setEditing:YES animated:YES];
        self.alarmSwitch.hidden = YES;
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(actionEdit)];
        
        for (id cellX in [self.tbAlarmView subviews]) {
            if ([[[cellX class] description] isEqualToString:@"UITableViewCell"]) {
                
                for (UISwitch *swTmp in [[cellX contentView] subviews]){ 
                    if ([[[swTmp class] description] isEqualToString:@"UISwitch"]) { 
                        
                        [UIView beginAnimations:@"animation" context:nil];
                        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:swTmp cache:NO];
               
                        [UIView setAnimationDuration:0.7];
                        swTmp.hidden = YES;
                        [UIView commitAnimations];
                        break;
                    }
                }
            }
        }
        
	}else {
        
		[self.tbAlarmView setEditing:NO animated:YES];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(actionEdit)];
        
        for (id cellX in [self.tbAlarmView subviews]) {
            if ([[[cellX class] description] isEqualToString:@"UITableViewCell"]) {
               
                for (UISwitch *swTmp in [[cellX contentView] subviews]){ 
                    if ([[[swTmp class] description] isEqualToString:@"UISwitch"]) { 
                        [UIView beginAnimations:@"animation" context:nil];
                        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:swTmp cache:NO];
                        //[UIView setAnimationDelay:0.2];
                        [UIView setAnimationDuration:0.7];
                        swTmp.hidden = NO;
                        [UIView commitAnimations];
                        break;
                    }
                }
            }
        }
    }
}
- (void)showAddClockView:(NSDictionary *)dic index:(NSInteger)idx
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
        addClockViewController.intAlarmIndex = idx;
        addClockViewController.alarmClockID = self.alarmClockCount;
        addClockViewController.dicAlarmClock = dic;
	}else{//新建闹铃
        addClockViewController.isAddNewAlarm = YES;
        //[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isAddNewAlarm"];
        addClockViewController.alarmClockID = self.alarmClockCount + 1;
    }
    
    [self.navigationController pushViewController:addClockViewController animated:YES];
}

- (void)startClock:(int)clockID
{
    
	//首先查找以前是否存在此本地通知,若存在,则删除以前的该本地通知,再重新发出新的本地通知
    [self shutdownClock:clockID]; 
    NSString *clockIDString = [NSString stringWithFormat:@"%d", clockID];
    NSLog(@"clockIDString = %@", clockIDString);
    [self postLocalNotification:clockIDString isFirst:YES];

}

- (void)shutdownClock:(int)clockID
{
	NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
	for(UILocalNotification *notification in localNotifications)
	{
       NSInteger index = [[[notification userInfo] objectForKey:@"ActivatyClock"] intValue]; 
        NSLog(@"关闭定时：%d",index);
		if (index == clockID) {
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
    return 58.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
	
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier://
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
        
        CGRect lblRectLabel = CGRectMake(80.0, 12.0, 150.0, 20.0);
        self.lblAlarmClockLabel = [[UILabel alloc] initWithFrame:lblRectLabel];
        self.lblAlarmClockLabel.backgroundColor = lblbbColor;
        self.lblAlarmClockLabel.font = [UIFont systemFontOfSize:16.0];
        
        CGRect lblRectRepeat = CGRectMake(8.0, 36.0, 200.0, 20.0);
        self.lblAlarmClockRepeat = [[UILabel alloc] initWithFrame:lblRectRepeat];
        self.lblAlarmClockRepeat.backgroundColor = lblbbColor;
        self.lblAlarmClockRepeat.font = [UIFont systemFontOfSize:12.0];
        
        self.lblAlarmClockTime.text = [dic objectForKey:@"ClockTime"];
        self.lblAlarmClockLabel.text = [dic objectForKey:@"ClockLabel"];
        
        //显示本地化字符串
        NSString *strLocal = @"";
        NSString *str = [dic objectForKey:@"ClockRepeat"];
        NSArray *arrTemp = [str componentsSeparatedByString:@" "];
        for (NSInteger i = 0; i < [arrTemp count]; i++) {
            NSString *strLocalTmp = @"";
            NSString *strTmp = [arrTemp objectAtIndex:i];
            strLocalTmp = [Utility getLocalString:strTmp];
            
            strLocal = [strLocal stringByAppendingFormat:@" %@", strLocalTmp];
            // strLocal = [strLocal substringFromIndex:1];
        }
        self.lblAlarmClockRepeat.text = strLocal;
        
        [cell.contentView addSubview:self.lblAlarmClockTime];
        [cell.contentView addSubview:self.lblAlarmClockLabel];
        [cell.contentView addSubview:self.lblAlarmClockRepeat];
        
        self.alarmSwitch = [[UISwitch alloc] init];
        self.alarmSwitch.center = CGPointMake(270.0, 29.0);
        self.alarmSwitch.tag = indexPath.row + 1000;
        [self.alarmSwitch setOn:NO];
        [self.alarmSwitch addTarget:self action:@selector(actionAlarmSwitch:) forControlEvents:UIControlEventValueChanged];
        [cell.contentView addSubview:self.alarmSwitch];
        

    }
    
	return cell;
}

- (void)actionAlarmSwitch:(id)sender
{
    UISwitch *sw = (UISwitch *)sender;
    
//    for (id cellX in [self.tbAlarmView subviews]) {
//        if ([[[cellX class] description] isEqualToString:@"UITableViewCell"]) {
//            NSLog(@"xxx = %@", [[cellX class] description]);
//            for (UISwitch *swTmp in [[cellX contentView] subviews]){ 
//                if ([[[swTmp class] description] isEqualToString:@"UISwitch"]) { 
//                    NSLog(@"yyy = %@", [[swTmp class] description]);
//                    if (swTmp.tag == sw.tag) {
//                        NSLog(@"123");
//                        break;
//                    }
//                }
//            }
//        }
//    }
    


    if (sw.on == YES) {
        NSLog(@"开启%d", sw.tag - 1000 + 1);
        [self startClock:sw.tag - 1000 + 1];
    }else{
        NSLog(@"关闭%d", sw.tag - 1000 + 1);
        [self shutdownClock:sw.tag - 1000 + 1];
    }

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
    [self showAddClockView:dic index:indexPath.row + 1];
}

-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
	if(self.doneState){
		return YES;
	}
	return NO;
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

#pragma mark - 设定闹铃
- (void)postLocalNotification:(NSString *)clockID isFirst:(BOOL)flag
{
	//-----获取闹钟数据---------------------------------------------------------
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
	NSMutableDictionary *clockDictionary = [userDefault objectForKey:clockID];
    NSLog(@"clockDictionary = %@", clockDictionary);
	
	NSString *clockTime = [clockDictionary objectForKey:@"ClockTime"];
    NSLog(@"clockTime = %@", clockTime);
    
    NSString *str = [clockDictionary objectForKey:@"ClockRepeat"];
    NSArray *array = [str componentsSeparatedByString:@" "];
    NSLog(@"array = %@", array);
    
	NSString *clockMusic = [clockDictionary objectForKey:@"ClockMusic"];
    NSLog(@"clockMusic = %@", clockMusic);
    
    NSString *ClockLabelText = [clockDictionary objectForKey:@"ClockLabel"];
	NSString *clockRemember = ClockLabelText;
    NSLog(@"clockRemember = %@", clockRemember);
    
	//-----组建本地通知的fireDate-----------------------------------------------
	
	NSArray *clockTimeArray = [clockTime componentsSeparatedByString:@":"];
	NSDate *dateNow = [NSDate date];
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps = [[NSDateComponents alloc] init];
	//[calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    //[comps setTimeZone:[NSTimeZone timeZoneWithName:@"CMT"]];
	NSInteger unitFlags = NSEraCalendarUnit | 
	NSYearCalendarUnit | 
	NSMonthCalendarUnit | 
	NSDayCalendarUnit | 
	NSHourCalendarUnit | 
	NSMinuteCalendarUnit | 
	NSSecondCalendarUnit | 
	NSWeekCalendarUnit | 
	NSWeekdayCalendarUnit | 
	NSWeekdayOrdinalCalendarUnit | 
	NSQuarterCalendarUnit;
	
	comps = [calendar components:unitFlags fromDate:dateNow];
	[comps setHour:[[clockTimeArray objectAtIndex:0] intValue]];
	[comps setMinute:[[clockTimeArray objectAtIndex:1] intValue]];
	[comps setSecond:0];
	
	//------------------------------------------------------------------------
	Byte weekday = [comps weekday];
    NSLog(@"weekday = %d", weekday);

    
	Byte i = 0;
	Byte j = 0;
	int days = 0;
	int	temp = 0;
	Byte count = [array count] - 1;
    NSLog(@"count = %d", count);
	Byte clockDays[7];
	
	NSArray *tempWeekdays = [NSArray arrayWithObjects:@"Sun", @"Mon", @"Tues", @"Wed", @"Thurs", @"Fri", @"Sat", nil];
	//查找设定的周期模式
	for (i = 0; i < count; i++) {
		for (j = 0; j < 7; j++) {
			if ([[array objectAtIndex:i] isEqualToString:[tempWeekdays objectAtIndex:j]]) {
				clockDays[i] = j + 1;
                NSLog(@"====%d", clockDays[i]);
				break;
			}
		}
	}
	
	for (i = 0; i < count; i++) {
	    temp = clockDays[i] - weekday;
		days = (temp >= 0 ? temp : temp + 7);
		NSDate *newFireDate = [[calendar dateFromComponents:comps] dateByAddingTimeInterval:3600 * 24 * days];
		
		UILocalNotification *newNotification = [[UILocalNotification alloc] init];
		if (newNotification) {
			newNotification.fireDate = newFireDate;
			newNotification.alertBody = clockRemember;
			newNotification.soundName = UILocalNotificationDefaultSoundName;//clockMusic;
			newNotification.alertAction = @"查看闹钟";
			newNotification.repeatInterval = NSWeekCalendarUnit;
			NSDictionary *userInfo = [NSDictionary dictionaryWithObject:clockID forKey:@"ActivatyClock"];
			newNotification.userInfo = userInfo;
			[[UIApplication sharedApplication] scheduleLocalNotification:newNotification];
		}
		NSLog(@"Post new localNotification:%@", [newNotification fireDate]);
	}
}
							
@end
