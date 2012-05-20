//
//  AppDelegate.h
//  ThumbHelper
//
//  Created by LiuLei on 12-4-11.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICustomTabController.h"

#import "HomeViewController.h"
#import "TasksViewController.h"
#import "AlarmViewController.h"
#import "PlaceMainViewController.h"
#import "SettingsViewController.h"
#import "Ivan_UITabBar.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) Ivan_UITabBar *rootTabBarConreoller;//UICustomTabController

@property (strong, nonatomic) HomeViewController *homeViewController;
@property (strong, nonatomic) TasksViewController *tasksViewController;
@property (strong, nonatomic) AlarmViewController *alarmViewController;
@property (strong, nonatomic) PlaceMainViewController *placeMainViewController;
@property (strong, nonatomic) SettingsViewController *settingsViewController;


- (void)hidesBottomBarWhenPushed;
- (void)noHidesBottomBarWhenPushed;

@end
