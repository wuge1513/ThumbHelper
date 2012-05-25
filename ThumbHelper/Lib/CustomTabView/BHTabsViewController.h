#import <UIKit/UIKit.h>
#import "BHTabView.h"

@class BHTabsViewController;
@class BHTabsFooterView;
@class BHTabStyle;
@class BHTabsView;

@protocol BHTabsViewControllerDelegate <NSObject>
@optional

- (BOOL)shouldMakeTabCurrentAtIndex:(NSUInteger)index
                         controller:(UIViewController *)viewController
                   tabBarController:(BHTabsViewController *)tabBarController;

- (void)didMakeTabCurrentAtIndex:(NSUInteger)index
                      controller:(UIViewController *)viewController
                tabBarController:(BHTabsViewController *)tabBarController;

@end

@interface BHTabsViewController : UIViewController <BHTabViewDelegate> {
  NSArray *viewControllers;
    
  UIView *__weak contentView;

  
  BHTabsView *tabsContainerView;
  BHTabsFooterView *footerView;
  BHTabStyle *tabStyle;
  NSUInteger currentTabIndex;
  id <BHTabsViewControllerDelegate> __unsafe_unretained delegate;
}

@property (nonatomic, unsafe_unretained) id <BHTabsViewControllerDelegate> delegate;
@property (nonatomic, weak, readonly) UIView *contentView;
@property (nonatomic, strong) BHTabStyle *style;

- (id)initWithViewControllers:(NSArray *)viewControllers
                        style:(BHTabStyle *)style;

@end
