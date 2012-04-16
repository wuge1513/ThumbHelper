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

#import "SetClockTimeController.h"
#import "SetClockModeController.h"
#import "SetClockSceneController.h"
#import "SetClockMusicController.h"


@implementation AddClockViewController

@synthesize alarmViewCopntroller;

@synthesize tbAlarmContent;
@synthesize lblLabelName, lblTimeName, lblRepeatName, lblMusicName, lblLaterName, lblContentName;
@synthesize lblLabelText, lblTimeText, lblRepeatText, lblMusicText;
@synthesize swLater;
@synthesize alarmClockID;
@synthesize blAlarmClockState, isKeyboardShowFlag;
@synthesize rememberTextView;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		self.title = NSLocalizedString(@"Set AlarmClock", nil);
        
        //left button go back
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backToClockUI:)]; 

        //right button save data
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveClockData)];
    }
    return self;
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
    CGRect lblRect = CGRectMake(10.0, 0.0, 100.0, ADDALARM_CELL_HEIGHT);
    UIColor *lblColor = [UIColor clearColor];
    
    self.lblLabelName = [[UILabel alloc] initWithFrame:lblRect];
    self.lblLabelName.text = NSLocalizedString(@"Label", nil);
    self.lblLabelName.backgroundColor = lblColor;
    
    self.lblTimeName = [[UILabel alloc] initWithFrame:lblRect];
    self.lblTimeName.text = NSLocalizedString(@"Time", nil);
    self.lblTimeName.backgroundColor = lblColor;
    
    self.lblRepeatName = [[UILabel alloc] initWithFrame:lblRect];
    self.lblRepeatName.text = NSLocalizedString(@"Repeat", nil);
    self.lblRepeatName.backgroundColor = lblColor;
    
    self.lblMusicName = [[UILabel alloc] initWithFrame:lblRect];
    self.lblMusicName.text = NSLocalizedString(@"Music", nil);
    self.lblMusicName.backgroundColor = lblColor;
    
    self.lblLaterName = [[UILabel alloc] initWithFrame:lblRect];
    self.lblLaterName.text = NSLocalizedString(@"Later", nil);
    self.lblLaterName.backgroundColor = lblColor;
    
    //UILabel text
    CGRect lblRectText = CGRectMake(200.0, 0.0, 100.0, ADDALARM_CELL_HEIGHT);
    
    self.lblLabelText = [[UILabel alloc] initWithFrame:lblRectText];
    self.lblLabelText.backgroundColor = lblColor;
    self.lblLabelText.text = @"起床";
    
    self.lblTimeText = [[UILabel alloc] initWithFrame:lblRectText];
    self.lblTimeText.backgroundColor = lblColor;
    self.lblTimeText.text = @"08:00";
    
    self.lblRepeatText = [[UILabel alloc] initWithFrame:lblRectText];
    self.lblRepeatText.backgroundColor = lblColor;
    self.lblRepeatText.text = @"每天";
    
    self.lblMusicText = [[UILabel alloc] initWithFrame:lblRectText];
    self.lblMusicText.backgroundColor = lblColor;
    self.lblMusicText.text = @"竖琴";
    
    CGRect swRect = CGRectMake(180.0, (ADDALARM_CELL_HEIGHT - 27.0) / 2.0 , 0.0, 0.0);
    self.swLater = [[UISwitch alloc] initWithFrame:swRect];

    
    //hidden keyboard
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}


- (void)keyboardWillShow:(NSNotification *)notification
{
	 if ([rememberTextView isFirstResponder] == NO) {
         return;
	 }
    
	 //获取键盘的大小
	 NSDictionary *dictionary=[notification userInfo];
	 
	 NSValue *aValue = [dictionary objectForKey:UIKeyboardFrameBeginUserInfoKey];
	 CGSize keyboardSize = [aValue CGRectValue].size;
	 [UIView beginAnimations:@"showKeyboard" context:nil];
	 [UIView setAnimationDuration:0.3f];
	 //[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	 //[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:toolbar cache:YES];
	 CGRect frame=[self.view frame];
	 frame.origin.y -= keyboardSize.height;
	 self.view.frame = frame;
	 [UIView commitAnimations];
    isKeyboardShowFlag = YES;
}

- (void)keyboardWillHidden:(NSNotification *)notification
{
	//获取键盘的大小
	NSDictionary *dictionary=[notification userInfo];
	NSValue *aValue=[dictionary objectForKey:UIKeyboardFrameBeginUserInfoKey];
	CGSize keyboardSize=[aValue CGRectValue].size;
	[UIView beginAnimations:@"showKeyboard" context:nil];
	[UIView setAnimationDuration:0.3f];
	//[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	//[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:toolbar cache:YES];
	CGRect frame=[self.view frame];
	frame.origin.y += keyboardSize.height;
	self.view.frame = frame;
	[UIView commitAnimations];
    isKeyboardShowFlag = NO;
}


/**
 * UI数据持久化 储存闹钟
 */
- (void)saveClockData
{
	NSMutableDictionary *clockDictionary = [NSMutableDictionary dictionaryWithCapacity:4];
	[clockDictionary setObject:self.lblTimeText.text forKey:@"ClockTime"];
    [clockDictionary setObject:self.lblLabelText.text forKey:@"ClockLabel"];
	[clockDictionary setObject:self.lblRepeatText.text forKey:@"ClockRepeat"];
	//[clockDictionary setObject:self.lblMusicText.text forKey:@"ClockMusic"];
	//[clockDictionary setObject:self.rememberTextView.text forKey:@"ClockText"];
    //NSLog(@"clockDic = %@", clockDictionary);
    
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
	[userDefault setObject:clockDictionary forKey:[NSString stringWithFormat:@"%d", self.alarmClockID]];
    
	if (self.alarmClockID > self.alarmViewCopntroller.alarmClockCount)
		++self.alarmViewCopntroller.alarmClockCount;
    
	[userDefault setObject:[NSNumber numberWithInt:self.alarmViewCopntroller.alarmClockCount] forKey:@"ClockCount"];
	
	if (self.blAlarmClockState) {
		[self.alarmViewCopntroller startClock:self.alarmClockID];
	}
	[userDefault synchronize];
}

/**
 * 返回
 */
- (void)backToMainUI:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [self saveClockData];
    [self.alarmViewCopntroller restoreMainGUI];
}


- (void)showSetClockTimeController
{
	setClockTimeController = [[SetClockTimeController alloc] initWithNibName:@"SetClockTimeController" bundle:nil];
	setClockTimeController.delegate = self;
	
//	CATransition *animation = [CATransition animation];
//	animation.duration = 0.4f;
//	animation.delegate = self;
//	animation.timingFunction = UIViewAnimationCurveEaseInOut;
//	animation.type = kCATransitionPush;
//	animation.subtype = kCATransitionFromLeft;
//	[[self.view layer] addAnimation:animation forKey:@"ShowSetTime"];
	
    
    //[self.view addSubview:setClockTimeController.view];
	[self.navigationController pushViewController:setClockTimeController animated:YES];
    self.alarmViewCopntroller.tbAlarmView.scrollEnabled = NO;
}

- (void)showSetClockModeController
{
//	setClockModeController = [[SetClockModeController alloc] initWithNibName:@"SetClockModeController" bundle:nil];
//	setClockModeController.delegate = self;
//	
//	CATransition *animation = [CATransition animation];
//	animation.duration = 0.4f;
//	animation.delegate = self;
//	animation.timingFunction = UIViewAnimationCurveEaseInOut;
//	animation.type = kCATransitionPush;
//	animation.subtype = kCATransitionFromLeft;
//	[[self.view layer] addAnimation:animation forKey:@"ShowSetMode"];
//	[self.view addSubview:setClockModeController.view];
//	delegate.mainTableView.scrollEnabled = NO;
}

- (void)showSetClockMusicController
{
//	setClockMusicController = [[SetClockMusicController alloc] initWithNibName:@"SetClockMusicController" bundle:nil];
//	setClockMusicController.delegate = self;
//	
//	CATransition *animation = [CATransition animation];
//	animation.duration = 0.4f;
//	animation.delegate = self;
//	animation.timingFunction = UIViewAnimationCurveEaseInOut;
//	animation.type = kCATransitionPush;
//	animation.subtype = kCATransitionFromLeft;
//	[[self.view layer] addAnimation:animation forKey:@"ShowSetMusic"];
//	[self.view addSubview:setClockMusicController.view];
//	delegate.mainTableView.scrollEnabled = NO;
}

- (void)showSetClockSceneController
{
//	setClockSceneController = [[SetClockSceneController alloc] initWithNibName:@"SetClockSceneController" bundle:nil];
//	setClockSceneController.delegate = self;
//	
//	CATransition *animation = [CATransition animation];
//	animation.duration = 0.4f;
//	animation.delegate = self;
//	animation.timingFunction = UIViewAnimationCurveEaseInOut;
//	animation.type = kCATransitionPush;
//	animation.subtype = kCATransitionFromLeft;
//	[[self.view layer] addAnimation:animation forKey:@"ShowSetScene"];
//	[self.view addSubview:setClockSceneController.view];
//	delegate.mainTableView.scrollEnabled = NO;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [[touches allObjects] lastObject];
	firstTouchPoint = [touch locationInView:self.view];
	lastTouchPoint = CGPointZero;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [[touches allObjects] lastObject];
	lastTouchPoint = [touch locationInView:self.view];
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

#pragma mark - UITableView Delegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
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
	

    switch (indexPath.row) {
        case 0:
            [cell.contentView addSubview:self.lblLabelName];
            [cell.contentView addSubview:self.lblLabelText];
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
        case 4:
            [cell.contentView addSubview:self.lblLaterName];
            [cell.contentView addSubview:self.swLater];
            break;
        default:
            break;
    }
	
    return cell;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
		case 0:
			[self showSetClockTimeController];
			break;
		case 1:
			[self showSetClockModeController];
			break;
		case 2:
			[self showSetClockSceneController];
			break;
		case 3:
			[self showSetClockMusicController];
			break;
        case 4:
			[self showSetClockMusicController];
			break;
		default:
			break;
    }
}










@end
