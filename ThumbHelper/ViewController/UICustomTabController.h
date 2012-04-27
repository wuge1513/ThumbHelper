//
//  UICustomTabController.h
//  CustomTab
//
//  Created by user on 12-2-7.
//  Copyright (c) 2012年 yunhuaikong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
//仅文本
    UItabbarControllerShowStyleOnlyText=0,
//图标在上，文本在下，与官方的布局一样，只是更换了背景和选中时的图片
    UItabbarControllerShowStyleIconAndText,
    /*下面三个非公开*/
//仅文本
    UItabbarControllerShowStyleOnlyIcon,
//图标在左，文本在右
    UItabbarControllerShowStyleIconLeftAndTextRigth,
//图标在右，文本在左
    UItabbarControllerShowStyleIconRightAndTextLeft,
}UItabbarControllerShowStyle;


@interface UICustomTabController : UITabBarController
{
//button背景图片
	UIImage *normal_image;
//选中时的图片
	UIImage *select_image;
//背景图片
	UIImage *tab_bar_bg;

	NSMutableArray *tab_btn;
//故名思义，tabbar的个数
    int tab_num;
//这个很重要，是否需要自定义
    BOOL need_to_custom;
//风格,默认为UItabbarControllerShowStyleOnlyText
    UItabbarControllerShowStyle show_style;
//高度
    float show_size;
//默认选中索引,调用- (void)setSelectedIndex:(int)index进行设置
    int default_selected_index;
//字体大小和颜色
    UIColor *font_color;
    UIFont *font;
}

@property (nonatomic,retain) UIImage *normal_image;
@property (nonatomic,retain) UIImage *select_image;

//如果要实现自定义，这里必须调用此方法，否则为官方的布局
@property (nonatomic,assign) BOOL need_to_custom;
- (void)setNeed_to_custom:(BOOL)flag style:(int)style;

@property (nonatomic,assign) UItabbarControllerShowStyle show_style;;

@property (nonatomic,assign) float show_size;

@property (nonatomic,assign) UIImage *tab_bar_bg;

@property (nonatomic,retain) UIColor *font_color;

@property (nonatomic,retain) UIFont *font;

- (void) show_custom_view_layer;
- (void) add_custom_view_layer;
- (void) when_tabbar_is_selected:(int)tabID;

- (void)setHidesBottomBarWhenPushed:(BOOL)flag;

- (void)setSelectedIndex:(int)index;
@end
