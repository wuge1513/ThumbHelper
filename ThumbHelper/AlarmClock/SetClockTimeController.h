//
//  SetClockTimeController.h
//  GeiniableClock
//
//  Created by yuan jun on 11-8-10.
//  Copyright 2011 the9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetClockController.h"
//@class AddClockViewController;

@interface SetClockTimeController : SetClockController {

//	AddClockViewController *delegate;
//	CGPoint firstTouchPoint;
//	CGPoint lastTouchPoint;
	
	UILabel *timeLabel;
	UIDatePicker *datePicker;
}

//@property (nonatomic, retain) AddClockViewController *delegate;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (void)restoreGUI;
//- (void)backToClockUI:(int)directionTag;
//- (void)saveTimeData;

- (IBAction)datePick:(UIDatePicker *)sender;

@end
