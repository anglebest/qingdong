//
//  NSString+timeDate.m
//  Beesgarden
//
//  Created by 张阳 on 2018/4/21.
//  Copyright © 2018年 ningjukeji. All rights reserved.
//

#import "NSString+timeDate.h"


#define kDateMinuteUnit (60.)
#define kDateHourUnit (kDateMinuteUnit * kDateMinuteUnit)
#define kDateDayUnit (24. * kDateHourUnit)

@implementation NSString (timeDate)

// 时间戳转日期
+ (NSString*)timeStampTransToDate:(NSTimeInterval)timesp formatter:(NSString *)formatter {
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:timesp/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];//设置本地时区
    [dateFormatter setDateFormat:formatter];
    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
    return currentDateStr;
}

// 聊天记录 时间戳转具体时间显示
+ (NSString *)stringWithTimeString:(double)timeStamp {
    
    //对比两个时间戳的时间差
    NSTimeInterval timeInterval = fabs(timeStamp - [[NSString getNowTimestamp] doubleValue]);

    // 获取当前时间距离昨天的秒数
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *currentDateString = [dateFormatter stringFromDate:[NSDate date]];
    NSArray * timeStrs = [currentDateString componentsSeparatedByString:@":"];
    double seconds = ([[timeStrs firstObject] doubleValue] * kDateHourUnit + [timeStrs[1] doubleValue]* kDateMinuteUnit + [[timeStrs lastObject] doubleValue]) * 1000;
    
    NSString * dataStr = nil;
    if (timeInterval <= seconds) {
        dataStr = [NSString stringWithFormat:@"今天 %@",[NSString timeStampTransToDate:timeStamp formatter:@"HH:mm"]];
    } else if (timeInterval <= seconds + kDateDayUnit) {
        dataStr = [NSString stringWithFormat:@"昨天 %@",[NSString timeStampTransToDate:timeStamp formatter:@"HH:mm"]];
    } else {
        dataStr = [NSString timeStampTransToDate:timeStamp formatter:@"yyyy-MM-dd HH:mm"];
    }
    
    return dataStr;
}

//当前时间转时间戳
+ (NSString*)getNowTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间
    
    
    
    NSLog(@"设备当前的时间:%@",[formatter stringFromDate:datenow]);
    
    //时间转时间戳的方法:

    NSString * timeSp = [NSString stringWithFormat:@"%ld",[[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue]*1000];
    
    return timeSp;
    
}

//获取当前时间字符串
+ (NSString*)currentTimeString:(NSInteger)type
{
    //1当天，2昨天，3当月，4上月，5 _7天前 ,6 _30天前
    if (type == 1) {
       return [NSString timeStampTransToDate:[[NSString getNowTimestamp] doubleValue] formatter:@"YYYY-MM-dd"];
    }else if (type == 2) {
       return [NSString timeStampTransToDate:[[NSString getNowTimestamp] doubleValue] - 86400*1000 formatter:@"YYYY-MM-dd"];
    }else if (type == 3) {
        
       return [NSString timeStampTransToDate:[[NSString getNowTimestamp] doubleValue] formatter:@"YYYY-MM"];
    }else if (type == 4) {
        NSInteger timeInt = [[NSString getNowTimestamp] integerValue];
        timeInt = timeInt - (double)86400*29*1000;
      return [NSString timeStampTransToDate:timeInt formatter:@"YYYY-MM"];
    }else if (type == 5) {
        
        return [NSString timeStampTransToDate:[[NSString getNowTimestamp] doubleValue] - 86400*6*1000 formatter:@"YYYY-MM-dd"];
    }else if (type == 6) {
        
        NSLog(@"%ld",[[NSString getNowTimestamp] doubleValue] - (long)86400*30*1000);
        NSInteger timeInt = [[NSString getNowTimestamp] integerValue];

        timeInt = timeInt - (double)86400*29*1000;

        return [NSString timeStampTransToDate:timeInt formatter:@"YYYY-MM-dd"];
    }
    
    
    return @"";
}

//判断是否全部为数字
+ (BOOL)deptNumInputShouldNumber:(NSString *)str
{
    if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}





@end
