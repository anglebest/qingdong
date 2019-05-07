//
//  YKYUserInfor.m
//  ShengYa
//
//  Created by 王开政 on 2019/4/12.
//  Copyright © 2019年 Wkz. All rights reserved.
//

#import "YKYUserInfor.h"
#import "YKYUserInforModel.h"
#import <YYKit/NSNumber+YYAdd.h>
#import <Lockbox/Lockbox.h>

#import <NSObject+YYModel.h>

static NSString *keywordsKey = @"searchAnswerKeywords%ld";

static NSString *UserPhoneNumberKey = @"userPhone";

static NSString *UserTokenKey = @"token";

static NSString *UserRongIMTokenKey = @"ryToken";

static NSString *UserInfoKey = @"userInfo";

static NSString *UserStateKey = @"lState";
@interface YKYUserInfor () {
    NSString *_phoneNumber;
    NSString *_token;
    YKYUserInforModel *_userInfo;
    NSString *_ryToken;
}

@end
@implementation YKYUserInfor
singleton_m();


#pragma mark - 存储敏感数据到钥匙串

- (void)setPhoneNumber:(NSString * _Nullable)phoneNumber {
    _phoneNumber = phoneNumber;
    [Lockbox archiveObject:phoneNumber forKey:UserPhoneNumberKey accessibility:kSecAttrAccessibleAlwaysThisDeviceOnly];
}

- (NSString * _Nullable)phoneNumber {
    if (!_phoneNumber) {
        _phoneNumber = [Lockbox unarchiveObjectForKey:UserPhoneNumberKey];
    }
    return _phoneNumber;
}

- (void)setToken:(NSString * _Nullable)token {
    _token = token;
    [Lockbox archiveObject:token forKey:UserTokenKey accessibility:kSecAttrAccessibleAlwaysThisDeviceOnly];
}

- (NSString * _Nullable)token {
    if (!_token) {
        _token = [Lockbox unarchiveObjectForKey:UserTokenKey];
    }
    return _token;
}



#pragma mark - 用户普通信息存储到属性目录

- (void)setUserInfo:(YKYUserInforModel * _Nullable)userInfo {
    _userInfo = userInfo;
    //    [[NSUserDefaults standardUserDefaults] setValue:[userInfo modelToJSONObject] forKey:UserInfoKey];
    //    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [Lockbox archiveObject:[userInfo modelToJSONObject] forKey:UserInfoKey accessibility:kSecAttrAccessibleAlwaysThisDeviceOnly];
}


- (YKYUserInforModel * _Nullable)userInfo {
    if (!_userInfo) {
        //        _userInfo = [NJUserInfo modelWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:UserInfoKey]];
        _userInfo = [YKYUserInforModel modelWithDictionary:[Lockbox unarchiveObjectForKey:UserInfoKey]];
    }
    return _userInfo;
}

- (void)clearUserInfo {
    [YKYUserInfor shared].token = nil;
    //    [NJUserInfoManager shared].ryToken = nil;
    [YKYUserInfor shared].userInfo = nil;
    [YKYUserInfor shared].phoneNumber = nil;
    
}
- (void)savePasteboardString:(NSString *)pasteboard
{
    [[NSUserDefaults standardUserDefaults] setObject:pasteboard forKey:@"PasteboardString"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)pasteboardString
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"PasteboardString"];
}


/**
 本地存储搜索关键字
 
 @param keyword 关键字
 */
- (void)saveSearchKeyword:(NSString *)keyword {
    
    NSArray *keywords = [[NSUserDefaults standardUserDefaults] objectForKey:self.keywordUniqueKey];
    if (keywords) {
        NSMutableArray *mutableKeywords = [NSMutableArray arrayWithArray:keywords];
        if ([mutableKeywords containsObject:keyword]) {
            [mutableKeywords removeObject:keyword];
        }
        [mutableKeywords insertObject:keyword atIndex:0];
        [[NSUserDefaults standardUserDefaults] setObject:mutableKeywords forKey:self.keywordUniqueKey];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:@[keyword] forKey:self.keywordUniqueKey];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 获取本地存储的搜索关键字
 
 @return 所有关键字集合
 */
- (NSArray<NSString *> * _Nullable)searchKeywords {
    return (NSArray *)[[NSUserDefaults standardUserDefaults] objectForKey:self.keywordUniqueKey];
}

/**
 清除本地搜索关键字
 */
- (void)clearLocalKeywords {
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:self.keywordUniqueKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)keywordUniqueKey {
//    if (self.loginState != UserOnlineByLogin) {
//        return [NSBundle mainBundle].bundleIdentifier;
//    }
    return [NSString stringWithFormat:@"%@%ld",keywordsKey,(long)self.userInfo.uid.integerValue];
}


@end
