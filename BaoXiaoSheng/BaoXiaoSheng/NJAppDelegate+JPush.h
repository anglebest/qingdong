//
//  NJAppDelegate+JPush.h
//  Beesgarden
//
//  Created by YR on 2018/4/24.
//  Copyright © 2018年 ningjukeji. All rights reserved.
//

#import "AppDelegate.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (JPush)<JPUSHRegisterDelegate>

- (void)setupJPush:(UIApplication *)application options:(nullable NSDictionary *)launchOptions;

@end

NS_ASSUME_NONNULL_END
