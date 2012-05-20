
///
//
///

#import "UIColor_Random.h"

@implementation UIColor(Random)

//return a shared instance of UIColor
//create random color
+ (UIColor *)randomColor {
	static BOOL seeded = NO;
	if (!seeded) {
		seeded = YES;
		srandom(time(NULL));
	}
	CGFloat red = (CGFloat)random() / (CGFloat)RAND_MAX;
	CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
	CGFloat blue = (CGFloat)random() / (CGFloat)RAND_MAX;
	return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

@end