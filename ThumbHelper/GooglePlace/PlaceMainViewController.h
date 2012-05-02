//
//  PlaceMainViewController.h
//  ThumbHelper
//
//  Created by LiuLei on 12-4-22.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
//#import "SVGeocoder.h"

#import "BHTabsViewController.h"
#import "DefaultPlaceViewController.h"
#import "CustomPlaceViewController.h"

@interface PlaceMainViewController : UIViewController<UISearchBarDelegate, 
CLLocationManagerDelegate>

@property (strong, nonatomic) BHTabsViewController *bhTabsViewController;
@property (strong, nonatomic) DefaultPlaceViewController *defaultView;
@property (strong, nonatomic) CustomPlaceViewController *customView;


@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UILabel *lblTopText;
@property (strong, nonatomic) UIScrollView *scrollView;
//@property (strong, nonatomic) UIButton *btnAction;
@property (strong, nonatomic) CLLocationManager *locationM;  

- (void)actionBtnAction:(id)sender;
- (IBAction)reverseGeocode;
- (IBAction)geocode;
@end
