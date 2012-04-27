//
//  SetRepeatViewController.h
//  ThumbHelper
//
//  Created by LiuLei on 12-4-19.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SetMusicDelegate <NSObject>
- (NSString *)setAlarmMusic:(NSString *)alarmMusic;
@end

@interface SetMusicViewController : UITableViewController

@property (strong, nonatomic) id <SetMusicDelegate> delegate;// 定义委托对象
@property (strong, nonatomic) NSIndexPath *lastIndexPath;
@property (strong, nonatomic) NSString *strSelectedMusic;
@property (strong, nonatomic) NSArray *arrMusics;

@end
