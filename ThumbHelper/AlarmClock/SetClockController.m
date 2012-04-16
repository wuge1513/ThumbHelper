    //
//  SetClockController.m
//  GeiniableClock
//
//  Created by yuan jun on 11-8-16.
//  Copyright 2011 the9. All rights reserved.
//

#import "SetClockController.h"

@implementation SetClockController
@synthesize delegate;

- (void)backBtnPre:(id)sender
{
	[self backToClockUI:0];
}

- (void)restoreNavigationBar
{
//	UIBarButtonItem *leftBarButtonItem;
//	leftBarButtonItem = delegate.delegate.mainNavigationBar.topItem.leftBarButtonItem;
//	leftBarButtonItem.action = @selector(backBtnPre:);
//	leftBarButtonItem.target = self;
}

- (void)backToClockUI:(int)directionTag
{
	[self saveData];
	[delegate saveClockData];
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
//	[[delegate.view layer] addAnimation:animation forKey:nil];
	
    
    //[self.view removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveData
{
	
}

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

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (lastTouchPoint.x == 0 && lastTouchPoint.y == 0)
		return;
	if (lastTouchPoint.x - firstTouchPoint.x > 80) {
		[self backToClockUI:1];
	}
	else if(lastTouchPoint.x - firstTouchPoint.x < -80){
		[self backToClockUI:0];
	}
	else if(lastTouchPoint.y - firstTouchPoint.y > 80){
		[self backToClockUI:3];
	}
	else if(lastTouchPoint.y - firstTouchPoint.y < -80){
		[self backToClockUI:2];
	}
	
	
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
