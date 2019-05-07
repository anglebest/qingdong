//
//  Utils.h
//  SuiYangApp
//
//  Created by admin on 2017/11/21.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Singleton.h"
@interface Utils : NSObject

singleton_h(Utils);

+ (CGFloat)getTextHeightWithFontSize:(CGFloat)fonsize string:(NSString *)text width:(CGFloat)width;
+(CGFloat)getTextWidthWithFontSize:(CGFloat)size string:(NSString *)text height:(CGFloat)height;
+ (void) addClickEvent:(id)target action:(SEL)action owner:(UIView *)view;//添加单击手势
+ (BOOL)isMobileNumber:(NSString *)mobileNum;//是否是电话号码

//设置动态行高
+(CGFloat)calculateCellHeight:(NSString *)text;
+(NSString *)getStringEmptyOrNot:(NSString *)string; //判断字符串是否为空

//判断是否允许定位
+ (BOOL)isLocationServiceOpen;
/**
 设置字间距

 @param text 文本内容
 @param color 文本字体颜色
 @param space 字间距大小
 @return 返回文本
 */
+(NSAttributedString *)getAttributedText:(NSString *)text color:(UIColor *)color spacing:(CGFloat)space;

+(BOOL)checkIdentityCard:(NSString *)cardId; //判断身份证格式


/**
 对tableview进行版本处理

 @param tableView 要处理的对象
 */
+(void)tableViewWithSystemVersion:(UITableView *)tableView;



/**
 从字符串中截取出图片数组

 @param string 字符串
 @return 图片数组
 */
+(NSArray *)getArrayFromString:(NSString *)string;

+ (void)callPhone:(NSString *)phonenumber;

//Des加密
+ (NSString *)encryptUseDES:(NSString *)plainText;

//Des解密
+ (NSString *)decryptUseDES:(NSString *)cipherText;

/**
 判断设备

 @return 设备名称
 */
+ (NSString *)carrierName;

/**
 复制文本到粘贴板
 */
+ (void)copyText:(NSString *)text;

/**
 绘制渐变色
 
 @param context 上下文
 @param path 路径
 @param startColor 开始颜色
 @param endColor 结束颜色
 */
+ (void)drawLinearGradient:(CGContextRef)context
					  path:(CGPathRef)path
				startColor:(CGColorRef)startColor
				  endColor:(CGColorRef)endColor;

@end
