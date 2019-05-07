//
//  NSString+timeDate.h
//  Beesgarden
//
//  Created by 张阳 on 2018/4/21.
//  Copyright © 2018年 ningjukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (timeDate)
// 时间戳转日期
+ (NSString*)timeStampTransToDate:(NSTimeInterval)timesp formatter:(NSString *)formatter;

// 聊天记录 时间戳转具体时间显示
+ (NSString *)stringWithTimeString:(double)timeStamp;
//当前时间转时间戳
+ (NSString*)getNowTimestamp;

//转换时间
+ (NSString*)currentTimeString:(NSInteger)type;

//判断是否全部为数字
+ (BOOL)deptNumInputShouldNumber:(NSString *)str;

//角色转换（未使用）

+ (NSString*)switchRoleName:(NSString *)roleNames;

/**
 平台类型 安全图片

 @param shop 平台类型[天猫:1 淘宝:2 京东:3 蘑菇街:4 拼多多:5 苏宁:6]
 @return 图片字符串
 */
+ (NSString*)PlatformTypeShop:(NSInteger)shop;

/**
 是否具有分享功能键

 @return YES:可以分享 NO:不可以分享
 */
+ (BOOL)isHaveShareFunction;

/**
 是否安装微信客服端
 
 @return YES:有 NO:没有
 */
+ (BOOL)isHaveWeixinShareFunction;
@end
