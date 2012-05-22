
//
//  AddClockViewController.m
//  GeiniableClock
//
//  Created by liu lei on 12-4-16.
//  Copyright 2012. All rights reserved.
//

#import "AddClockViewController.h"
#import "AlarmViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "LLDatePickerView.h"

#import "Utility.h"

#define kBTN_DATEPICKER_WIDTH       60.0
#define kBTN_DATEPICKER_HEIGHT      40.0
#define kDATPICKER_WIDTH            320.0
#define kDATEPICKER_HEIGHT          216.0


@implementation AddClockViewController

@synthesize alarmViewCopntroller;
@synthesize setRepeatViewController;
@synthesize setMusicViewController;

@synthesize strRepeatEN;
@synthesize btnHidden;
@synthesize strMusic;
@synthesize tbAlarmContent;
@synthesize lblLabelName, lblTimeName, lblRepeatName, lblMusicName, lblLaterName;
@synthesize lblTimeText, lblRepeatText, lblMusicText;
@synthesize tfLabelText;
@synthesize swLater;
@synthesize alarmClockID;
@synthesize blAlarmClockState;
@synthesize dpTimePicker;
@synthesize dicAlarmClock;
@synthesize isAddNewAlarm, isFromAddAlarm;
@synthesize intAlarmIndex;



// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		self.title = NSLocalizedString(@"Set AlarmClock", nil);
        
        //left button go back
        UIImage *imgBack = [UIImage imageNamed:@"icon_left.png"];
        UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnBack setImage:imgBack forState:UIControlStateNormal];
        [btnBack setFrame:CGRectMake(0.f, 0.f, imgBack.size.width, imgBack.size.height)];
        [btnBack addTarget:self action:@selector(backToMainUI:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
        self.navigationItem.leftBarButtonItem = backButtonItem;
        

        //right button save data
        
        UIImage *imgSave = [UIImage imageNamed:@"icon_check.png"];
        UIButton *btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btnSave setImage:imgSave forState:UIControlStateNormal];
        [btnSave setFrame:CGRectMake(0.f, 0.f, imgSave.size.width, imgSave.size.height)];
        [btnSave addTarget:self action:@selector(saveClockData:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnSave];
        self.navigationItem.rightBarButtonItem = saveButtonItem;
    
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
   [super viewWillAppear:animated];
    
    if (self.isFromAddAlarm) {
        self.isFromAddAlarm = NO;
        if (self.isAddNewAlarm) {
            //self.tfLabelText.text = @"None";
            self.lblRepeatText.text = @"Never";
            self.lblMusicText.text = @"None";
        }else{
            if ([self.dicAlarmClock count] > 0) {
                
                self.tfLabelText.text = [self.dicAlarmClock objectForKey:@"ClockLabel"];
                self.lblTimeText.text = [self.dicAlarmClock objectForKey:@"ClockTime"];
                self.lblMusicText.text = [self.dicAlarmClock objectForKey:@"ClockMusic"];
                
                //显示本地化字符串
                
                NSString *strLocalOld = @"";
                NSString *str = [self.dicAlarmClock objectForKey:@"ClockRepeat"];
                self.strRepeatEN = str;
                NSArray *arrTemp = [str componentsSeparatedByString:@" "];
                for (NSInteger i = 0; i < [arrTemp count]; i++) {
                    NSString *strLocalTmp = @"";
                    NSString *strTmp = [arrTemp objectAtIndex:i];
                    strLocalTmp = [Utility getLocalString:strTmp];
                    
                    strLocalOld = [strLocalOld stringByAppendingFormat:@" %@", strLocalTmp];
                    //strLocalOld = [strLocalOld substringFromIndex:1];
                }
                self.lblRepeatText.text = strLocalOld;
                
            }else{
                //self.tfLabelText.text = @"None";
                self.lblRepeatText.text = NSLocalizedString(@"Never", nil);
                self.lblMusicText.text = NSLocalizedString(@"None", nil);
            }
        }
    }else{
        //重复设置参数
        NSArray *arrRepeat = [[NSUserDefaults standardUserDefaults] objectForKey:@"Repeat"];
        
        if ([arrRepeat count] == 7) {
            self.lblRepeatText.text = NSLocalizedString(@"Everyday", nil);
        }else if ([arrRepeat count] == 0){
            self.lblRepeatText.text = NSLocalizedString(@"Never", nil);
        }else{
            NSString *strTmp = @"";
            NSString *strEN = @"";
            for (NSString *str in arrRepeat) {
                //获取本地化字符串
                NSString *strLocal = [Utility getLocalString:str];
                strTmp = [strTmp stringByAppendingFormat:@"%@ ", strLocal];
                //英文原始字符串
                strEN = [strEN stringByAppendingFormat:@"%@ ", str];
            }
            self.lblRepeatText.text = strTmp;
            self.strRepeatEN = strEN;
            NSLog(@"测试 = %@", self.strRepeatEN);
        }
    
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set background color
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //UITableView
    CGRect rect = CGRectMake(0.0, 0.0, SCREEN_FRAM_WIDTH, SCREEN_FRAM_HEIGHT);
    self.tbAlarmContent = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    self.tbAlarmContent.delegate = self;
    self.tbAlarmContent.dataSource = self;
    [self.view addSubview:self.tbAlarmContent];
    
    //UILabel name
    CGRect lblRect = CGRectMake(10.0, 0.0, 60.0, ADDALARM_CELL_HEIGHT);
    UIColor *lblColor = [UIColor clearColor];
    
    self.lblLabelName = [[UILabel alloc] initWithFrame:lblRect];
    self.lblLabelName.text = NSLocalizedString(@"Label", nil);
    self.lblLabelName.backgroundColor = lblColor;
    self.lblLabelName.font = [UIFont boldSystemFontOfSize:16.0];
    
    self.lblTimeName = [[UILabel alloc] initWithFrame:lblRect];
    self.lblTimeName.text = NSLocalizedString(@"Time", nil);
    self.lblTimeName.backgroundColor = lblColor;
    self.lblTimeName.font = [UIFont boldSystemFontOfSize:16.0];
    
    self.lblRepeatName = [[UILabel alloc] initWithFrame:lblRect];
    self.lblRepeatName.text = NSLocalizedString(@"Repeat", nil);
    self.lblRepeatName.backgroundColor = lblColor;
    self.lblRepeatName.font = [UIFont boldSystemFontOfSize:16.0];
    
    self.lblMusicName = [[UILabel alloc] initWithFrame:lblRect];
    self.lblMusicName.text = NSLocalizedString(@"Music", nil);
    self.lblMusicName.backgroundColor = lblColor;
    self.lblMusicName.font = [UIFont boldSystemFontOfSize:16.0];
    
//    self.lblLaterName = [[UILabel alloc] initWithFrame:lblRect];
//    self.lblLaterName.text = NSLocalizedString(@"Later", nil);
//    self.lblLaterName.backgroundColor = lblColor;
//    self.lblLaterName.font = [UIFont boldSystemFontOfSize:16.0];
    
    //UILabel text
    CGRect lblRectText = CGRectMake(120.0, 0.0, 155.0, ADDALARM_CELL_HEIGHT - 3);
    
    self.lblTimeText = [[UILabel alloc] initWithFrame:lblRectText];
    self.lblTimeText.backgroundColor = lblColor;
    self.lblTimeText.textAlignment = UITextAlignmentRight;
    self.lblTimeText.font = [UIFont systemFontOfSize:14.0];
    self.lblTimeText.text = @"10:00";
    
    CGRect lblRectRepeat = CGRectMake(60.0, 2.0, 210.0, ADDALARM_CELL_HEIGHT - 2);
    self.lblRepeatText = [[UILabel alloc] initWithFrame:lblRectRepeat];
    self.lblRepeatText.backgroundColor = [UIColor clearColor];
    //self.lblRepeatText.textColor = [UIColor colorWithRed:50.0 green:100.0 blue:150.0 alpha:1.0];
    self.lblRepeatText.textAlignment = UITextAlignmentRight;
    self.lblRepeatText.font = [UIFont systemFontOfSize:14.0];
    self.lblRepeatText.text = @"每天";
    
    self.lblMusicText = [[UILabel alloc] initWithFrame:lblRectText];
    self.lblMusicText.backgroundColor = lblColor;
    self.lblMusicText.textAlignment = UITextAlignmentRight;
    self.lblMusicText.font =[UIFont systemFontOfSize:14.0];
    self.lblMusicText.text = @"";
    
    CGRect swRect = CGRectMake(202.0, (ADDALARM_CELL_HEIGHT - 27.0) / 2.0 , 0.0, 0.0);
    self.swLater = [[UISwitch alloc] initWithFrame:swRect];
    
    //UITextFeild
    CGRect tfRect = CGRectMake(120.0, 1.0, 155.0, ADDALARM_CELL_HEIGHT - 2);
    self.tfLabelText = [[UITextField alloc] initWithFrame:tfRect];
    self.tfLabelText.delegate = self;
    self.tfLabelText.backgroundColor = [UIColor clearColor];
    self.tfLabelText.font = [UIFont systemFontOfSize:14.0];
    self.tfLabelText.placeholder = NSLocalizedString(@"起床", nil);
    self.tfLabelText.textAlignment = UITextAlignmentRight;
    self.tfLabelText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;


    //UIDatePicker
    CGRect dpRect = CGRectMake(0.0, 200.0 + kDATEPICKER_HEIGHT + kBTN_DATEPICKER_HEIGHT, 
                               kDATPICKER_WIDTH, kDATEPICKER_HEIGHT);
    self.dpTimePicker = [[LLDatePickerView alloc] initWithFrame:dpRect];
    self.dpTimePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    self.dpTimePicker.minuteInterval = 1;
    [self.dpTimePicker addTarget:self action:@selector(datePick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.dpTimePicker];
    NSLog(@"x = %f, y = %f", self.dpTimePicker.frame.size.width, self.dpTimePicker.frame.size.height);
    
    //button for hidden datePicker
    CGRect btnRect = CGRectMake(kDATPICKER_WIDTH - kBTN_DATEPICKER_WIDTH, 
                                200.0 + kDATEPICKER_HEIGHT, 
                                kBTN_DATEPICKER_WIDTH, kBTN_DATEPICKER_HEIGHT);
//    self.btnHidden = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    self.btnHidden.frame = btnRect;
//    [self.btnHidden addTarget:self action:@selector(actionHiddenDatepicker) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.btnHidden];
    
}

#pragma mark - UITextFeild delegate 隐藏键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.tfLabelText resignFirstResponder];
    return YES;
}

#pragma mark - DatePicker Methods

/**
 * 显示时间选择器
 */

- (void)actionShowDatepicker
{

    [UIView beginAnimations:@"animationID" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    self.dpTimePicker.frame = CGRectMake(0.0, 200.0, kDATPICKER_WIDTH, kDATEPICKER_HEIGHT);
    self.btnHidden.frame = CGRectMake(kDATPICKER_WIDTH - kBTN_DATEPICKER_WIDTH, 
                                      200.0 - kBTN_DATEPICKER_HEIGHT, 
                                      kBTN_DATEPICKER_WIDTH, kBTN_DATEPICKER_HEIGHT);
    [UIView commitAnimations];
    
}
/**
 * 隐藏时间选择器
 */
- (void)actionHiddenDatepicker
{
    [UIView beginAnimations:@"animationID" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    self.dpTimePicker.frame = CGRectMake(0.0, 200.0 + kDATEPICKER_HEIGHT + kBTN_DATEPICKER_HEIGHT, 
                                         kDATPICKER_WIDTH, kDATEPICKER_HEIGHT);
    self.btnHidden.frame = CGRectMake(kDATPICKER_WIDTH - kBTN_DATEPICKER_WIDTH, 
                                      200.0 + kDATEPICKER_HEIGHT, 
                                      kBTN_DATEPICKER_WIDTH, kBTN_DATEPICKER_HEIGHT);
    [UIView commitAnimations];
}

/**
 * 时间选择器 设置时间
 */
- (void)datePick:(UIDatePicker *)sender
{
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps = [[NSDateComponents alloc] init];
	//[calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
	NSInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit;
	comps = [calendar components:unitFlags fromDate:sender.date];
    
    if ([comps hour] < 10) {
        if ([comps minute] < 10)
            self.lblTimeText.text = [NSString stringWithFormat:@"0%d:0%d", [comps hour], [comps minute]];
        else 
            self.lblTimeText.text = [NSString stringWithFormat:@"0%d:%d", [comps hour], [comps minute]];
    }else{
        if ([comps minute] < 10)
            self.lblTimeText.text = [NSString stringWithFormat:@"%d:0%d", [comps hour], [comps minute]];
        else 
            self.lblTimeText.text = [NSString stringWithFormat:@"%d:%d", [comps hour], [comps minute]];
    }

    [self performSelector:@selector(actionHiddenDatepicker) withObject:nil afterDelay:3];
}


#pragma mark - Save & Back Methods
/**
 * 返回
 */
- (void)backToMainUI:(id)sender
{
    self.isAddNewAlarm = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 * UI数据持久化 储存闹钟
 */
- (void)saveClockData
{
    NSMutableDictionary *clockDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    [clockDictionary setObject:self.tfLabelText.text forKey:@"ClockLabel"];
	[clockDictionary setObject:self.lblTimeText.text forKey:@"ClockTime"];
	[clockDictionary setObject:self.strRepeatEN forKey:@"ClockRepeat"];
    [clockDictionary setObject:self.lblMusicText.text forKey:@"ClockMusic"];
    NSLog(@"clockDic = %@", clockDictionary);
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if (!self.isAddNewAlarm) {
        [userDefault removeObjectForKey:[NSString stringWithFormat:@"%d", self.intAlarmIndex]];
        [userDefault setObject:clockDictionary forKey:[NSString stringWithFormat:@"%d", self.intAlarmIndex]];
    }else{
        [userDefault setObject:clockDictionary forKey:[NSString stringWithFormat:@"%d", self.alarmClockID]];
        NSLog(@"self.alarmClockID = %d", self.alarmClockID);
    }
	
	if (self.alarmClockID > self.alarmViewCopntroller.alarmClockCount)
		++self.alarmViewCopntroller.alarmClockCount;
    NSLog(@"self.alarmViewCopntroller.alarmClockCount = %d", self.alarmViewCopntroller.alarmClockCount);
	[userDefault setObject:[NSNumber numberWithInt:self.alarmViewCopntroller.alarmClockCount] forKey:@"ClockCount"];
	
	if (YES) {//self.blAlarmClockState
		[self.alarmViewCopntroller startClock:self.alarmClockID];
	}
	[userDefault synchronize];
    
    [self backToMainUI:nil];
}


#pragma mark - Action View Methods

/**
 *  设置闹铃重复
 */
- (void)showSetClockRepeatController
{
    NSString *str = [self.dicAlarmClock objectForKey:@"ClockRepeat"];
    NSArray *arrCurWeeks = [str componentsSeparatedByString:@" "];
    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:arrCurWeeks];
    [arr removeLastObject];
    NSLog(@"arr = %@", arr);
    self.setRepeatViewController = [[SetRepeatViewController alloc] initWithStyle:UITableViewStyleGrouped];
    self.setRepeatViewController.arrLastWeeks = [NSArray arrayWithArray:arr];
    [self.navigationController pushViewController:self.setRepeatViewController animated:YES];
}

/**
 *  设置闹铃音乐
 */
- (void)showSetClockMusicController
{
    self.setMusicViewController = [[SetMusicViewController alloc] initWithStyle:UITableViewStyleGrouped];
    self.setMusicViewController.delegate = self;
    [self.navigationController pushViewController:self.setMusicViewController animated:YES];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - Custom delegate
//返回选择的音乐
- (NSString *)setAlarmMusic:(NSString *)alarmMusic
{
    self.lblMusicText.text = alarmMusic;

    return self.lblMusicText.text;
}

#pragma mark - UITableView Delegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ADDALARM_CELL_HEIGHT;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

- (NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"";
}

- (NSString *) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NSLocalizedString(@"delete", @"删除");
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
							 SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
				 initWithStyle:UITableViewCellStyleDefault
				 reuseIdentifier:SimpleTableIdentifier];
    }
	

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    switch (indexPath.row) {
        case 0:
            [cell.contentView addSubview:self.lblLabelName];
            [cell.contentView addSubview:self.tfLabelText];
            break;
        case 1:
            [cell.contentView addSubview:self.lblTimeName];
            [cell.contentView addSubview:self.lblTimeText];
            break;
        case 2:
            [cell.contentView addSubview:self.lblRepeatName];
            [cell.contentView addSubview:self.lblRepeatText];
            break;
        case 3:
            [cell.contentView addSubview:self.lblMusicName];
            [cell.contentView addSubview:self.lblMusicText];
            break;
//        case 4:
//            [cell.contentView addSubview:self.lblLaterName];
//            [cell.contentView addSubview:self.swLater];
//            cell.accessoryType = UITableViewCellAccessoryNone;
//            break;
        default:
            break;
    }
	
    return cell;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
		case 0:
			
			break;
		case 1:
			//[self showSetClockTimeController];
			[self actionShowDatepicker];
            break;
		case 2:
			[self showSetClockRepeatController];
			break;
		case 3:
			[self showSetClockMusicController];
			break;
        case 4:
			break;
		default:
			break;
    }
}



@end
