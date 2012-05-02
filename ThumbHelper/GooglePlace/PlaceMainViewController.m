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
- (void)customUIView
{
    //custom search bar
    CGRect rectSearchBar = CGRectMake(0.0, 0.0, 320.0, kSEARCH_BAR_HEIGHT);
    self.searchBar = [[UISearchBar alloc] initWithFrame:rectSearchBar];
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
    self.scrollView.backgroundColor = [UIColor orangeColor];
    self.scrollView.scrollEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(320.0, 520.0);
    [self.view addSubview:scrollView];
    
    //action button
    for (NSInteger row = 0; row < kITEM_ROW_NUM; row++) {
        for (NSInteger col = 0; col < kITEM_COL_NUM; col++) {
            UIButton *btnAction = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btnAction.frame = CGRectMake(30.0 + 100.0 * col, 40.0 + 80.0 * row, 57.0, 57.0);
            [self.scrollView addSubview:btnAction];
        }
 
    }

}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self customUIView];
    
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


@end
