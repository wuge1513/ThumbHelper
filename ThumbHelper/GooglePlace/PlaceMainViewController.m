//
//  PlaceMainViewController.m
//  ThumbHelper
//
//  Created by LiuLei on 12-4-22.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import "PlaceMainViewController.h"
#import "BHTabStyle.h"
#import "DetailViewController.h"


#import "SBJson.h" 
#import "NSString+SBJSON.h"
#import "AppDelegate.h"



#define kLOAD_IMAGES_NUM_FIRST     5

#define kSEARCH_BAR_HEIGHT      44.0
#define kTOPLABEL_HEIGHT        30.0

#define kITEM_NUM               4
#define kITEM_ROW_NUM           2
#define kITEM_COL_NUM           3

@implementation PlaceMainViewController

@synthesize bhTabsViewController;
@synthesize defaultView, customView;
@synthesize searchBar;
@synthesize lblTopText;
@synthesize scrollView;
@synthesize locationM;

@synthesize detailViewController = _detailViewController;
@synthesize curLocation;
@synthesize strLongitude, strAccuracy, strLatitude;
@synthesize hud;
@synthesize arrItemText, receivedData, arrGeometry;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Google Place", nil);
        
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(actionToBack)]; 
        
        
        //初始化存储数组
        NSMutableArray *_arrItemText = [[NSMutableArray alloc] init];
        self.arrItemText = _arrItemText;
        
        NSMutableData *_data = [[NSMutableData alloc] init];
        self.receivedData = _data;
        
        NSMutableArray *_arrGeometry = [[NSMutableArray alloc] init];
        self.arrGeometry = _arrGeometry;
        

        
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
            UIButton *btnAction = [UIButton buttonWithType:UIButtonTypeCustom];
            btnAction.backgroundColor = [UIColor clearColor];
            btnAction.tag = 1000 + col + row * 3;
            NSString *imgName = [NSString stringWithFormat:@"index%d.png", col + row * 3];
            [btnAction setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
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
    
//    self.tfType.text = @"food";
//    self.tfRadius.text = @"1000";
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
            [self btnAction:nil];
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
    
    self.hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:self.hud];
    self.hud.labelText = @"正在加载...";
    [self.hud show:YES];
}


#pragma mark - UISearchBar delegate
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
}

/*Place Search 请求
 location（必填）– 在其周围检索“地方”信息的纬度/经度。此参数必须作为 google.maps.LatLng 对象提供。
 radius（必填）– 要在其范围内返回的“地方”结果的距离（以米为单位）。推荐的最佳做法是根据位置传感器指定的地方信号的精确度来设置 radius。请注意，您可以将 radius 偏向结果设为指定的区域，但无法将结果完全限制在指定区域中。
 types（可选）– 将结果限制为至少匹配一种指定类型的“地方”。类型应使用竖线符号 (type1|type2|etc) 进行分隔。请参见支持的类型列表。
 language（可选）– 语言代码，表示返回结果时应使用的语言（如果可能的话）。请参见支持的语言列表及其代码。请注意，我们会经常更新支持的语言，因此该列表可能并不详尽。
 name（可选）– 要与“地方”的名称进行匹配的字词。这会将结果限制为包含传递的 name 值的结果。当加入名称时，系统可能会扩大搜索范围，以确保获得适量的结果。
 sensor（必填）- 表示位置请求是否来自于使用位置传感器（如 GPS）的设备，从而确定此请求中发送的位置。该值必须为 true 或 false。
 key（必填）– 您的应用程序的 API 密钥。此密钥用于标识您的应用程序，以便管理配额，从而让您的应用程序添加的“地方”可立即在该应用程序中使用。要创建 API 项目并获取密钥，请访问 API 控制台。
 */


- (void)btnAction:(id)sender
{
    
    NSLog(@"===%@,%@", self.strLatitude, self.strLongitude);
    NSString *strLocation = [NSString stringWithFormat:@"%@,%@",self.strLatitude, self.strLongitude];
    NSString *strRadius = @"1000";
    NSString *strTypes = @"food"; 
    NSString *strName = @"";
    NSString *strSensor = @"false";
    NSString *strKey = API_KEY;
    
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSString *strURL = [NSString stringWithFormat:@"%@location=%@&radius=%@&types=%@&name=%@&sensor=%@&key=%@", PLACEAPI_SEARCHURL_JSON, strLocation, strRadius, strTypes, strName, strSensor, strKey];
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSLog(@"url = %@", url);
	NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
	[req setHTTPMethod:@"GET"];
	[NSURLConnection connectionWithRequest:req delegate:self];
    
}

#pragma mark -
#pragma mark NSURLConnection

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
	[self.receivedData setLength:0];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[self.receivedData appendData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection{
    
    [self.hud removeFromSuperview];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    
    NSString *str = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"str = %@", str);
    
    NSMutableDictionary *jsonDic = [str JSONValue];
    NSLog(@"123 = %@", jsonDic);
    
    NSArray *arr = [jsonDic objectForKey:@"results"];
    NSLog(@"456 = %@", arr);
    
    self.arrItemText = [NSArray arrayWithArray:arr];
    
    for (NSInteger i = 0; i < kLOAD_IMAGES_NUM_FIRST; i++) {

        NSDictionary *dic = [self.arrItemText objectAtIndex:i];
        
        //位置坐标 前5个
        NSDictionary *dicGeometry = [dic objectForKey:@"geometry"];
        [self.arrGeometry addObject:dicGeometry];
        NSLog(@"no %d",i);
        
    }
    
    DetailViewController *dc = [[DetailViewController alloc] init];
    dc.muArray = self.arrItemText;
    dc.lat = [self.strLatitude floatValue];
    dc.lng = [self.strLongitude floatValue];
    dc.arrGeometry = self.arrGeometry;
    dc.curLocation = self.curLocation;
    
    dc.hidesBottomBarWhenPushed = YES;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate hidesBottomBarWhenPushed];
    [self.navigationController pushViewController:dc animated:YES];
    
}

#pragma mark-
#pragma mark-定位服务

//获得一个新的定位值时
- (void) locationManager: (CLLocationManager *) manager  
     didUpdateToLocation: (CLLocation *) newLocation  
            fromLocation: (CLLocation *) oldLocation{  
    
    self.curLocation = newLocation;
    
    NSString *lat = [[NSString alloc] initWithFormat:@"%g",  
                     newLocation.coordinate.latitude];  
    //纬度
    self.strLatitude = lat;  
    
    NSString *lng = [[NSString alloc] initWithFormat:@"%g",  
                     newLocation.coordinate.longitude];
    //精度
    self.strLongitude = lng;  
    
    
//    //horizontalAccuracy属性可以指定精度范围，单位是米
//    NSString *acc = [[NSString alloc] initWithFormat:@"%g",  
//                     newLocation.horizontalAccuracy];  
    
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
