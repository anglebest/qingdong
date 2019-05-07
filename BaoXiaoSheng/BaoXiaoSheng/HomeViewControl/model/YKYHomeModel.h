//
//  YKYHomeModel.h
//  ShengYa
//
//  Created by 王开政 on 2019/4/11.
//  Copyright © 2019年 Wkz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKYHomeModel : NSObject


//商品ID
@property(nonatomic, copy) NSString *itemId;

//商品标题

@property(nonatomic, copy) NSString *itemTitle;

//商品短标题

@property(nonatomic, copy) NSString *itemShortTitle;


//商品原价

@property(nonatomic, copy) NSString *itemPrice;

//商品主图

@property(nonatomic, copy) NSString *itempictUrl;

//商品小图列表

@property(nonatomic, copy) NSString *itemSmallImages;

//商品平台 用数字确定 C淘宝B天猫J京东P拼多多

@property(nonatomic, copy) NSString *itemType;

//商品销量

@property(nonatomic, copy) NSString *itemSale;

//是否包邮

@property(nonatomic, assign) BOOL freeShipment;

//优惠券链接

@property(nonatomic, copy) NSString *couponUrl;

//优惠券价格

@property(nonatomic, copy) NSString *couponMoney;

//优惠券开始时间

@property(nonatomic, copy) NSString *couponStartTime;

//优惠券开始时间

@property(nonatomic, copy) NSString *couponEndTime;

//优惠券筛选-是否有优惠券。true表示该商品有优惠券，false表示没有

@property(nonatomic, assign) BOOL  hasCoupon;

//店铺ID

@property(nonatomic, copy) NSString *shopId;

//店铺名称

@property(nonatomic, copy) NSString *shopName;

//店铺图片

@property(nonatomic, copy) NSString *shopPicUrl;

//返利金额

@property(nonatomic, copy) NSString *fanliMoney;

//返后价

@property(nonatomic, copy) NSString *fanlihoMoney;
@end
