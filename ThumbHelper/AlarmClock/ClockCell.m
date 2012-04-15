//
//  ClockCell.m
//  GeiniableClock
//
//  Created by yuan jun on 11-8-9.
//  Copyright 2011 the9. All rights reserved.
//

#import "ClockCell.h"
#import "UIColor_Random.h"
#import "AlarmViewController.h"

@implementation ClockCell
@synthesize alarmViewController;


@synthesize clockSwitch;
@synthesize clockTimeLabel, clockModeLabel, clockSceneLabel;
@synthesize clockMusic, clockRemember;
@synthesize numberID;
@synthesize firstTouchPoint, lastTouchPoint;

- (IBAction)clockBtn:(UIButton *)sender
{
	[self.alarmViewController showAddClockView:self];
	[self didTransitionToState:UITableViewCellStateDefaultMask];
	//NSIndexPath  *indexPath = [NSIndexPath indexPathForRow:self.numberID inSection:0];
	//[delegate.mainTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];

}

- (IBAction)switchBtn:(UISwitch *)sender
{
	NSMutableDictionary *clockDictionary = [NSMutableDictionary dictionaryWithCapacity:6];
	[clockDictionary setObject:(sender.on == YES ? @"开启" : @"关闭") forKey:@"ClockState"];
	[clockDictionary setObject:self.clockTimeLabel.text forKey:@"ClockTime"];
	[clockDictionary setObject:self.clockModeLabel.text forKey:@"ClockMode"];
	[clockDictionary setObject:self.clockSceneLabel.text forKey:@"ClockScene"];
	[clockDictionary setObject:self.clockMusic forKey:@"ClockMusic"];
	[clockDictionary setObject:self.clockRemember forKey:@"ClockRemember"];
	
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
	[userDefault setObject:clockDictionary forKey:[NSString stringWithFormat:@"%d", self.numberID]];
	
	if (sender.on)
	{
		[self.alarmViewController startClock:self.numberID];
		self.alarmViewController.activatyClockCount++;
	}
	else
	{
		[self.alarmViewController shutdownClock:self.numberID];
		self.alarmViewController.activatyClockCount--;
	}
	[self.alarmViewController updateActivityClockCount];
	[userDefault setObject:[NSNumber numberWithInt:self.alarmViewController.activatyClockCount] forKey:@"ActivityClockCount"];
	[self.alarmViewController.tbAlarmView reloadData];
	[userDefault synchronize];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		//self.clockSwitch.on = NO;

    }

    return self;
}

- (void)setUIFontAndColor
{
	self.clockTimeLabel.font = [UIFont fontWithName:@"DB LCD Temp" size:17.0f];
	self.clockSceneLabel.font = [UIFont fontWithName:@"DB LCD Temp" size:14.0f];
	self.clockModeLabel.font = [UIFont fontWithName:@"DB LCD Temp" size:11.0f];
	
	self.clockTimeLabel.textColor = [UIColor randomColor];
	self.clockSceneLabel.textColor = [UIColor randomColor];
	self.clockModeLabel.textColor = [UIColor randomColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [[touches allObjects] lastObject];
	firstTouchPoint = [touch locationInView:self];
	lastTouchPoint = CGPointZero;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [[touches allObjects] lastObject];
	lastTouchPoint = [touch locationInView:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (lastTouchPoint.x == 0 && lastTouchPoint.y == 0)
		return;
	if (lastTouchPoint.x - firstTouchPoint.x > 50) {
		[self.alarmViewController showAddClockView:self];
	}
	
}



@end
