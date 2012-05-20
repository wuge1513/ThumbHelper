#import <Foundation/Foundation.h>

@interface BHTabStyle : NSObject 

// The height in points of the tabs container view.
// The default is 50 points.

@property (nonatomic, assign) NSUInteger tabsViewHeight;

// The height of each tab in points.
// The default is 40 points.

@property (nonatomic, assign) NSUInteger tabHeight;

// The height of the bar under the tabs.
// The default is 10 points. 

@property (nonatomic, assign) NSUInteger tabBarHeight;

// What percentage of a tab's width should be used to overlap
// tabs with previous tabs?  E.g. 0.2 = 20%.  If this is set to
// 0 a tab's left-most point does not overlap with the previous
// tab's right-most point.

@property (nonatomic, assign) CGFloat overlapAsPercentageOfTabWidth;

// The radius of the shadow rendered behind and above the tabs.
// The default is 3 points.

@property (nonatomic, assign) CGFloat shadowRadius;

@property (nonatomic, strong) UIColor *selectedTabColor;
@property (nonatomic, strong) UIColor *selectedTitleTextColor;
@property (nonatomic, strong) UIFont  *selectedTitleFont;
@property (nonatomic, assign) CGSize   selectedTitleShadowOffset;
@property (nonatomic, strong) UIColor *selectedTitleShadowColor;

@property (nonatomic, strong) UIColor *unselectedTabColor;
@property (nonatomic, strong) UIColor *unselectedTitleTextColor;
@property (nonatomic, strong) UIFont  *unselectedTitleFont;
@property (nonatomic, assign) CGSize   unselectedTitleShadowOffset;
@property (nonatomic, strong) UIColor *unselectedTitleShadowColor;

+ (BHTabStyle *)defaultStyle;

@end

