//
//  NSString+Common.m
//  BrickMan
//
//  Created by duanyongrui on 16/7/21.
//  Copyright © 2016年 BrickMan. All rights reserved.
//

#import "NSString+CommonYR.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (CommonYR)

- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    return [self getSizeWithFont:font constrainedToSize:size].width;
}

- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    return [self getSizeWithFont:font constrainedToSize:size].height;
}

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    resultSize = [self boundingRectWithSize:size
                                    options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                 attributes:@{NSFontAttributeName: font}
                                    context:nil].size;
    resultSize = CGSizeMake(MIN(size.width, ceilf(resultSize.width)), MIN(size.height, ceilf(resultSize.height)));
    return resultSize;
}

+ (BOOL)isNULLString:(NSString *)string {
	return string == nil ||
	[string isKindOfClass:[NSNull class]] || ([string isKindOfClass:[NSString class]] &&
	([@"" isEqualToString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)) ||
	[@"null"  isEqual: string] ||
	[@"<null>"  isEqual: string];
}

- (BOOL)isValidEmail {
	BOOL sticterFilter = YES;
	NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
	NSString *emailRegex = sticterFilter ? stricterFilterString : laxString;
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	return [emailTest evaluateWithObject:self];
}

- (BOOL)isNumber {
	NSString * number = @"^\\d+";
	NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", number];
	return [regextestmobile evaluateWithObject:self];
}

- (BOOL)isValidPhone {
	/**
	 * 手机号码
	 * 移动：134,135,136,137,138,139,150,151,152,157,158,159,182,187,188
	 * 联通：130,131,132,155,156,176, 133,185,186
	 * 电信：133,153,180,189
	 */
//	NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
	NSString * MOBILE = @"^1\\d{10}$";
	NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
	return [regextestmobile evaluateWithObject:self];
}

- (NSString *)md5Str {
	const char *cStr = [self UTF8String];
	unsigned char digest[CC_MD5_DIGEST_LENGTH];
	CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
	NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
	for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
		[result appendFormat:@"%02x",digest[i]];
	}
	return result;
}

//- (NSString *)md5Str {
//    const char *cStr = [self UTF8String];
//    unsigned char result[CC_MD5_DIGEST_LENGTH];
//    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
//
//    return [NSString stringWithFormat:
//            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
//            result[0], result[1], result[2], result[3],
//            result[4], result[5], result[6], result[7],
//            result[8], result[9], result[10], result[11],
//            result[12], result[13], result[14], result[15]
//            ];
//}

//过滤表情
- (NSString *)disable_emoji
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, [self length])
                                                          withTemplate:@""];
    return modifiedString;
}

- (BOOL)judgeIdentityStringValid {
    //判断位数
    if (self.length != 15 && self.length != 18) {
        return NO;
    }
    NSString *carid = self;
    long lSumQT = 0 ;
    //加权因子
    int R[] = {7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2};
    //校验码
    unsigned char sChecker[11] = {'1','0','X','9','8','7','6','5','4','3','2'};
    //将15位身份证号转换为18位
    NSMutableString *mString = [NSMutableString stringWithString:self];
    if (self.length == 15) {
        [mString insertString:@"19" atIndex:6];
        long p =0;
        //        const char *pid = [mString UTF8String];
        for (int i =0; i<17; i++)
        {
            NSString * s = [mString substringWithRange:NSMakeRange(i, 1)];
            p += [s intValue] * R[i];
            //            p += (long)(pid-48) * R;//
            
        }
        int o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    NSLog(@"carid:%@",carid);
    //判断地区码
    NSString *sProvince = [carid substringToIndex:2];
    NSLog(@"sProvince::%@",sProvince);
    if (![self isAreaCode:sProvince]) {
        return NO ;
    }
    //判断年月日是否有效
    //年份
    int strYear = [[self getStringWithRange:carid Value1:6 Value2:4] intValue];
    //月份
    int strMonth = [[self getStringWithRange:carid Value1:10 Value2:2] intValue];
    //日
    int strDay = [[self getStringWithRange:carid Value1:12 Value2:2] intValue];
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    if (date == nil) {
        return NO;
    }
    [carid uppercaseString];
    const char *PaperId = [carid UTF8String];
    //检验长度
    if (18!=strlen(PaperId)) {
        return NO;
    }
    //校验数字
    NSString * lst = [carid substringFromIndex:carid.length-1];
    char di = [carid characterAtIndex:carid.length-1];
    
    if (!isdigit(di)) {
        if ([lst isEqualToString:@"X"]) {
        }else{
            return NO;
        }
    }
    //验证最末的校验码
    lSumQT = 0;
    for (int i = 0; i<17; i++){
        NSString * s = [carid substringWithRange:NSMakeRange(i, 1)];
        lSumQT += [s intValue] * R[i];
    }
    if (sChecker[lSumQT%11] != PaperId[17]) {
        return NO;
    }
    return YES;
}


- (NSArray *)provinceArr {
    NSArray *pArr = @[
                      
                      @11,//北京市|110000，
                      
                      @12,//天津市|120000，
                      
                      @13,//河北省|130000，
                      
                      @14,//山西省|140000，
                      
                      @15,//内蒙古自治区|150000，
                      
                      @21,//辽宁省|210000，
                      
                      @22,//吉林省|220000，
                      
                      @23,//黑龙江省|230000，
                      
                      @31,//上海市|310000，
                      
                      @32,//江苏省|320000，
                      
                      @33,//浙江省|330000，
                      
                      @34,//安徽省|340000，
                      
                      @35,//福建省|350000，
                      
                      @36,//江西省|360000，
                      
                      @37,//山东省|370000，
                      
                      @41,//河南省|410000，
                      
                      @42,//湖北省|420000，
                      
                      @43,//湖南省|430000，
                      
                      @44,//广东省|440000，
                      
                      @45,//广西壮族自治区|450000，
                      
                      @46,//海南省|460000，
                      
                      @50,//重庆市|500000，
                      
                      @51,//四川省|510000，
                      
                      @52,//贵州省|520000，
                      
                      @53,//云南省|530000，
                      
                      @54,//西藏自治区|540000，
                      
                      @61,//陕西省|610000，
                      
                      @62,//甘肃省|620000，
                      
                      @63,//青海省|630000，
                      
                      @64,//宁夏回族自治区|640000，
                      
                      @65,//新疆维吾尔自治区|650000，
                      
                      @71,//台湾省（886)|710000,
                      
                      @81,//香港特别行政区（852)|810000，
                      
                      @82,//澳门特别行政区（853)|820000
                      
                      @91,//国外
                      ];
    return pArr;
}

- (NSString *)getProvinceName {
	NSString *name = @"";
	name = @{
			 @"11": @"北京市",
			 @"12": @"天津市",
			 @"13": @"河北省",
			 @"14": @"陕西省",
			 @"15": @"内蒙古自治区",
			 @"21": @"辽宁省",
			 @"22": @"吉林省",
			 @"23": @"黑龙江省",
			 @"31": @"上海市",
			 @"32": @"江苏省",
			 @"33": @"浙江省",
			 @"34": @"安徽省",
			 @"35": @"福建省",
			 @"36": @"江西省",
			 @"37": @"山东省",
			 @"41": @"河南省",
			 @"42": @"湖北省",
			 @"43": @"湖南省",
			 @"44": @"广东省",
			 @"45": @"广西壮族自治区",
			 @"46": @"海南省",
			 @"50": @"重庆市",
			 @"51": @"四川省",
			 @"52": @"贵州省",
			 @"53": @"云南省",
			 @"54": @"西藏自治区",
			 @"61": @"陕西省",
			 @"62": @"甘肃省",
			 @"63": @"青海省",
			 @"64": @"宁夏回族自治区",
			 @"65": @"新疆维吾尔自治区",
			 @"71": @"台湾省",
			 @"81": @"香港特别行政区",
			 @"82": @"澳门特别行政区",
			 @"91": @"国外"
			 }[self];
	return name;
}

- (BOOL)isAreaCode:(NSString *)province {
    //在provinceArr中找
    NSArray * arr = [self provinceArr];
    int a = 0;
    for (NSNumber * pr in arr) {
        NSString *prStr = [NSString stringWithFormat:@"%@",pr];
        if ([prStr isEqualToString:province]) {
            a ++;
        }
    }
    if (a == 0) {
        return NO;
    } else {
        return YES;
    }
}

- (NSString *)getStringWithRange:(NSString *)str Value1:(int)v1 Value2:(int)v2 {
    NSString * sub = [str substringWithRange:NSMakeRange(v1, v2)];
    return sub;
}

- (long long)fileSize {
	NSFileManager *mgr = [NSFileManager defaultManager];
	BOOL isDirectory = NO;
	BOOL exists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
	if(!exists) return 0;
	
	if(isDirectory) {
		NSInteger size = 0;
//		NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
//		for(NSString *subpath in enumerator) {
//			NSString *fullSubPath = [self stringByAppendingPathComponent:subpath];
//			size += [fullSubPath fileSize];
//		}
		NSArray<NSString *> *subPaths = [mgr subpathsAtPath:self];
		for (NSString *subpath in subPaths) {
			NSString *fullSubPath = [self stringByAppendingPathComponent:subpath];
			size += [fullSubPath fileSize];
		}
		return size;
	}else{
		return (signed long long)[mgr attributesOfItemAtPath:self error:nil].fileSize;
	}
}

+ (BOOL)isValidatePassword:(NSString *)password {
	// FIXME: /w不管用
	NSString *regexString = @"^[A-z0-9]{6,20}$";
	NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
	return [pred evaluateWithObject:password];
}

+ (NSArray *)filterImage:(NSString *)html
{
	NSMutableArray *resultArray = [NSMutableArray array];
	NSString *regfail = @"<(img|IMG)(.*?)(/>|></img>|>)";
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regfail options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
	NSArray *result = [regex matchesInString:html options:NSMatchingReportCompletion range:NSMakeRange(0, html.length)];
	
	for (NSTextCheckingResult *item in result) {
		NSString *imgHtml = [html substringWithRange:[item rangeAtIndex:0]];
		
		NSArray *tmpArray = nil;
		if ([imgHtml rangeOfString:@"src=\""].location != NSNotFound) {
			tmpArray = [imgHtml componentsSeparatedByString:@"src=\""];
			if (tmpArray.count >= 2) {
				NSString *src = tmpArray[1];
				
				NSUInteger loc = [src rangeOfString:@"\""].location;
				if (loc != NSNotFound) {
					src = [src substringToIndex:loc];
					[resultArray addObject:src];
				}
			}
		} else if ([imgHtml rangeOfString:@"src='"].location != NSNotFound) {
			tmpArray = [imgHtml componentsSeparatedByString:@"src='"];
			if (tmpArray.count >= 2) {
				NSString *src = tmpArray[1];
				
				NSUInteger loc = [src rangeOfString:@"'"].location;
				if (loc != NSNotFound) {
					src = [src substringToIndex:loc];
					[resultArray addObject:src];
				}
			}
		} else if ([imgHtml rangeOfString:@"src="].location != NSNotFound) {
			tmpArray = [imgHtml componentsSeparatedByString:@"src="];
			if (tmpArray.count >= 2) {
				NSString *src = tmpArray[1];
				
				NSUInteger loc = [src rangeOfString:@"\""].location;
				if (loc != NSNotFound) {
					src = [src substringToIndex:loc];
					[resultArray addObject:src];
				}
			}
		}
	}
	return resultArray;
}

- (NSString *)accuracyString {
	// 解决精度丢失问题
	double conversionValue = [self doubleValue];
	NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
	NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
	return [NSString stringWithFormat:@"%@", decNumber];
}

- (BOOL)isAmountNumber {
	NSString * number = @"^\\d+.{0,1}\\d+";
	NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", number];
	return [regextestmobile evaluateWithObject:self];
}

@end
