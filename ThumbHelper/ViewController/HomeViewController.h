//
//  HomeViewController.h
//  ThumbHelper
//
//  Created by LiuLei on 12-4-24.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreLocation/CLLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

@interface HomeViewController : UIViewController<CLLocationManagerDelegate,
UITableViewDelegate, UITableViewDataSource>

//定位
@property (strong, nonatomic) CLLocationManager       *locationManager;
@property (assign, nonatomic) CLLocationCoordinate2D  currentLocation;
@property (assign, nonatomic) CLLocationDirection     currentHeading;
@property (assign, nonatomic) CLLocationCoordinate2D  cityLocation;
@property (assign, nonatomic) CLLocationDirection     cityHeading;

@property (strong, nonatomic) UIScrollView   *compassView;
@property (strong, nonatomic) UIImageView *imgCompassView;
@property (strong, nonatomic) UIScrollView   *cityArrowView;

//显示地址
@property (strong, nonatomic) UILabel *lblMyLocation;
@property (strong, nonatomic) UIButton *btnMyLocation;

//便签，快速记事
//列表
@property (strong, nonatomic) UITableView *tbTipList;

@property (strong, nonatomic) NSMutableArray *arrTipItems;

- (void)customInitialize;
- (void)startLocationHeadingEvents;  
- (void)updateHeadingDisplays;
@end
