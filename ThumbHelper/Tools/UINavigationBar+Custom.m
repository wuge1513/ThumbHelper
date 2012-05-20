//
//  UINavigationBar+Customized.m
//  CustomizdNavBar
//
//  Created by Ethan Gao on 2011-11-23.
//  No Copyright reserved.
//

#import "UINavigationBar+Custom.h"


@implementation UINavigationBar (Customized)

- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"banner.png"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

@end
