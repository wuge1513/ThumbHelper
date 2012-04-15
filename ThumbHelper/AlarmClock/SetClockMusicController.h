//
//  SetClockMusicController.h
//  GeiniableClock
//
//  Created by yuan jun on 11-8-11.
//  Copyright 2011 the9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetClockController.h"
#import <AVFoundation/AVFoundation.h>

//@class AddClockViewController;
@interface SetClockMusicController : SetClockController <AVAudioPlayerDelegate>{

	UITableView *musicTableView;
	NSMutableDictionary *stateDictionary;
	NSArray *musicArray;
//	CGPoint firstTouchPoint;
//	CGPoint lastTouchPoint;
//	AddClockViewController *delegate;
	
	UILabel *musicLabel;
	UISlider *volumnSlider;
	UISlider *processSlider;
	AVAudioPlayer *musicPlayer;
	
	NSString *musicFileName;
	NSString *musicFileType;
	UIButton *musicPlayButton;
	NSTimer *timer;
}

@property (nonatomic, retain) IBOutlet UITableView *musicTableView;
//@property (nonatomic, retain) AddClockViewController *delegate;
@property (nonatomic, retain) IBOutlet UILabel *musicLabel;
@property (nonatomic, retain) IBOutlet UISlider *volumnSlider;
@property (nonatomic, retain) IBOutlet UISlider *processSlider;
@property (nonatomic, retain) IBOutlet UIButton *musicPlayButton;
@property (nonatomic, assign) AVAudioPlayer *musicPlayer;

- (void)restoreGUI;
//- (void)backToClockUI:(int)directionTag;
//- (void)saveMusicData;
- (void)initMusicTableView;

- (void)updateMusicLabelByName:(NSString *)fileName;
- (void)updateStateDictionaryByIndex:(int)row;

- (IBAction)musicBtnPre:(UIButton *)sender;

- (void)initMusicPlayer;

- (IBAction)volumnSliderChanged:(UISlider *)sender;
- (IBAction)processSliderChanged:(UISlider *)sender;
- (void)updateProcessSlider;

@end
