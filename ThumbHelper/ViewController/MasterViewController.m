//
//  MasterViewController.m
//  ThumbHelper
//
//  Created by LiuLei on 12-4-11.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import "MasterViewController.h"

#import "AlarmViewController.h"

@implementation MasterViewController

@synthesize alarmViewController;
@synthesize btnAlarm, btnPlace, btnToDo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Set background color
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //Set a Alarm button
    self.btnAlarm = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnAlarm.frame = CGRectMake(220.0, 60.0, 57.0, 57.0);
    [self.btnAlarm setTitle:NSLocalizedString(@"Alarm", nil) forState:UIControlStateNormal];
    [self.btnAlarm addTarget:self action:@selector(actionBtnAlarm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnAlarm];
    
    //Set a Place button
    self.btnPlace = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnPlace.frame = CGRectMake(220.0, 60.0 + 57.0 + 20.0, 57.0, 57.0);
    [self.btnPlace setTitle:NSLocalizedString(@"Place", nil) forState:UIControlStateNormal];
    [self.btnPlace addTarget:self action:@selector(actionBtnAlarm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnPlace];
    
    //Set a Todo button
    self.btnToDo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnToDo.frame = CGRectMake(220.0, 60.0 + 57.0 * 2 + 40.0, 57.0, 57.0);
    [self.btnToDo setTitle:NSLocalizedString(@"Todo", nil) forState:UIControlStateNormal];
    [self.btnToDo addTarget:self action:@selector(actionBtnAlarm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnToDo];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark- Button Action

- (void)actionBtnAlarm
{
    NSLog(@"Alarm...");
    if (!self.alarmViewController) {
        self.alarmViewController = [[AlarmViewController alloc] init];
    }
    [self.navigationController pushViewController:self.alarmViewController animated:YES];

}


@end
