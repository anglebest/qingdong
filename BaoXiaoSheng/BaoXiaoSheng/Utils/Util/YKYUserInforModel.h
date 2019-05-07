//
//  YKYUserInforModel.h
//  ShengYa
//
//  Created by 王开政 on 2019/4/12.
//  Copyright © 2019年 Wkz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKYUserInforModel : NSObject
/**
 是否显示拍砖
 */
@property (nonatomic, strong) NSNumber *paizhuan;

/**
 是否显示签到
 */
@property (nonatomic, strong) NSNumber *signin;

/**
 是否显示融云功能,0不显示， 1显示
 */
@property (nonatomic, strong) NSNumber *rongim;

@property (nonatomic,copy) NSString* city;//城市

@property (nonatomic,copy) NSString* province;//省份

@property (nonatomic,copy) NSString* avatar;//头像

@property (nonatomic,copy) NSString* headimgurl;//头像

@property (nonatomic,copy) NSString* nickname;//昵称

@property (nonatomic,assign) NSInteger sex;//性别1:男 0是女

@property (nonatomic,copy) NSString* unionid;//关联id

@property (nonatomic,copy) NSString* openid;//openId

@property (nonatomic,copy) NSString* country;//国家

@property (nonatomic,copy) NSString *role;//角色名称

@property (nonatomic,copy) NSString *phone;//手机号

/**
 未知0
 管理员1
 
 
 店主2
 总监3
 消费者/会员4
 运营商5
 
 
 商家6
 代理7
 */
@property (nonatomic,copy) NSString* rolecode;//角色

@property (nonatomic,strong) NSString* code; // 邀请码

@property (nonatomic, strong) NSNumber *myfans; // 粉丝数量

@property (nonatomic, strong) NSNumber *buyermemberscount; // 买家数量

@property (nonatomic,copy) NSString* kefu;//客服号

@property (nonatomic, strong) NSNumber *directgroupmemberscount; // 直属店长数量

@property (nonatomic, strong) NSNumber *groupmemberscount; // 所有店长数量

@property (nonatomic,strong) NSString* uid;//用户id

//上级邀请人信息

@property (nonatomic,copy) NSString* pavatar;//邀请人头像

@property (nonatomic,copy) NSString* pnickname;//邀请人昵称

@property (nonatomic,strong) NSDictionary * rolenames;//角色映射
/*
 rolenames =         {
 BUYER = "会员";
 CONSOLE = "运营商";
 MANAGER = "总监";
 SHOPKEEPER = "店主";
 };
 */

//1.1.8

/**
 系统模式：老模式和新模式，共存
 */
@property (nonatomic, copy) NSString * systemModelType;

// 融云appkey
@property (nonatomic, copy) NSString *rong_appkey;

// 融云token
@property (nonatomic, copy) NSString *token;

/**
 可提现金额
 */
@property (nonatomic, copy) NSString *balance;

/**
 累积提现金额
 */
@property (nonatomic, copy) NSString *withdrawSuccAmount;

/**
 邀请好友图片
 */
@property (nonatomic, copy) NSString *inviteImageUrl;
@end
