//
//  SetClockTimeController.m
//  GeiniableClock
//
//  Created by yuan jun on 11-8-10.
//  Copyright 2011 the9. All rights reserved.
//

#import "SetClockTimeController.h"
//#import <QuartzCore/QuartzCore.h>
//#import "AddClockViewController.h"
//#import "MainSetViewController.h"

@implementation SetClockTimeController
//@synthesize delegate;
@synthesize timeLabel;
@synthesize datePicker;

- (IBAction)datePick:(UIDatePicker *)sender
{
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps = [[NSDateComponents alloc] init];
	[calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
	NSInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit;
	comps = [calendar components:unitFlags fromDate:sender.date];
	if ([comps minute] < 10)
		timeLabel.text = [NSString stringWithFormat:@"%d:0%d", [comps hour], [comps minute]];
	else 
		timeLabel.text = [NSString stringWithFormat:@"%d:%d", [comps hour], [comps minute]];
	
}

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
	self.timeLabel.font = [UIFont fontWithName:@"DB LCD Temp" size:30.0f];
	[self restoreGUI];
    [super viewDidLoad];
}

- (void)restoreGUI
{
	UIBarButtonItem *leftBarButtonItem;
	//leftBarButtonItem = delegate.delegate.mainNavigationBar.topItem.leftBarButtonItem;
	leftBarButtonItem.action = @selector(backToClockUI:);
	leftBarButtonItem.target = self;
	[self restoreNavigationBar];
	
	self.timeLabel.text = delegate.clockTime.text;
	NSArray *array = [delegate.clockTime.text componentsSeparatedByString:@":"];

	NSTimeInterval interval = [[array objectAtIndex:0] intValue] * 3600 + [[array objectAtIndex:1] intValue] * 60;
    self.datePicker.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
	self.datePicker.date = [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
	
}

//- (void)backToClockUI:(int)directionTag
//{
//	[delegate restoreGUI];
//	[self saveTimeData];
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
//	[[delegate.view layer] addAnimation:animation forKey:@"BackToClockUIFromTime"];
//	[self.view removeFromSuperview];
//}

- (void)saveData
{
	delegate.clockTime.text = timeLabel.text;
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



@end
