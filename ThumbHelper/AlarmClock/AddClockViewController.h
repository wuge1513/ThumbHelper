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

@class AlarmViewController;
@class SetClockTimeController;
@class SetRepeatViewController;
@class SetMusicViewController;

@interface AddClockViewController : UIViewController <UITextViewDelegate, 
UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource,
SetMusicDelegate, setRepeatDelegate> {

	BOOL isKeyboardShowFlag;
	CGPoint firstTouchPoint;
	CGPoint lastTouchPoint;
	
	SetClockTimeController *setClockTimeController;
}

@property (strong, nonatomic) AlarmViewController *alarmViewCopntroller;
@property (strong, nonatomic) SetRepeatViewController *setRepeatViewController;
@property (strong, nonatomic) SetMusicViewController *setMusicViewController;

@property (strong, nonatomic) UITableView *tbAlarmContent;

//String
@property (strong, nonatomic) NSString *strMusic;
@property (strong, nonatomic) NSString *strRepeat;

// label name
@property (strong, nonatomic) UILabel *lblLabelName;
@property (strong, nonatomic) UILabel *lblTimeName;
@property (strong, nonatomic) UILabel *lblRepeatName;
@property (strong, nonatomic) UILabel *lblMusicName;
@property (strong, nonatomic) UILabel *lblLaterName;
@property (strong, nonatomic) UILabel *lblContentName;

//label content
@property (strong, nonatomic) UILabel *lblLabelText;
@property (strong, nonatomic) UILabel *lblTimeText;
@property (strong, nonatomic) UILabel *lblRepeatText;
@property (strong, nonatomic) UILabel *lblMusicText;

//textFeild
@property (strong, nonatomic) UITextField *tfLabelText;

//UISwitch
@property (strong, nonatomic) UISwitch *swLater;
@property (nonatomic) NSInteger alarmClockID;
@property (nonatomic) BOOL *blAlarmClockState;
@property (nonatomic) BOOL isKeyboardShowFlag;

@property (strong, nonatomic) UITextView *rememberTextView;

- (void)saveClockData;
- (void)backToMainUI:(id)sender;

- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHidden:(NSNotification *)notification;

- (void)showSetClockTimeController;
- (void)showSetClockRepeatController;
- (void)showSetClockMusicController;


@end
