//
//  SetRepeatViewController.h
//  ThumbHelper
//
//  Created by LiuLei on 12-4-19.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SetRepeatViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tbWeeklist;
@property (strong, nonatomic) NSMutableArray *arrLastWeeks;
@property (strong, nonatomic) NSMutableArray *arrCurWeeks;

@property (strong, nonatomic) NSMutableArray *arrSelectedWeek;
@property (strong, nonatomic) NSArray *arrWeeks;
@property (strong, nonatomic) NSArray *arrShortweeks;

@property (strong, nonatomic) NSArray *arrWorkingDay;
@property (strong, nonatomic) NSArray *arrDayEn;
- (void)actionBack;

@end
