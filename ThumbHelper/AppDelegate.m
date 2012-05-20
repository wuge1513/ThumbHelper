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

/*!
 * 方法类型：系统方法
 * 方法功能：委托类方法
 */

+(AppDelegate *)App{
	return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
	for(UILocalNotification *notification in localNotifications)
	{
		//if ([[[notification userInfo] objectForKey:@"ActivatyClock"] intValue] == clockID) {
			NSLog(@"Shutdown localNotification:%@", [notification fireDate]);
			[[UIApplication sharedApplication] cancelLocalNotification:notification];
		//}
	}
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    //Home View 
    self.homeViewController = [[HomeViewController alloc] init];
    UINavigationController *HomeView = [[UINavigationController alloc] initWithRootViewController:
                                         self.homeViewController];
    HomeView.navigationBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tools_bar_bg.png"]];
    HomeView.title = @"Home";
    HomeView.tabBarItem.image = [UIImage imageNamed:@"care.png"];

    
    //Tasks View 
    self.tasksViewController = [[TasksViewController alloc] init];
    UINavigationController *TasksView = [[UINavigationController alloc] initWithRootViewController:
                                         self.tasksViewController];
    TasksView.navigationBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tools_bar_bg.png"]];
    TasksView.title = @"Tasks";
    TasksView.tabBarItem.image = [UIImage imageNamed:@"record.png"];
    
    //alarm clock
    self.alarmViewController = [[AlarmViewController alloc] init];
    UINavigationController *AlarmView = [[UINavigationController alloc] initWithRootViewController:
                                         self.alarmViewController];
    AlarmView.navigationBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tools_bar_bg.png"]];
    AlarmView.title = @"Alarms";
    AlarmView.tabBarItem.image = [UIImage imageNamed:@"care.png"];
    
    // google place
    self.placeMainViewController = [[PlaceMainViewController alloc] init];
    UINavigationController *PlaceView = [[UINavigationController alloc] initWithRootViewController:
                                         self.placeMainViewController];
    PlaceView.navigationBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tools_bar_bg.png"]];
    PlaceView.title = @"Place";
    PlaceView.tabBarItem.image = [UIImage imageNamed:@"record.png"];
    
    //Settings View
    self.settingsViewController = [[SettingsViewController alloc] init];
    UINavigationController *Settings = [[UINavigationController alloc] initWithRootViewController:
                                         self.settingsViewController];
    Settings.navigationBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tools_bar_bg.png"]];
    Settings.title = @"Settings";
    Settings.tabBarItem.image = [UIImage imageNamed:@"change_it.png"];

    NSMutableArray *view_manager = [[NSMutableArray alloc] initWithObjects:HomeView, TasksView, AlarmView, PlaceView, Settings, nil];
    
    /*请按照上面的方法添加其他的tab控制器*/
    self.rootTabBarConreoller = [[Ivan_UITabBar alloc] init];
    [self.rootTabBarConreoller setSelectedIndex:0];
    [self.rootTabBarConreoller setViewControllers:view_manager]; 
    
    self.window.rootViewController = self.rootTabBarConreoller;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)hidesBottomBarWhenPushed
{
    [self.rootTabBarConreoller hideCustomTabBar];
}

- (void)noHidesBottomBarWhenPushed
{
    [self.rootTabBarConreoller bringCustomTabBarToFront];
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
