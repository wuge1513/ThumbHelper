//
//  AddClockViewCell.h
//  GeiniableClock
//
//  Created by yuan jun on 11-8-5.
//  Copyright 2011 the9. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlarmViewController;

@interface AddClockViewCell : UITableViewCell


@property (strong, nonatomic) AlarmViewController *alarmViewController;

- (IBAction)addClockBtn:(UIButton *)sender;

@end
