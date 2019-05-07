//
//  Utils.m
//  SuiYangApp
//
//  Created by admin on 2017/11/21.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "Utils.h"
#import <sys/utsname.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

static NSString *DESKey = nil;

static NSString *DESIv = nil;

@interface Utils()

@end

@implementation Utils

singleton_m(Utils);

static inline NSString * getDESKey() {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		DESKey = @"exm@";
	});
	return DESKey;
}


static inline NSString * getDESIv() {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		DESIv = @"taiv";
	});
	return DESIv;
}

+ (CGFloat)getTextHeightWithFontSize:(CGFloat)fonsize string:(NSString *)text width:(CGFloat)width
{
    CGSize titleSize = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fonsize]} context:nil].size;
    return titleSize.height;
}
- (CGFloat)calculateRowHeight:(NSString *)string fontSize:(NSInteger)fontSize width:(CGFloat)width{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT)/*计算高度要先指定宽度*/ options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.height;
    
}


+(CGFloat)getTextWidthWithFontSize:(CGFloat)size string:(NSString *)text height:(CGFloat)height{
    CGSize titleSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil].size;
  
    return titleSize.width;
}

+ (void)addClickEvent:(id)target action:(SEL)action owner:(UIView *)view{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    gesture.numberOfTouchesRequired = 1;
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:gesture];
}
#pragma mark 正则判断手机号码地址格式
+ (BOOL)isMobileNumber:(NSString *)mobileNum{
    
    NSString *pattern = @"^1[3578]\\d{9}$";
    //      NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)){
        return YES;
    }else{
        return NO;
    }
}

+(CGFloat)calculateCellHeight:(NSString *)text{
    CGSize size = [text boundingRectWithSize:CGSizeMake(kScreenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    return size.width + 20;
}
+(NSString *)getStringEmptyOrNot:(id)string{
    
    NSString *text;
    if (string == nil || [string isKindOfClass:[NSNull class]]) {
        text = @"";
    }else if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        text = @"";
    }else{
        text = [NSString stringWithFormat:@"%@",string];
    }
    return text;
}

/**
 设置字间距
 
 @param text 文本内容
 @param color 文本字体颜色
 @param space 字间距大小
 @return 返回文本
 */
+(NSAttributedString *)getAttributedText:(NSString *)text color:(UIColor *)color spacing:(CGFloat)space{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName : color, NSParagraphStyleAttributeName: paragraphStyle}];
    return string;
}


+ (BOOL)isLocationServiceOpen {
    if ([ CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        return NO;
    } else
        return YES;
}

#pragma mark -- 判读身份证
+(BOOL)checkIdentityCard:(NSString *)cardId{
    
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:cardId];
    
    return isMatch;
}


/**
 对tableview进行版本处理
 
 @param tableView 要处理的对象
 */
+(void)tableViewWithSystemVersion:(UITableView *)tableView{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
    }
}


+(NSArray *)getArrayFromString:(NSString *)string{
    if ([[Utils getStringEmptyOrNot:string] isEqualToString:@""]) {
        NSMutableArray *arrayNil = [[NSMutableArray alloc]init];
        return arrayNil;
    }else if ([string containsString:@","]){
        NSArray *array = [string componentsSeparatedByString:@","];
        NSMutableArray *images = [[NSMutableArray alloc] initWithArray:array];
        NSString *lastStr = [Utils getStringEmptyOrNot:[images objectAtIndex:images.count-1]];
        if ([lastStr isEqualToString:@""]) {
             [images removeLastObject];
        }
        return images;
    }
    return @[string];
}

#pragma mark 拨打电话
+ (void)callPhone:(NSString *)phonenumber{
    
    NSURL* callUrl=[NSURL URLWithString:[NSString   stringWithFormat:@"tel:%@",phonenumber]];
    NSLog(@"%@",callUrl);
    //check  Call Function available only in iphone
    if([[UIApplication sharedApplication] canOpenURL:callUrl])
    {
        [[UIApplication sharedApplication] openURL:callUrl];
    }
    else
    {
    }
}

//将NSString转换成十六进制的字符串则可使用如下方式:
NSString * convertDataToHexStr(NSData *data) {
	NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
	[data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
		unsigned char *dataBytes = (unsigned char*)bytes;
		for (NSInteger i = 0; i < byteRange.length; i++) {
			NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
			if ([hexStr length] == 2) {
				[string appendString:hexStr];
			} else {
				[string appendFormat:@"0%@", hexStr];
			}
		}
	}];
	return string;
}

//将十六进制的字符串转换成NSString则可使用如下方式:
//static inline NSData * convertHexStrToData(NSString *str){
//	if (!str || [str length] == 0)
//	{
//		return nil;
//	}
//	NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
//	NSRange range;
//	if ([str length] % 2 == 0)
//	{
//		range = NSMakeRange(0, 2);
//	} else {
//		range = NSMakeRange(0, 1);
//	}
//	for (NSInteger i = range.location; i < [str length]; i += 2) {
//		unsigned int anInt;
//		NSString *hexCharStr = [str substringWithRange:range];
//		NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
//		[scanner scanHexInt:&anInt];
//		NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
//		[hexData appendData:entity];
//		range.location += range.length;
//		range.length = 2;
//	}
//	return hexData;
//}

//Des加密
+ (NSString *)encryptUseDES:(NSString *)plainText {
	NSString *ciphertext = nil;
	NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
	NSUInteger dataLength = [textData length];
	unsigned char buffer[1024 * 15];
	memset(buffer, 0, sizeof(char));
	size_t numBytesEncrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
										  kCCOptionPKCS7Padding,
										  [(convertDataToHexStr([getDESKey() dataUsingEncoding:NSUTF8StringEncoding])) UTF8String], kCCKeySizeDES,
										  [convertDataToHexStr([getDESIv() dataUsingEncoding:NSUTF8StringEncoding]) UTF8String],
										  [textData bytes], dataLength,
										  buffer, 1024 * 15,
										  &numBytesEncrypted);
	if (cryptStatus == kCCSuccess) {
		NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
		ciphertext = [[NSString alloc]initWithData:[data base64EncodedDataWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn] encoding:NSUTF8StringEncoding];
	}
	return ciphertext;
}

//Des解密
+ (NSString *)decryptUseDES:(NSString *)cipherText {
	NSString *plaintext = nil;
	NSData *cipherdata = [[NSData alloc]initWithBase64EncodedString:cipherText
															options:NSDataBase64DecodingIgnoreUnknownCharacters];
	unsigned char buffer[1024 * 15];
	memset(buffer, 0, sizeof(char));
	size_t numBytesDecrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
										  kCCAlgorithmDES,
										  kCCOptionPKCS7Padding,
										  [(convertDataToHexStr([getDESKey() dataUsingEncoding:NSUTF8StringEncoding])) UTF8String],
										  kCCKeySizeDES,
										  [convertDataToHexStr([getDESIv() dataUsingEncoding:NSUTF8StringEncoding]) UTF8String],
										  [cipherdata bytes],
										  [cipherdata length],
										  buffer,
										  1024 * 15,
										  &numBytesDecrypted);
	if(cryptStatus == kCCSuccess) {
		NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
		plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
	}
	return plaintext;
}

+ (NSString *)carrierName {
	//获取本机运营商名称
	CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
	CTCarrier *carrier = [info subscriberCellularProvider];
	//当前手机所属运营商名称
	NSString *mobile;
	//先判断有没有SIM卡，如果没有则不获取本机运营商
	if (!carrier.isoCountryCode || [@"" isEqualToString:carrier.isoCountryCode]) {
		NSLog(@"没有SIM卡");
		mobile = @"";
	}else{
		mobile = [carrier carrierName];
	}
	return mobile;
}

+ (void)copyText:(NSString *)text {
	UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
	pasteboard.string = text;
    [self savePasteboardString:pasteboard.string];
}

+ (void)drawLinearGradient:(CGContextRef)context
					  path:(CGPathRef)path
				startColor:(CGColorRef)startColor
				  endColor:(CGColorRef)endColor
{
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGFloat locations[] = { 0.0, 1.0 };
	
	NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
	
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
	
	CGRect pathRect = CGPathGetBoundingBox(path);
	
	//具体方向可根据需求修改
	CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
	CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
	
	CGContextSaveGState(context);
	CGContextAddPath(context, path);
	CGContextClip(context);
	CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
	CGContextRestoreGState(context);
	
	CGGradientRelease(gradient);
	CGColorSpaceRelease(colorSpace);
}
+ (void)savePasteboardString:(NSString *)pasteboard
{
    [[NSUserDefaults standardUserDefaults] setObject:pasteboard forKey:@"PasteboardString"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
