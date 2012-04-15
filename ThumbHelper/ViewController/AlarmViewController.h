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


@property (assign, nonatomic) NSInteger alarmClockCount; //alarm clock tatal count
@property (assign, nonatomic) NSInteger activatyClockCount;// activaty count


- (void)showWeatherReport:(UIBarButtonItem *)sender;

- (void)restoreMainGUI;
- (void)initClockCount;
- (NSString *)updateHeaderTitle;
- (void)updateActivityClockCount;

- (void)showAddClockView:(ClockCell *)sender;

- (void)startClock:(int)clockID;
- (void)shutdownClock:(int)clockID;

- (void)updateTime;

@end
