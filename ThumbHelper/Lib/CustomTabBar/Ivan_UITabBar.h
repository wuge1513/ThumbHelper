//
//  Ivan_UITabBar.h
//  JustForTest
//
//  Created by Ivan on 11-5-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Ivan_UITabBar : UITabBarController {
	NSMutableArray *buttons;
	int currentSelectedIndex;
	UIImageView *slideBg;
	UIView *cusTomTabBarView;
	UIImageView *backGroundImageView;
}

@property (nonatomic, assign) int currentSelectedIndex;
@property (nonatomic,strong) NSMutableArray *buttons;
@property (strong, nonatomic) UILabel *titleLabel;

- (void)hideRealTabBar;
- (void)hideCustomTabBar;
- (void)bringCustomTabBarToFront;
- (void)customTabBar;
- (void)selectedTab:(UIButton *)button;

@end
