//
//  SetClockSceneController.h
//  GeiniableClock
//
//  Created by yuan jun on 11-8-11.
//  Copyright 2011 the9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetClockController.h"
//@class AddClockViewController;
@interface SetClockSceneController : SetClockController {
	
//	CGPoint firstTouchPoint;
//	CGPoint lastTouchPoint;
//	AddClockViewController *delegate;
	
	UIPickerView *scenePickerView;
	UILabel *sceneLabel;
	NSArray *sceneArray;
}

//@property (nonatomic, retain) AddClockViewController *delegate;
@property (nonatomic, retain) IBOutlet UIPickerView *scenePickerView;
@property (nonatomic, retain) IBOutlet UILabel *sceneLabel;

- (void)restoreGUI;
//- (void)backToClockUI:(int)directionTag;
//- (void)saveSceneData;

- (void)initPickerView;
@end
