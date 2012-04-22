//
//  MasterViewController.h
//  ThumbHelper
//
//  Created by LiuLei on 12-4-11.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlarmViewController;
@class PlaceMainViewController;

@interface MasterViewController : UITabBarController

@property (strong, nonatomic) UITabBarItem *tab;

@property (strong, nonatomic) UIButton *btnAlarm;
@property (strong, nonatomic) UIButton *btnPlace;
@property (strong, nonatomic) UIButton *btnToDo;

@property (strong, nonatomic) AlarmViewController *alarmViewController;
@property (strong, nonatomic) PlaceMainViewController *placeMainViewController;

- (void)actionBtnAlarm;
- (void)actionBtnPlace;
@end
