//
//  HomeViewController.m
//  ThumbHelper
//
//  Created by LiuLei on 12-4-24.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import "HomeViewController.h"

#import <CoreLocation/CLHeading.h>
#import "math.h"

#define toRad(X) (X*M_PI/180.0)
#define toDeg(X) (X*180.0/M_PI)

@implementation HomeViewController

//定位
@synthesize locationManager, cityHeading, cityLocation, currentHeading, currentLocation;
@synthesize cityArrowView, compassView, imgCompassView;
@synthesize tbTipList;
@synthesize arrTipItems;
@synthesize lblMyLocation;
@synthesize btnMyLocation, btnAddTips;
@synthesize clGeocoder, mkRG;

- (void)customInitialize
{
    self.cityHeading = 0.0;
    self.currentHeading = 0.0;
    self.cityArrowView.alpha = 0.0;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Home", nil);
        [self customInitialize];
        
        NSArray *arr = [NSArray arrayWithObjects:@"123", @"123", @"123", @"123", @"123", @"123", @"123", @"123", @"123", @"123", nil];
        self.arrTipItems = [[NSMutableArray alloc] initWithArray:arr];
        
        
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
    
    //背景
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 367.0)];
    bgImageView.image = [UIImage imageNamed:@"bg_main_bg.png"];
    [self.view addSubview:bgImageView];
    
    [self customInitialize];
    
    UIImage *imgCompass = [UIImage imageNamed:@"compass.png"];
    CGRect rectArrow = CGRectMake(0.0, 0.0, imgCompass.size.width, imgCompass.size.height);
//    self.compassView = [[UIScrollView alloc] initWithFrame:rectArrow];
//    self.compassView.center = CGPointMake(320.0 / 2, 416.0 / 2);
//    self.compassView.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:self.compassView];
    
    self.imgCompassView = [[UIImageView alloc] initWithFrame:rectArrow];
    imgCompassView.frame = CGRectMake(0.0, 0.0, 120.0, 120.0);
    imgCompassView.center = CGPointMake(120.0 / 2 + 15.0, 120.0 / 2 + 10.0);
    imgCompassView.image = imgCompass;
    [self.view addSubview:imgCompassView];
    
    //我的位置
    CGRect lblRect = CGRectMake(20.0, 25.0, 130.0, 50.0);
    self.lblMyLocation = [[UITextView alloc] initWithFrame:lblRect];
    self.lblMyLocation.center = CGPointMake(120.0 / 2 + 20.0, 120.0 + 40.0);
    self.lblMyLocation.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_cell_alarm.png"]];
    self.lblMyLocation.text = @"北京";
    self.lblMyLocation.userInteractionEnabled = NO;
    //self.lblMyLocation.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.lblMyLocation];
    
    //我的位置on map
    self.btnMyLocation = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnMyLocation.frame = CGRectMake(0.0, 0.0, 130.0, 30.0);
    self.btnMyLocation.center = CGPointMake(120.0 / 2 + 20.0, 120.0 + 90.0);
    [self.btnMyLocation setTitle:@"On Map" forState:UIControlStateNormal];
    [self.view addSubview:self.btnMyLocation ];
    
    //快速备忘
    UIImage *imgAddTips = [UIImage imageNamed:@"btn_AddTips.png"];
    self.btnAddTips = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnAddTips setImage:imgAddTips forState:UIControlStateNormal];
    self.btnAddTips.frame = CGRectMake(0.0, 0.0, 135.0, 120.0);
    self.btnAddTips.center = CGPointMake(120.0 / 2 + 20.0, 120.0 + 90.0 + 90.0);
    [self.view addSubview:self.btnAddTips];
    
    CGRect rectTb = CGRectMake(155.0, 10.0, 160.0, 367.0 - 20.0);
    self.tbTipList = [[UITableView alloc] initWithFrame:rectTb style:UITableViewStylePlain];
    self.tbTipList.backgroundColor = [UIColor clearColor];
    self.tbTipList.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tbTipList.delegate = self;
    self.tbTipList.dataSource = self;
    [self.view addSubview:self.tbTipList];
}


- (void)viewDidUnload
{
    //self.compassView = nil;
    //self.cityArrowView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self startLocationHeadingEvents];  
    [self updateHeadingDisplays];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.locationManager) {
        [locationManager stopUpdatingHeading];
        [locationManager stopUpdatingLocation];
    }
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark -
#pragma mark UITableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.arrTipItems count] < 8) {
        return 8;
    }
    
    return [self.arrTipItems count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //if (cell == nil) {
    cell = [[UITableViewCell alloc]
            initWithStyle:UITableViewCellStyleDefault
            reuseIdentifier:cellIdentifier];
    //}
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_cell_small.png"]];
    cell.backgroundColor = [UIColor clearColor];
        
    if (indexPath.row < [self.arrTipItems count]) {
        cell.imageView.image = [UIImage imageNamed:@"icon_cell.png"];
        cell.textLabel.text = [self.arrTipItems objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text = @"";
    }
    
    
    return cell;
}


#pragma mark -
#pragma mark 指南针
- (void)updateHeadingDisplays {
    // Animate Compass
    [UIView     animateWithDuration:0.3
                              delay:0.0 
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             CGAffineTransform headingRotation;
                             headingRotation = CGAffineTransformRotate(CGAffineTransformIdentity, (CGFloat)-toRad(currentHeading));
                             self.imgCompassView.transform = headingRotation;
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    // Animate Pointer
    [UIView     animateWithDuration:0.6
                              delay:0.0 
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             CGAffineTransform headingRotation;
                             headingRotation = CGAffineTransformRotate(CGAffineTransformIdentity, (CGFloat)toRad(cityHeading)-toRad(currentHeading));
                             self.cityArrowView.transform = headingRotation;
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    
    // Animate Text
    [UIView     animateWithDuration:1.2
                              delay:0.0 
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             CGAffineTransform headingRotation;
                             headingRotation = CGAffineTransformRotate(CGAffineTransformIdentity, (CGFloat)toRad(cityHeading)-toRad(currentHeading));
                             //UITextView.transform = headingRotation;
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"latitude %+.6f, longitude %+.6f\n",
          newLocation.coordinate.latitude,
          newLocation.coordinate.longitude);
    currentLocation = newLocation.coordinate;
    [self updateHeadingDisplays];

    // else skip the event and process the next one.
    [manager stopUpdatingLocation];
    
    //解析并获取当前坐标对应得地址信息

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
        [self locationAddressWithLocation:newLocation];
    }else {
        [self startedReverseGeoderWithLatitude:newLocation.coordinate];
    }
}

#pragma mark -
#pragma mark 反向地理
//   iso  5.0 以下版本使用此方法
- (void)startedReverseGeoderWithLatitude:(CLLocationCoordinate2D)coordinate2d{
    self.mkRG = [[MKReverseGeocoder alloc] initWithCoordinate:coordinate2d];   
    self.mkRG.delegate = self;
    [self.mkRG start];
}
#pragma mark -
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
{
    NSLog(@"地址1：%@", placemark.addressDictionary);
}
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
{
    NSLog(@"获取失败");
}

//  IOS 5.0 及以上版本使用此方法
- (void)locationAddressWithLocation:(CLLocation *)locationGps
{
    self.clGeocoder = [[CLGeocoder alloc] init];
    
    [self.clGeocoder reverseGeocodeLocation:locationGps completionHandler:^(NSArray *placemarks, NSError *error) 
     {
         NSLog(@"error %@ placemarks count %d",error.localizedDescription,placemarks.count);
         for (CLPlacemark *placeMark in placemarks) 
         {
//             NSLog(@"地址：%@",placeMark.locality);
//             NSLog(@"地址：%@",placeMark.thoroughfare);
//             NSLog(@"地址：%@",placeMark.subLocality);
             
             self.lblMyLocation.text = [NSString stringWithFormat:@"%@,%@,%@", placeMark.thoroughfare, placeMark.subLocality, placeMark.locality];
         }
     }];
}


- (void)startLocationHeadingEvents {
    if (!self.locationManager) {
        CLLocationManager* theManager = [[CLLocationManager alloc] init];
        
        // strong the object in a property.
        self.locationManager = theManager;
        locationManager.delegate = self;
    }
    
    // Start location services to get the true heading.
    locationManager.distanceFilter = 1;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    [locationManager startUpdatingLocation];
    
    // Start heading updates.
    if ([CLLocationManager headingAvailable]) {
        locationManager.headingFilter = 5;
        [locationManager startUpdatingHeading];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    if (newHeading.headingAccuracy < 0)
        return;
    
    // Use the true heading if it is valid.
    CLLocationDirection  theHeading = ((newHeading.trueHeading > 0) ?
                                       newHeading.trueHeading : newHeading.magneticHeading);
    
    self.currentHeading = theHeading;
    [self updateHeadingDisplays];
}
-(CLLocationDirection) directionFrom: (CLLocationCoordinate2D) startPt to:(CLLocationCoordinate2D) endPt {
    double lat1 = toRad(startPt.latitude);
    double lat2 = toRad(endPt.latitude);
    double lon1 = toRad(startPt.longitude);
    double lon2 = toRad(endPt.longitude);
    double dLon = (lon2-lon1);
    
    double y = sin(dLon) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
    double brng = toDeg(atan2(y, x));
    
    brng = (brng+360);
    brng = (brng>360)? (brng-360) : brng;
    
    return brng;
}

@end
