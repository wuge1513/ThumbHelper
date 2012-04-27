#import <UIKit/UIKit.h>

@class BHTabView;
@class BHTabStyle;

@protocol BHTabViewDelegate <NSObject>
- (void)didTapTabView:(BHTabView *)tabView;
@end

@interface BHTabView : UIView

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, unsafe_unretained) id <BHTabViewDelegate> delegate;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) BHTabStyle *style;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title;

@end
