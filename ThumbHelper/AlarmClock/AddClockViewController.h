//
//  AddClockViewController.h
//  GeiniableClock
//
//  Created by yuan jun on 11-8-5.
//  Copyright 2011 the9. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlarmViewController;
@class SetClockTimeController;
@class SetClockModeController;
@class SetClockSceneController;
@class SetClockMusicController;

@interface AddClockViewController : UIViewController <UITextViewDelegate, 
UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource> {

	BOOL isKeyboardShowFlag;
	CGPoint firstTouchPoint;
	CGPoint lastTouchPoint;
	
	SetClockTimeController *setClockTimeController;
	SetClockModeController *setClockModeController;
	SetClockSceneController *setClockSceneController;
	SetClockMusicController *setClockMusicController;
}

@property (nonatomic, assign) AlarmViewController *alarmViewCopntroller;

@property (strong, nonatomic) UITableView *tbAlarmContent;

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

//UISwitch
@property (strong, nonatomic) UISwitch *swLater;


@property (strong, nonatomic) UILabel *clockState;
@property (strong, nonatomic) UILabel *clockTime;
@property (strong, nonatomic) UILabel *clockMode;
@property (strong, nonatomic) UILabel *clockScene;
@property (strong, nonatomic) UILabel *clockMusic;
@property (strong, nonatomic) UITextView *rememberTextView;
@property (nonatomic) NSInteger clockID;
//@property (nonatomic) BOOL isKeyboardShowFlag;

- (void)saveClockData;
- (void)restoreGUI;
- (void)backToMainUI:(id)sender;
- (void)backToMainUIByDirection:(int)directionTag;

- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHidden:(NSNotification *)notification;

- (IBAction)setClockBtn:(UIButton *)sender;

- (void)showSetClockTimeController;
- (void)showSetClockModeController;
- (void)showSetClockMusicController;
- (void)showSetClockSceneController;

- (void)setUIFontAndColor;

@end
