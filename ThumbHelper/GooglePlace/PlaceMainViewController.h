//
//  PlaceMainViewController.h
//  ThumbHelper
//
//  Created by LiuLei on 12-4-22.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "BHTabsViewController.h"
#import "DefaultPlaceViewController.h"
#import "CustomPlaceViewController.h"
#import "MBProgressHUD.h"

@class DetailViewController;

@interface PlaceMainViewController : UIViewController<UISearchBarDelegate, 
CLLocationManagerDelegate>

@property (strong, nonatomic) BHTabsViewController *bhTabsViewController;
@property (strong, nonatomic) DefaultPlaceViewController *defaultView;
@property (strong, nonatomic) CustomPlaceViewController *customView;
@property (strong, nonatomic) DetailViewController *detailViewController;


@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UILabel *lblTopText;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) CLLocationManager *locationM;  
@property (strong, nonatomic) CLLocation *curLocation;

@property (strong, nonatomic) NSString *strLatitude;
@property (strong, nonatomic) NSString *strLongitude;
@property (strong, nonatomic) NSString *strAccuracy;


@property (strong, nonatomic) NSMutableData *receivedData;

@property (strong, nonatomic) NSMutableArray *arrItemText;//位置信息
@property (strong, nonatomic) NSMutableArray *arrGeometry;//地理坐标


@property (strong, nonatomic) MBProgressHUD *hud;



- (void)actionBtnAction:(id)sender;
- (void)btnAction:(id)sender;

@end
