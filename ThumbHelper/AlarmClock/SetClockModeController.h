//
//  SetClockModeController.h
//  GeiniableClock
//
//  Created by yuan jun on 11-8-10.
//  Copyright 2011 the9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetClockController.h"
//@class AddClockViewController;
@interface SetClockModeController : SetClockController<UITableViewDelegate, UITableViewDataSource> {

	NSMutableDictionary *stateDictionary;
	NSArray *weekdaysArray;
	UITableView *clockModeTableView;
//	CGPoint firstTouchPoint;
//	CGPoint lastTouchPoint;
//	AddClockViewController *delegate;
	
	UILabel *cycleLabel;
}

@property (nonatomic, retain) NSMutableDictionary *stateDictionary;
@property (nonatomic, retain) NSArray *weekdaysArray;
//@property (nonatomic, retain) AddClockViewController *delegate;

@property (nonatomic, retain) IBOutlet UILabel *cycleLabel;
@property (nonatomic, retain) IBOutlet UITableView *clockModeTableView;

- (void)restoreGUI;
//- (void)backToClockUI:(int)directionTag;
//- (void)saveModeData;

- (void)updatecycleLabel;
- (void)initStateDictionary;
@end
