//
//  AddClockViewController.h
//  GeiniableClock
//
//  Created by yuan jun on 11-8-5.
//  Copyright 2011 the9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetMusicViewController.h"
#import "SetRepeatViewController.h"

@class MyPicker;
@class LLDatePickerView;

@class AlarmViewController;
@class SetClockTimeController;
@class SetRepeatViewController;
@class SetMusicViewController;

@interface AddClockViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, 
SetMusicDelegate>

@property (nonatomic) BOOL isAddNewAlarm;
@property (nonatomic) BOOL isFromAddAlarm;
@property (nonatomic) BOOL *blAlarmClockState;
@property (nonatomic) NSInteger intAlarmIndex;

@property (strong, nonatomic) AlarmViewController *alarmViewCopntroller;
@property (strong, nonatomic) SetRepeatViewController *setRepeatViewController;
@property (strong, nonatomic) SetMusicViewController *setMusicViewController;

@property (strong, nonatomic) UITableView *tbAlarmContent;

@property (strong, nonatomic) NSDictionary *dicAlarmClock;
//UIButton
@property (strong, nonatomic) UIButton *btnHidden;
//String
@property (strong, nonatomic) NSString *strMusic;

//label name
@property (strong, nonatomic) UILabel *lblLabelName;
@property (strong, nonatomic) UILabel *lblTimeName;
@property (strong, nonatomic) UILabel *lblRepeatName;
@property (strong, nonatomic) UILabel *lblMusicName;
@property (strong, nonatomic) UILabel *lblLaterName;

//label content
@property (strong, nonatomic) UILabel *lblTimeText;
@property (strong, nonatomic) UILabel *lblRepeatText;
@property (strong, nonatomic) UILabel *lblMusicText;
//textFeild
@property (strong, nonatomic) UITextField *tfLabelText;

//UISwitch
@property (strong, nonatomic) UISwitch *swLater;
@property (nonatomic) NSInteger alarmClockID;


@property (strong, nonatomic) LLDatePickerView *dpTimePicker;

- (void)saveClockData;
- (void)backToMainUI:(id)sender;

- (void)actionShowDatepicker;
- (void)actionHiddenDatepicker;

- (void)showSetClockRepeatController;
- (void)showSetClockMusicController;


@end
