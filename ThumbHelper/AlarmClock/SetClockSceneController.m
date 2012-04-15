//
//  SetClockSceneController.m
//  GeiniableClock
//
//  Created by yuan jun on 11-8-11.
//  Copyright 2011 the9. All rights reserved.
//

#import "SetClockSceneController.h"
//#import <QuartzCore/QuartzCore.h>
//#import "AddClockViewController.h"
//#import "MainSetViewController.h"

@implementation SetClockSceneController
//@synthesize delegate;
@synthesize scenePickerView;
@synthesize sceneLabel;

- (void)restoreGUI
{
//	UIBarButtonItem *leftBarButtonItem;
//	leftBarButtonItem = delegate.delegate.mainNavigationBar.topItem.leftBarButtonItem;
//	leftBarButtonItem.action = @selector(backToClockUI:);
//	leftBarButtonItem.target = self;
	[self restoreNavigationBar];
	
	sceneArray = [[NSArray arrayWithObjects:@"普通", @"会议", @"车内", @"户外", @"便携免提", @"住宅", @"办公室", nil] retain];
	self.sceneLabel.text = delegate.clockScene.text;
	[self initPickerView];
}

- (void)initPickerView
{
	Byte i;
	Byte count = [sceneArray count];
	for (i = 0; i < count; i++) {
		if ([[sceneArray objectAtIndex:i] isEqualToString:self.sceneLabel.text]) {
			[self.scenePickerView selectRow:i inComponent:0 animated:YES];
			break;
		}
	}
}

//- (void)backToClockUI:(int)directionTag
//{
//	[delegate restoreGUI];
//	[self saveSceneData];
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
//	[[delegate.view layer] addAnimation:animation forKey:@"BackToClockUIFromScene"];
//	[self.view removeFromSuperview];
//	
//}

- (void)saveData
{
	delegate.clockScene.text = self.sceneLabel.text;
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
	[self restoreGUI];
    [super viewDidLoad];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return  7;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [sceneArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	sceneLabel.text = [sceneArray objectAtIndex:row];
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
	//[delegate release];
	[scenePickerView release];
	[sceneLabel release];
	[sceneArray release];
    [super dealloc];
}


@end
