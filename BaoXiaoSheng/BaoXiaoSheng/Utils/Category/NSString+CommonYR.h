//
//  NSString+Common.h
//  BrickMan
//
//  Created by duanyongrui on 16/7/21.
//  Copyright © 2016年 BrickMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (CommonYR)

/**
 是否正确的身份证

 @return 是否正确
 */
- (BOOL)judgeIdentityStringValid;

/**
 计算字符串占用尺寸

 @param font 字号
 @param size 可用尺寸
 @return 宽/高/尺寸
 */
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

/**
 字符串是否可用（为空）

 @param string 待判断字符串
 @return 是否可用
 */
+ (BOOL)isNULLString:(NSString *)string;

/**
 获取身份证号的省份

 @return 省份
 */
- (NSString *)getProvinceName;

/**
 MD5加密

 @return 加密后的字符串
 */
- (NSString *)md5Str;

/**
 emoji字符删除

 @return 删除emoji之后的字符串
 */
- (NSString *)disable_emoji;

/**
 是否可用的邮箱

 @return 是否可用
 */
- (BOOL)isValidEmail;

/**
 是否可用的手机号
 
 @return 是否可用
 */
- (BOOL)isValidPhone;

- (BOOL)isNumber;

/**
 根据路径获取文件或文件夹大小

 @return 大小，单位B
 */
- (long long)fileSize;

/**
 判断密码是否合法

 @param password 密码
 @return 是否合法
 */
+ (BOOL)isValidatePassword:(NSString *)password;

/**
 提取HTML中的img标签地址

 @param html HTML字符串
 @return 图片地址数组
 */
+ (NSArray *)filterImage:(NSString *)html;

/**
 数值字符串精度装换
 
 @return 保证精度的字符串
 */
- (NSString *)accuracyString;

/**
 是否是有效浮点数
 
 @return 匹配结果
 */
- (BOOL)isAmountNumber;

@end
