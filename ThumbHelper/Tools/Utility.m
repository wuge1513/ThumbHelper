//
//  UtilityClass.m
//  GpsService
//
//  Created by LiuLei on 12-2-27.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import "Utility.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Utility

static const NSInteger LOCAL_RAND_MAX = 10;

/**
 *获取格式化系统时间
 * @param  timeFormat 输出系统时间格式 yyyy-MM-dd HH:mm:ss.SSS 可以精确到毫秒
 */
+ (NSString *)getSystemTime:(NSString *)timeFormatStr{
    
    NSString *_curTime = nil;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:timeFormatStr];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];//精确到毫秒
    //NSLog(@"Date%@", [dateFormatter stringFromDate:[NSDate date]]);
    _curTime = [dateFormatter stringFromDate:[NSDate date]];

    return _curTime;

}

/**
 * 校验随机数是否已存在
 * @param muArray数组内存放NSNumber数据
 * @param num 生成的随机数
 */
+ (BOOL)checkNum:(NSMutableArray *)muArray randNum:(NSInteger)num{
    for (int i = 0; i < [muArray count]; i++) {
        if ([NSNumber numberWithInteger:num] == [muArray objectAtIndex:i])
            return false;
    }
    return true;
}

#pragma mark-
#pragma mark-取得随机数数组
/**
 * 获取N个不重复的随机数 封装成NSNumber类型存入数组 
 * @param count 生成随机数个数
 */
+ (NSMutableArray *)getRandArray:(NSInteger)count{
    
    NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:count];
    NSInteger i = 0;
    while (i < count) { 
        NSInteger num = arc4random()%LOCAL_RAND_MAX;
        if ([self checkNum:muArray randNum:num]) {
            [muArray addObject:[NSNumber numberWithInteger:num]];
            i++;
            //NSLog(@"随机数===%d",num);
        }
    }
    return muArray;
}

#pragma mark-
#pragma mark-数组转换成序列
/**随机数转换成序列
 * @param  muArray 随机数数组,NSNumber对象
 * @return 序列化后的随机数组,NSNUmber对象
 */
+ (NSMutableArray *)transArray:(NSMutableArray *)muArray{
    
    NSMutableArray *trArr = [NSMutableArray arrayWithCapacity:1];
    
    for (NSInteger i = 0; i < [muArray count]; i++) {
        [trArr addObject:[NSNull null]];
    }
    
    NSInteger index = 0;
    NSInteger len = 0;
    NSNumber *num = [NSNumber numberWithInteger:LOCAL_RAND_MAX];
    NSNumber *numTmp;
    
    while (len < [muArray count]) {
        for (NSInteger i = 0; i < [muArray count]; i++) {
            numTmp = [muArray objectAtIndex:i];
            if ([trArr objectAtIndex:i] == [NSNull null] && numTmp.integerValue < num.integerValue) {
                num = [muArray objectAtIndex:i];
                index = i;
            }
        }
        [trArr replaceObjectAtIndex:index withObject:[NSNumber numberWithInteger:len]];
        len++;
        num = [NSNumber numberWithInteger:LOCAL_RAND_MAX];
    } 
//    for (NSInteger i = 0; i < [muArray count]; i++) {
//        NSNumber *x = [trArr objectAtIndex:i];
//        NSLog(@"随机数序列化=== %d", x.integerValue);
//    }
    return trArr;
}

+ (NSString*) DataToASCIIString:(NSData*)data{
	return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

+ (NSData*) ASCIIStringToData:(NSString*)str{
	return [str dataUsingEncoding:NSASCIIStringEncoding];
}

+ (NSString*) DataToUTF8String:(NSData*)data{
	return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSData*) UTF8StringToData:(NSString*)str{
	return [str dataUsingEncoding:NSUTF8StringEncoding];
}


#pragma mark-
#pragma mark- MD5校验
//add by liulei

/*!
 * 获取MD5校验码
 * @param C 字符串
 */
+ (NSString *)md5DigestCString:(const char *)str
{
    const char *cStr = str;//[str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ];
}

/*!
 * 获取MD5校验码
 * @param NSString字符串对象
 */
+ (NSString *)md5Digest:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ];
}

/*!
 * 获取本地化字符串
 * @param strEN 英文通用字符串
 * add by liulei 2012.05.19
 */
+ (NSString *)getLocalString:(NSString *)strEN
{
    NSString *strLocal = @"";
    if ([strEN isEqualToString:@"Sun"]) {
        strLocal = NSLocalizedString(@"Sun", nil);
    }
    if ([strEN isEqualToString:@"Mon"]) {
        strLocal = NSLocalizedString(@"Mon", nil);
    }
    if ([strEN isEqualToString:@"Tues"]) {
        strLocal = NSLocalizedString(@"Tues", nil);
    }
    if ([strEN isEqualToString:@"Wed"]) {
        strLocal = NSLocalizedString(@"Wed", nil);
    }                
    if ([strEN isEqualToString:@"Thurs"]) {
        strLocal = NSLocalizedString(@"Thurs", nil);
    }
    if ([strEN isEqualToString:@"Fri"]) {
        strLocal = NSLocalizedString(@"Fri", nil);
    }
    if ([strEN isEqualToString:@"Sat"]) {
        strLocal = NSLocalizedString(@"Sat", nil);
    }
    
    return strLocal;
}

@end



