//
//  YKYUserInfor.h
//  ShengYa
//
//  Created by 王开政 on 2019/4/12.
//  Copyright © 2019年 Wkz. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YKYUserInforModel;
/**
 用户在线状态
 - UserOffLineByUnknown: 未知离线状态，默认
 - UserOnlineByLogin: 登录在线
 - UserOffLineByLogout: 登出离线
 - UserOffLineByOther: 被挤下线
 */
typedef NS_ENUM(NSInteger, UserState){
    UserOffLineByUnknown,
    UserOnlineByLogin,
    UserOffLineByLogout,
    UserOffLineByOther
};
@interface YKYUserInfor : NSObject
singleton_h();
/**
 保密手机号
 */
@property (nonatomic, copy, nullable) NSString *phoneNumber;

/**
 登录token
 */
@property (nonatomic, copy, nullable) NSString *token;

/**
 用户信息
 */
@property (nonatomic, copy, nullable) YKYUserInforModel *userInfo;

/**
 是否已登录
 
 @return 登录状态
 */
- (UserState)loginState;

/**
 设置登录状态
 
 @param state 登录状态
 */
- (void)setLoginState:(UserState)state;

/**
 本地存储搜索关键字
 
 @param keyword 关键字
 */
- (void)saveSearchKeyword:(NSString *)keyword;

/**
 获取本地存储的搜索关键字
 
 @return 所有关键字集合
 */
- (NSArray<NSString *> * _Nullable)searchKeywords;

/**
 清除本地搜索关键字
 */
- (void)clearLocalKeywords;


/**
 清除用户信息
 */
- (void)clearUserInfo;


/**
 粘贴板
 
 @param pasteboard 保存app内粘贴的最后一次文本，用来对比是不是应用内复制，不弹框
 */
- (void)savePasteboardString:(NSString *)pasteboard;

- (NSString *)pasteboardString;

@end
