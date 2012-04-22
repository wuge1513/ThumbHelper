//
//  SetRepeatViewController.h
//  ThumbHelper
//
//  Created by LiuLei on 12-4-19.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SetRepeatViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *arrLastWeeks;
@property (strong, nonatomic) NSMutableArray *arrCurWeeks;

@property (strong, nonatomic) NSMutableArray *arrSelectedWeek;
@property (strong, nonatomic) NSArray *arrWeeks;
@property (strong, nonatomic) NSArray *arrShortweeks;

@property (strong, nonatomic) NSArray *arrWorkingDay;

- (void)actionBack;

@end
