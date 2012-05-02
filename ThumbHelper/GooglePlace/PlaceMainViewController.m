//
//  PlaceMainViewController.m
//  ThumbHelper
//
//  Created by LiuLei on 12-4-22.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import "PlaceMainViewController.h"
#import "BHTabStyle.h"

#define kSEARCH_BAR_HEIGHT      44.0
#define kTOPLABEL_HEIGHT        30.0

#define kITEM_NUM               4
#define kITEM_ROW_NUM           3
#define kITEM_COL_NUM           3

@implementation PlaceMainViewController

@synthesize bhTabsViewController;
@synthesize defaultView, customView;
@synthesize searchBar;
@synthesize lblTopText;
@synthesize scrollView;
//@synthesize btnAction;
@synthesize locationM;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Google Place", nil);
        
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(actionToBack)]; 
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
//    //Default View
//    self.defaultView = [[DefaultPlaceViewController alloc] init];
//    //Custom View
//    self.customView = [[CustomPlaceViewController alloc] init];
//    
//    self.bhTabsViewController = [[BHTabsViewController alloc] 
//                                 initWithViewControllers:[[NSArray alloc] initWithObjects:self.defaultView, self.customView, nil]
//                                 style:[BHTabStyle defaultStyle]];
//    
//    [self.view addSubview:self.bhTabsViewController.view];
    
    
    //custom search bar
    CGRect rectSearchBar = CGRectMake(0.0, 0.0, 320.0, kSEARCH_BAR_HEIGHT);
    self.searchBar = [[UISearchBar alloc] initWithFrame:rectSearchBar];
    self.searchBar.delegate = self;
    self.searchBar.showsCancelButton = YES;
    [self.view addSubview:self.searchBar];
    
    //Top text label
    CGRect rectLableText = CGRectMake(0.0, 44.0, 320.0, kTOPLABEL_HEIGHT);
    self.lblTopText = [[UILabel alloc] initWithFrame:rectLableText];
    self.lblTopText.text = @"123";
    [self.view addSubview:self.lblTopText];
    
    //bg scroll view
    CGRect rectScrollView = CGRectMake(0.0, kSEARCH_BAR_HEIGHT + kTOPLABEL_HEIGHT, 
                                       320.0, 480.0);
    self.scrollView = [[UIScrollView alloc] initWithFrame:rectScrollView];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(320.0, 490.0);
    [self.view addSubview:scrollView];
    
    //action button
    for (NSInteger row = 0; row < kITEM_ROW_NUM; row++) {
        for (NSInteger col = 0; col < kITEM_COL_NUM; col++) {
            UIButton *btnAction = [UIButton buttonWithType:UIButtonTypeInfoLight];
            btnAction.tag = 1000 + col + row * 3;
            [btnAction setTitle:@"134" forState:UIControlStateNormal];
            [btnAction addTarget:self action:@selector(actionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            btnAction.frame = CGRectMake(30.0 + 100.0 * col, 30.0 + 80.0 * row, 57.0, 57.0);
            [self.scrollView addSubview:btnAction];
        }
    }
    
    //获取定位信息
    self.locationM = [[CLLocationManager alloc] init];  
    //是否开启定位服务
    if ([self.locationM locationServicesEnabled]) {  
        self.locationM.delegate = self;  
        //精确度
        self.locationM.desiredAccuracy = kCLLocationAccuracyBest;
        //指定设备必须移动多少距离位置信息才会更新，这个属性的单位是米,可以使用kCLDistanceFilterNone常量
        self.locationM.distanceFilter = 100.0f;
        //启动位置管理器
        [self.locationM startUpdatingLocation];  
    } 
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)actionBtnAction:(id)sender
{
    UIButton *btnTemp = (UIButton *)sender;
   
    switch (btnTemp.tag) {
        case 1000:
            NSLog(@"123 = %d", btnTemp.tag); 
            break;
        case 1001:
             NSLog(@"123 = %d", btnTemp.tag); 
            break;
        case 1002:
             NSLog(@"123 = %d", btnTemp.tag); 
            break;
        case 1003:
             NSLog(@"123 = %d", btnTemp.tag); 
            break;
        case 1004:
             NSLog(@"123 = %d", btnTemp.tag); 
            break;
        case 1005:
             NSLog(@"123 = %d", btnTemp.tag); 
            break;
        case 1006:
             NSLog(@"123 = %d", btnTemp.tag); 
            break;
        case 1007:
             NSLog(@"123 = %d", btnTemp.tag); 
            break;
        case 1008:
             NSLog(@"123 = %d", btnTemp.tag); 
            break;
            
        default:
            break;
    }
}


#pragma mark - UISearchBar delegate
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
}

#pragma mark-
#pragma mark-定位服务

//获得一个新的定位值时
- (void) locationManager: (CLLocationManager *) manager  
     didUpdateToLocation: (CLLocation *) newLocation  
            fromLocation: (CLLocation *) oldLocation{  
    NSString *lat = [[NSString alloc] initWithFormat:@"%g",  
                     newLocation.coordinate.latitude];  
    //纬度
    //latitudeTextField.text = lat;  
    
    NSString *lng = [[NSString alloc] initWithFormat:@"%g",  
                     newLocation.coordinate.longitude];
    //精度
    //longitudeTextField.text = lng;  
    
    
    //horizontalAccuracy属性可以指定精度范围，单位是米
    NSString *acc = [[NSString alloc] initWithFormat:@"%g",  
                     newLocation.horizontalAccuracy];  
    //accuracyTextField.text = acc; 
    
//    [SVGeocoder reverseGeocode:CLLocationCoordinate2DMake(lat.floatValue, lng.floatValue)
//                    completion:^(NSArray *placemarks, NSError *error) {
//                        UIAlertView *alertView;
//                        
//                        if(!error && placemarks) {
//                            SVPlacemark *placemark = [placemarks objectAtIndex:0];
//                            alertView = [[UIAlertView alloc] initWithTitle:@"Placemark Found!" message:[placemark description] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                        } else {
//                            alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error description] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                        }
//                        
//                        [alertView show];
//                    }];
    
}  

//位置管理器不能确定位置信息
- (void) locationManager: (CLLocationManager *) manager  
        didFailWithError: (NSError *) error {  
    NSString *msg = [[NSString alloc]  
                     initWithString:@"Error obtaining location"];  
    UIAlertView *alert = [[UIAlertView alloc]  
                          initWithTitle:@"Error"  
                          message:msg  
                          delegate:nil  
                          cancelButtonTitle: @"Done"  
                          otherButtonTitles:nil];  
    [alert show];      
}  

@end
