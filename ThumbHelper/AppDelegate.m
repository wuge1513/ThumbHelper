//
//  AppDelegate.m
//  ThumbHelper
//
//  Created by LiuLei on 12-4-11.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize rootTabBarConreoller = _rootTabBarConreoller;

@synthesize homeViewController = _homeViewController;
@synthesize tasksViewController = _tasksViewController;
@synthesize placeMainViewController = _placeMainViewController;
@synthesize alarmViewController = _alarmViewController;
@synthesize settingsViewController = _settingsViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    self.rootTabBarConreoller = [[RootTabbarViewController alloc] init];
    
    
    //Home View 
    self.homeViewController = [[HomeViewController alloc] init];
    UINavigationController *HomeView = [[UINavigationController alloc] initWithRootViewController:
                                         self.homeViewController];
    HomeView.navigationBar.tintColor = [UIColor orangeColor];
    HomeView.title = @"Home";
    
    //Tasks View 
    self.tasksViewController = [[TasksViewController alloc] init];
    UINavigationController *TasksView = [[UINavigationController alloc] initWithRootViewController:
                                         self.tasksViewController];
    TasksView.navigationBar.tintColor = [UIColor orangeColor];
    TasksView.title = @"Tasks";
    
    //alarm clock
    self.alarmViewController = [[AlarmViewController alloc] init];
    UINavigationController *AlarmView = [[UINavigationController alloc] initWithRootViewController:
                                         self.alarmViewController];
    AlarmView.navigationBar.tintColor = [UIColor orangeColor];
    AlarmView.title = @"Alarms";
    
    // google place
    self.placeMainViewController = [[PlaceMainViewController alloc] init];
    UINavigationController *PlaceView = [[UINavigationController alloc] initWithRootViewController:
                                         self.placeMainViewController];
    PlaceView.navigationBar.tintColor = [UIColor orangeColor];
    PlaceView.title = @"Place";
    
    //Settings View
    self.settingsViewController = [[SettingsViewController alloc] init];
    UINavigationController *Settings = [[UINavigationController alloc] initWithRootViewController:
                                         self.settingsViewController];
    Settings.navigationBar.tintColor = [UIColor orangeColor];
    Settings.title = @"Settings";
    
    self.rootTabBarConreoller.viewControllers = [NSArray arrayWithObjects:HomeView, TasksView, AlarmView, PlaceView, Settings,nil];
    
    self.window.rootViewController = self.rootTabBarConreoller;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
