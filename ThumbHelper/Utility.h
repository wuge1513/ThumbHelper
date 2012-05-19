//
//  UtilityClass.h
//  GpsService
//
//  Created by LiuLei on 12-2-27.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

/*!
 * 获取格式化系统时间
 * @param timeFormat 输出系统时间格式 yyyy-MM-dd HH:mm:ss.SSS 可以精确到毫秒
 */
+ (NSString *)getSystemTime:(NSString *)timeFormatStr;

/*!
 * 校验随机数是否已存在
 * @param muArray数组内存放NSNumber数据
 * @param num 生成的随机数
 */
+ (BOOL)checkNum:(NSMutableArray *)arr randNum:(NSInteger)num;
+ (NSMutableArray *)getRandArray:(NSInteger)count;


+ (NSString*)DataToASCIIString:(NSData*)data;
+ (NSData*)ASCIIStringToData:(NSString*)str;

+ (NSString*)DataToUTF8String:(NSData*)data;
+ (NSData*)UTF8StringToData:(NSString*)str;

/*!
 * 获取MD5校验码
 * @param C 字符串
 */
+ (NSString *)md5DigestCString:(const char *)str;

/*!
 * 获取MD5校验码
 * @param NSString字符串对象
 */
+ (NSString *)md5Digest:(NSString *)str;

/*!
 * 获取本地化字符串
 * @param strEN 英文通用字符串
 * add by liulei 2012.05.19
 */
+ (NSString *)getLocalString:(NSString *)strEN;
@end
