//
//  PlaceMainViewController.h
//  ThumbHelper
//
//  Created by LiuLei on 12-4-22.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHTabsViewController.h"
#import "DefaultPlaceViewController.h"
#import "CustomPlaceViewController.h"

@interface PlaceMainViewController : UIViewController

@property (strong, nonatomic) BHTabsViewController *bhTabsViewController;
@property (strong, nonatomic) DefaultPlaceViewController *defaultView;
@property (strong, nonatomic) CustomPlaceViewController *customView;
@end
