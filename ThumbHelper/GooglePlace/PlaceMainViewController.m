//
//  PlaceMainViewController.m
//  ThumbHelper
//
//  Created by LiuLei on 12-4-22.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import "PlaceMainViewController.h"
#import "BHTabStyle.h"

@implementation PlaceMainViewController

@synthesize bhTabsViewController;
@synthesize defaultView, customView;

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
    
    self.defaultView = [[DefaultPlaceViewController alloc] init];
    self.defaultView.view.bounds = CGRectMake(0.0, -40.0, 320.0, 50.0);
    
    self.customView = [[CustomPlaceViewController alloc] init];
    self.customView.view.bounds = CGRectMake(0.0, -40.0, 320.0, 62.0);
    
    self.bhTabsViewController = [[BHTabsViewController alloc] 
                                 initWithViewControllers:[[NSArray alloc] initWithObjects:self.defaultView, self.customView, nil]
                                 style:[BHTabStyle defaultStyle]];
    
    [self.view addSubview:self.bhTabsViewController.view];
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
