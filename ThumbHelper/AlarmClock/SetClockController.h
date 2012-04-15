//
//  SetClockController.h
//  GeiniableClock
//
//  Created by yuan jun on 11-8-16.
//  Copyright 2011 the9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AddClockViewController.h"
#import "AlarmViewController.h"
#import "UIColor_Random.h"

@class AddClockViewController;
@interface SetClockController : UIViewController {
	
	CGPoint firstTouchPoint;
	CGPoint lastTouchPoint;
	AddClockViewController *delegate;
}

@property (strong, nonatomic) AddClockViewController *delegate;

- (void)restoreNavigationBar;
- (void)backToClockUI:(int)directionTag;
- (void)saveData;

- (void)backBtnPre:(id)sender;

@end
