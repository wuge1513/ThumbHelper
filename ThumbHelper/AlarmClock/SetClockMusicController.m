//
//  SetClockMusicController.m
//  GeiniableClock
//
//  Created by yuan jun on 11-8-11.
//  Copyright 2011 the9. All rights reserved.
//

#import "SetClockMusicController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "GeiniableClockAppDelegate.h"
//#import <QuartzCore/QuartzCore.h>
//#import "AddClockViewController.h"
//#import "MainSetViewController.h"

@interface SetClockMusicController (private)

- (void)startMusic:(UISlider *)sender;
- (void)suspendMusic:(UISlider *)sender;

@end

@implementation SetClockMusicController
@synthesize musicTableView;
//@synthesize delegate;
@synthesize musicLabel;
@synthesize volumnSlider;
@synthesize processSlider;
@synthesize musicPlayButton;
@synthesize musicPlayer;

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
	musicPlayButton.tag = 512;
	[musicPlayButton setImage:[UIImage imageNamed:@"start.png"] forState:UIControlStateNormal];
	[self initMusicPlayer];
	[timer invalidate];
}

- (IBAction)volumnSliderChanged:(UISlider *)sender
{
	if (musicPlayer) {
		musicPlayer.volume = volumnSlider.value;
	}
}

- (IBAction)processSliderChanged:(UISlider *)sender
{
	if (musicPlayer) {
		musicPlayer.currentTime = processSlider.value * musicPlayer.duration;
	}
}

- (void)initMusicPlayer
{
	if (musicPlayer) {
		[musicPlayer release];
	}
//	int length = [musicLabel.text length];
//	musicFileName = [musicLabel.text substringToIndex:(length - 4)];
//  musicFileType = [musicLabel.text substringFromIndex:(length - 3)];
	musicFileName = musicLabel.text;
    musicFileType = @"caf";
	AVAudioSession* audioSession = [AVAudioSession sharedInstance];
	[audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
	[audioSession setActive:YES error:nil];
    
	
	musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:musicFileName ofType:musicFileType]] error:nil];
	musicPlayer.delegate = self;
	musicPlayer.numberOfLoops = -1;
	volumnSlider.value = 0.5;
	processSlider.value = 0.0;
	musicPlayer.volume = volumnSlider.value;
	[musicPlayer prepareToPlay];
	self.musicPlayer.meteringEnabled = YES;
	
}

- (IBAction)musicBtnPre:(UIButton *)sender
{
	if ([sender tag] == 512) {
		[self startMusic:nil];
		sender.tag = 256;
		[musicPlayButton setImage:[UIImage imageNamed:@"end.png"] forState:UIControlStateNormal];
	}
	else {
		[self suspendMusic:nil];
		sender.tag = 512;
		[musicPlayButton setImage:[UIImage imageNamed:@"start.png"] forState:UIControlStateNormal];
	}

	
}

- (void)startMusic:(UISlider *)sender
{
	[musicPlayer play];
	timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(updateProcessSlider) userInfo:nil repeats:YES];
}

- (void)suspendMusic:(UISlider *)sender
{
	[musicPlayer pause];
	[timer invalidate];
}

- (void)updateProcessSlider
{
	[self.musicPlayer updateMeters];
	processSlider.value = musicPlayer.currentTime / musicPlayer.duration;
}

- (void)restoreGUI
{
//	UIBarButtonItem *leftBarButtonItem;
//	leftBarButtonItem = delegate.delegate.mainNavigationBar.topItem.leftBarButtonItem;
//	leftBarButtonItem.action = @selector(backToClockUI:);
//	leftBarButtonItem.target = self;
	[self restoreNavigationBar];
	
	self.musicLabel.text = delegate.clockMusic.text;
	stateDictionary = [[NSMutableDictionary dictionaryWithCapacity:10] retain];
	musicArray = [[NSArray arrayWithObjects:@"布谷鸟", @"叮当", @"非常有趣", @"懒猪起床", @"梦幻", @"起床铃声", @"三星优美闹钟铃声", nil] retain];
		
	[self initMusicTableView];
	[self initMusicPlayer];
}

- (void)initMusicTableView
{
	Byte i;
	Byte count = [musicArray count];
	for (i = 0; i < count; i++) {
		if ([[musicArray objectAtIndex:i] isEqualToString:self.musicLabel.text]) {
			[stateDictionary setObject:[NSNumber numberWithBool:YES] forKey:[NSString stringWithFormat:@"%d", i + 1]];
			break;
		}
	}
}

//- (void)backToClockUI:(int)directionTag
//{
//	[delegate restoreGUI];
//	[self saveMusicData];
//	delegate.delegate.mainTableView.scrollEnabled = YES;
//	CATransition *animation = [CATransition animation];
//	animation.duration = 0.4f;
//	animation.delegate = self;
//	animation.timingFunction = UIViewAnimationCurveEaseInOut;
//	animation.type = kCATransitionPush;
//	switch (directionTag) {
//		case 0:
//			animation.subtype = kCATransitionFromRight;
//			break;
//		case 1:
//			animation.subtype = kCATransitionFromLeft;
//			break;
//		case 2:
//			animation.subtype = kCATransitionFromTop;
//			break;
//		case 3:
//			animation.subtype = kCATransitionFromBottom;
//			break;
//		default:
//			break;
//	}
//	[[delegate.view layer] addAnimation:animation forKey:@"BackToClockUIFromMusic"];
//	[self.view removeFromSuperview];
//	
//}

- (void)stopMusic {
    if (self.musicPlayer) {
		[self.musicPlayer stop];
	}
}

- (void)helpMethod {
    if ([self.musicPlayer isPlaying]) {
        [self musicBtnPre:musicPlayButton];
	}
    
}

- (void)saveData
{
    ((GeiniableClockAppDelegate *)[[UIApplication sharedApplication] delegate]).musicDelegate = nil;
	delegate.clockMusic.text = self.musicLabel.text;
	[self stopMusic];
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//	UITouch *touch = [[touches allObjects] lastObject];
//	firstTouchPoint = [touch locationInView:self.view];
//	lastTouchPoint = CGPointZero;
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//	UITouch *touch = [[touches allObjects] lastObject];
//	lastTouchPoint = [touch locationInView:self.view];
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//	if (lastTouchPoint.x == 0 && lastTouchPoint.y == 0)
//		return;
//	if (lastTouchPoint.x - firstTouchPoint.x > 80) {
//		[self backToClockUI:1];
//	}
//	else if(lastTouchPoint.x - firstTouchPoint.x < -80){
//		[self backToClockUI:0];
//	}
//	else if(lastTouchPoint.y - firstTouchPoint.y > 80){
//		[self backToClockUI:3];
//	}
//	else if(lastTouchPoint.y - firstTouchPoint.y < -80){
//		[self backToClockUI:2];
//	}
//	
//	
//}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.musicTableView.showsVerticalScrollIndicator = NO;
	self.musicLabel.font = [UIFont fontWithName:@"DB LCD Temp" size:20.0f];
	[self restoreGUI];
	((GeiniableClockAppDelegate *)[[UIApplication sharedApplication] delegate]).musicDelegate = self;
	[super viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [musicArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCellStyle style = UITableViewCellStyleDefault;
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicCell"];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"MusicCell"] autorelease];
	}
	cell.textLabel.text = [musicArray objectAtIndex:indexPath.row];
	
	NSString *key = [NSString stringWithFormat:@"%d", indexPath.row + 1];
	
	NSNumber *checked = [stateDictionary objectForKey:key];
	if (!checked)
		[stateDictionary setObject:(checked = [NSNumber numberWithBool:NO]) forKey:key];
	cell.accessoryType = [checked boolValue] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
	cell.textLabel.font = [UIFont fontWithName:@"DB LCD Temp" size:14.0f];
	cell.textLabel.textColor = [UIColor randomColor];
	return cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
	NSString *key = [NSString stringWithFormat:@"%d", indexPath.row + 1];
	BOOL isChecked = !([[stateDictionary objectForKey:key] boolValue]);
	NSNumber *checked = [NSNumber numberWithBool:isChecked];
	
	[stateDictionary setObject:checked forKey:key];
	
	cell.accessoryType = isChecked ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
	
	[self updateStateDictionaryByIndex:indexPath.row + 1];
	[self updateMusicLabelByName:cell.textLabel.text];
	[tableView reloadData];
	[tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
	[self initMusicPlayer];
	if (musicPlayButton.tag == 256) {
		[self.musicPlayer play];
	}
}

- (void)updateMusicLabelByName:(NSString *)fileName
{
	musicLabel.text = fileName;
}

- (void)updateStateDictionaryByIndex:(int)row
{
	Byte i;
	Byte count;
	NSNumber *checked = [NSNumber numberWithBool:NO];
	count = [musicArray count];
	for (i = 1; i <= count; i++) {
		if (i != row)
			[stateDictionary setObject:checked forKey:[NSString stringWithFormat:@"%d", i]];
	}
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[musicTableView release];
	[stateDictionary release];
	[musicArray release];
	//[delegate release];
	[musicLabel release];
	
	[volumnSlider release];
	[processSlider release];
	[musicPlayer release];
	[musicFileName release];
	[musicFileType release];
	[musicPlayButton release];
	[timer release];
    [super dealloc];
}


@end
