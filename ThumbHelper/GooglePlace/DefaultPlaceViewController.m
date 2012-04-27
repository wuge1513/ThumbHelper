//
//  DefaultPlaceViewController.m
//  ThumbHelper
//
//  Created by LiuLei on 12-4-27.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import "DefaultPlaceViewController.h"

@implementation DefaultPlaceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
     self.view.backgroundColor = [UIColor colorWithWhite:220/255.0 alpha:1];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 40.0, 180.0, 30.0)];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.text= @"The first view.";
    [self.view addSubview:lbl];
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
