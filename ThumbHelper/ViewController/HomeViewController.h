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
#import <CoreLocation/CLGeocoder.h>
#import <CoreLocation/CLPlacemark.h>
#import <MapKit/MapKit.h>

@interface HomeViewController : UIViewController<CLLocationManagerDelegate,
UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate>

//显示地图视图
@property (assign, nonatomic) BOOL isMapShowing;
@property (strong, nonatomic) UIView *mapView;
@property (strong, nonatomic) MKMapView *mkMapView;
@property (strong, nonatomic) CLLocation *curLocation;

//定位
@property (strong, nonatomic) CLLocationManager       *locationManager;
@property (assign, nonatomic) CLLocationCoordinate2D  currentLocation;
@property (assign, nonatomic) CLLocationDirection     currentHeading;
@property (assign, nonatomic) CLLocationCoordinate2D  cityLocation;
@property (assign, nonatomic) CLLocationDirection     cityHeading;

@property (strong, nonatomic) UIScrollView   *compassView;
@property (strong, nonatomic) UIImageView *imgCompassView;
@property (strong, nonatomic) UIScrollView   *cityArrowView;

//显示地址 反向地理编码
@property (strong, nonatomic) CLGeocoder *clGeocoder;

@property (strong, nonatomic) UITextView *lblMyLocation;
@property (strong, nonatomic) UIButton *btnMyLocation;

//便签，快速记事
@property (strong, nonatomic) UIButton *btnAddTips;
//列表
@property (strong, nonatomic) UITableView *tbTipList;

@property (strong, nonatomic) NSMutableArray *arrTipItems;

- (void)customInitialize;
- (void)startLocationHeadingEvents;  
- (void)updateHeadingDisplays;

//地图标注
- (void)showMap;
- (void)actionShowItemOnMap;
- (void)setCurrentLocation:(CLLocation *)location;
- (void)locationAddressWithLocation:(CLLocation *)locationGps; //>=5.0
@end
