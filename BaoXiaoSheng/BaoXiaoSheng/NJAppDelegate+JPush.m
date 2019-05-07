//
//  NJAppDelegate+JPush.m
//  Beesgarden
//
//  Created by YR on 2018/4/24.
//  Copyright © 2018年 ningjukeji. All rights reserved.
//

#import "NJAppDelegate+JPush.h"

//static NSString *jPushAppkey = @"76a37da50897ae7ce9dc1b1a";
//
//static NSString *jPushAppSecret = @"f586bfb1513206d36581fa5c";

static NSString *jPushAppkey1 = @"23bc4ec023f0d04fffda994e";

static NSString *jPushAppSecret1 = @"a825e9327614344da1823042";

@implementation AppDelegate (JPush)

- (void)setupJPush:(UIApplication *)application options:(nullable NSDictionary *)launchOptions {
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    
    // 可以添加自定义categories
    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc]init];
    category.identifier = @"lanyincao_alert";
    NSSet<UIUserNotificationCategory *> *categories = [NSSet setWithObject:category];
    entity.categories = categories;

    
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    if(YES){
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
    
    setup(launchOptions);
    NSDictionary *userInfo = [launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        [self pushReomteNotificationController:userInfo];
    }
}

static inline void setup(NSDictionary *launchOptions) {
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    BOOL isProduction = YES;
#ifdef DEBUG
    isProduction = NO;
#endif
    [JPUSHService setupWithOption:launchOptions
                           appKey:jPushAppkey1
                          channel:@"AppStore"
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    [JPUSHService resetBadge];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
       
        if(resCode == 0){
            [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:@"JPushRegistrationID"];
        } else {
           
        }
    }];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
    NSString *token =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
    
    
//    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability"

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"getMoney" ofType:@"mp3"];
//
//    SystemSoundID soundID;
//
//    NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
//
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
//
//    AudioServicesPlaySystemSound(soundID);
    
    NSDictionary * userInfo = notification.request.content.userInfo;
   
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        [self pushReomteNotificationController:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

#pragma clang diagnostic pop

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // Required, iOS 7 Support
    
    [self pushReomteNotificationController:userInfo];
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

@end
