//
//  ClockCell.h
//  GeiniableClock
//
//  Created by yuan jun on 11-8-9.
//  Copyright 2011 the9. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlarmViewController;

@interface ClockCell : UITableViewCell

@property (strong, nonatomic) AlarmViewController *alarmViewController;
@property (strong, nonatomic) IBOutlet UISwitch *clockSwitch;
@property (strong, nonatomic) IBOutlet UILabel *clockTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *clockModeLabel;
@property (strong, nonatomic) IBOutlet UILabel *clockSceneLabel;
@property (strong, nonatomic) NSString *clockMusic;
@property (strong, nonatomic) NSString *clockRemember;
@property (assign, nonatomic) NSInteger numberID;
@property (assign, nonatomic) CGPoint firstTouchPoint;
@property (assign, nonatomic) CGPoint lastTouchPoint;

- (IBAction)clockBtn:(UIButton *)sender;
- (IBAction)switchBtn:(UISwitch *)sender;
- (void)setUIFontAndColor;

@end
