#import <UIKit/UIKit.h>

@class BHTabStyle;

@interface BHTabsView : UIView {
  NSArray *tabViews;
  BHTabStyle *style;
}

@property (nonatomic, strong) NSArray *tabViews;
@property (nonatomic, strong) BHTabStyle *style;


@end
