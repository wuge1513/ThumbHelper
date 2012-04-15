//
//  SetClockModeController.m
//  GeiniableClock
//
//  Created by yuan jun on 11-8-10.
//  Copyright 2011 the9. All rights reserved.
//

#import "SetClockModeController.h"
//#import <QuartzCore/QuartzCore.h>
//#import "AddClockViewController.h"
//#import "MainSetViewController.h"

@implementation SetClockModeController
@synthesize stateDictionary;
@synthesize weekdaysArray;
//@synthesize delegate;
@synthesize cycleLabel;
@synthesize clockModeTableView;

- (void)restoreGUI
{
//	UIBarButtonItem *leftBarButtonItem;
//	leftBarButtonItem = delegate.delegate.mainNavigationBar.topItem.leftBarButtonItem;
//	leftBarButtonItem.action = @selector(backToClockUI:);
//	leftBarButtonItem.target = self;
	[self restoreNavigationBar];
	
	self.cycleLabel.text = delegate.clockMode.text;
	self.stateDictionary = [NSMutableDictionary dictionaryWithCapacity:7];
	[self initStateDictionary];
	weekdaysArray = [NSArray arrayWithObjects:@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil] ;
    
}

- (void)initStateDictionary
{
	if (![self.cycleLabel.text isEqualToString:@"未设置闹铃周期模式"]) {
		NSArray *array = [[self.cycleLabel.text substringFromIndex:1] componentsSeparatedByString:@"、"];
		Byte i;
		Byte count = [array count];
		for (i = 0; i < count; i++) {
			[self.stateDictionary setObject:[NSNumber numberWithBool:YES] forKey:[NSString stringWithFormat:@"星期%@", [array objectAtIndex:i]]];
		}
	}
}

//- (void)backToClockUI:(int)directionTag
//{
//	[delegate restoreGUI];
//	[self saveModeData];
//	delegate.delegate.mainTableView.scrollEnabled = YES;
//	CATransition *animation = [CATransition animation];
//	animation.duration = 0.4f;
//	animation.delegate = self;
//	animation.timingFunction = UIViewAnimationCurveEaseInOut;
//	animation.type = kCATransitionPush;
//	switch (directionTag) {
//		case 0:
//			animation.subtype = kCATransitionFromRight;
//			break;
//		case 1:
//			animation.subtype = kCATransitionFromLeft;
//			break;
//		case 2:
//			animation.subtype = kCATransitionFromTop;
//			break;
//		case 3:
//			animation.subtype = kCATransitionFromBottom;
//			break;
//		default:
//			break;
//	}
//	[[delegate.view layer] addAnimation:animation forKey:@"BackToClockUIFromMode"];
//	[self.view removeFromSuperview];
//	
//}

- (void)saveData
{
	delegate.clockMode.text = self.cycleLabel.text;
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//	UITouch *touch = [[touches allObjects] lastObject];
//	firstTouchPoint = [touch locationInView:self.view];
//	lastTouchPoint = CGPointZero;
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//	UITouch *touch = [[touches allObjects] lastObject];
//	lastTouchPoint = [touch locationInView:self.view];
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//	if (lastTouchPoint.x == 0 && lastTouchPoint.y == 0)
//		return;
//	if (lastTouchPoint.x - firstTouchPoint.x > 80) {
//		[self backToClockUI:1];
//	}
//	else if(lastTouchPoint.x - firstTouchPoint.x < -80){
//		[self backToClockUI:0];
//	}
//	else if(lastTouchPoint.y - firstTouchPoint.y > 80){
//		[self backToClockUI:3];
//	}
//	else if(lastTouchPoint.y - firstTouchPoint.y < -80){
//		[self backToClockUI:2];
//	}
//	
//	
//}
//

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.clockModeTableView.showsVerticalScrollIndicator = NO;
	[self restoreGUI];
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCellStyle style = UITableViewCellStyleDefault;
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeekdayCell"];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"WeekdayCell"] autorelease];
	}
	cell.textLabel.text = [weekdaysArray objectAtIndex:indexPath.row];
	NSNumber *checked = [self.stateDictionary objectForKey:cell.textLabel.text];
	if (!checked)
		[self.stateDictionary setValue:(checked = [NSNumber numberWithBool:NO]) forKey:cell.textLabel.text];
	cell.accessoryType = [checked boolValue] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
	cell.textLabel.font = [UIFont fontWithName:@"DB LCD Temp" size:14.0f];
	cell.textLabel.textColor = [UIColor randomColor];
	return cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
	NSString *key = cell.textLabel.text;
	BOOL isChecked = !([[self.stateDictionary objectForKey:key] boolValue]);
	NSNumber *checked = [NSNumber numberWithBool:isChecked];

	[self.stateDictionary setObject:checked forKey:key];
	
	cell.accessoryType = isChecked ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
	
	[self updatecycleLabel];
}

- (void)updatecycleLabel
{
	Byte i;
	BOOL flag = NO;
	BOOL isChecked;
	NSMutableString *weekday = [NSMutableString stringWithCapacity:7];
	for (i = 0; i < 7; i++) {
		isChecked = [[stateDictionary objectForKey:[weekdaysArray objectAtIndex:i]] boolValue];
		if (isChecked) 
			[weekday appendFormat:@"、%@", [weekdaysArray objectAtIndex:i]];
		flag = flag || isChecked;
	}
	if (!flag) {
		cycleLabel.text = @"未设置闹铃周期模式";
	}
	else {
		NSString *tempString = [NSString stringWithFormat:@"周%@", [[weekday stringByReplacingOccurrencesOfString:@"星期" withString:@""] substringFromIndex:1]];
	    cycleLabel.text = tempString;
	}

}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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


- (void)dealloc {
	[stateDictionary release];
	[weekdaysArray release];
	[cycleLabel release];
	//[delegate release];
    [super dealloc];
}


@end
