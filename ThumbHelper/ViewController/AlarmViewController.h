//
//  DetailViewController.h
//  ThumbHelper
//
//  Created by LiuLei on 12-4-11.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddClockViewCell;
@class ClockCell;
@class AddClockViewController;

@interface AlarmViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tbAlarmView;
@property (strong, nonatomic) AddClockViewController *addClockViewController; //add alarm clock

@property (nonatomic) BOOL doneState;
@property (assign, nonatomic) NSInteger alarmClockCount; //alarm clock tatal count
@property (assign, nonatomic) NSInteger activatyClockCount;// activaty count

@property (strong, nonatomic) NSMutableArray *arrAlarmClock;
@property (strong, nonatomic) NSMutableArray *arrAlarmTime;
@property (strong, nonatomic) NSMutableArray *arrAlarmLabel;
@property (strong, nonatomic) NSMutableArray *arrAlarmRepeat;

//Cell content
@property (nonatomic) NSInteger numberID;
@property (strong, nonatomic) UISwitch *alarmClockSwitch;

@property (strong, nonatomic) UILabel *lblAlarmClockTime;
@property (strong, nonatomic) UILabel *lblAlarmClockLabel;
@property (strong, nonatomic) UILabel *lblAlarmClockRepeat;

@property (strong, nonatomic) NSString *strAlarnClockTime;
@property (strong, nonatomic) NSString *strAlarmClockLabel;
@property (strong, nonatomic) NSString *strAlarmClockRepeat;






- (void)restoreMainGUI;
- (void)initClockCount;
- (NSString *)updateHeaderTitle;
- (void)updateActivityClockCount;

- (void)showAddClockView:(NSInteger)index;

- (void)startClock:(int)clockID;
- (void)shutdownClock:(int)clockID;

@end
