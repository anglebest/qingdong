//
//  AppDelegate.m
//  ShengYa
//
//  Created by 王开政 on 2019/4/11.
//  Copyright © 2019年 王开政. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+YKYtabBar.h"

#import "GeeBaseCoverViewController.h"
#import "YKYBaseNavigationControler.h"
#import "YKYBaseTabBarViewController.h"
#import "SDUpdate.h"

#import "NJAppDelegate+JPush.h"

#import "WXApi.h"

#import "YKYGoodsListViewController.h"

//#import "GeeHomeSearchViewController.h"


@interface AppDelegate ()<WXApiDelegate>
@property (nonatomic,assign) BOOL isFirstOpenApp;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setupWindow];
    
    
    // 设置极光
    [self setupJPush:application options:launchOptions];
    
    
    [WXApi registerApp:@"wxf449a8a6cb17cb00" enableMTA:YES];
    
    return YES;
}

- (void)onResp:(id)resp{
    
    if([resp isKindOfClass:[SendAuthResp class]]){//判断是否为授权登录类
        
        SendAuthResp *req = (SendAuthResp *)resp;
        NSLog(@"r%@",req.code);
        if (req.errCode== 0)
        {
            NSString *code = req.code;
            NSLog(@"code %@",code);
            NSDictionary *dic = @{@"code":code};
            NSLog(@"code %@",code);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wechatDidLoginNotification" object:self userInfo:dic];
            
        }
    }
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    [WXApi handleOpenURL: url
                delegate: self];
    
    return YES;
}
- (void)setupWindow {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    kAppDelegate.tabBarController.selectedIndex = 0;
    kAppDelegate.window.rootViewController = kAppDelegate.tabBarController;

    if ([self isFirstLoginApp] == YES) {
        self.isFirstOpenApp = YES;
//        [self goToIntroductionViewController];
        
    }else {
        //启动广告
//        [self setupAdveriseView];
    }
    
    
    
}
/**
判断是否第一次启动
*/
- (BOOL)isFirstLoginApp {
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)firstObject];
    NSString *filePa = [doc stringByAppendingPathComponent:@"first.txt"];//存入的文件路径
    NSMutableArray *firstArray = [[NSMutableArray alloc] initWithContentsOfFile:filePa];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSArray *array = @[app_Version];
    if (![firstArray[0] isEqualToString:app_Version]) {
        [array writeToFile:filePa atomically:YES];
        
        return YES;
    }else {
        return NO;
    }
}
- (YKYBaseTabBarViewController *)tabBarController {
    if (!_tabBarController) {
//        [CYLPlusButtonSubclass registerPlusButton];
        
        
        _tabBarController =[YKYBaseTabBarViewController tabBarControllerWithViewControllers:self.viewControllers tabBarItemsAttributes:self.tabBarItemsAttributesForController imageInsets:UIEdgeInsetsZero titlePositionAdjustment:UIOffsetZero];
//        _tabBarController = (YKYBaseTabBarViewController *)[YKYBaseTabBarViewController tabBarControllerWithViewControllers:self.viewControllers tabBarItemsAttributes:self.tabBarItemsAttributesForController imageInsets:UIEdgeInsetsZero titlePositionAdjustment:UIOffsetZero context:NSStringFromClass([CYLTabBarController class])];
        
        [self customizeTabBarAppearance:_tabBarController];
    }
    _tabBarController.tabBarItemsAttributes = self.tabBarItemsAttributesForController;
    return _tabBarController;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
    
    
//    [self inviteCodePopView];
    UIPasteboard * pasteboard = [UIPasteboard generalPasteboard];
    if (![NSString isNULLString:pasteboard.string]) {
        [self inviteCodePopView:pasteboard.string];
    }
}
-(void)inviteCodePopView:(NSString *)string{
    
    
    YKYBaseTabBarViewController *tabController = (YKYBaseTabBarViewController *)self.window.rootViewController;
     YKYBaseNavigationControler*navController = (YKYBaseNavigationControler *)tabController.selectedViewController;
    
    GeeBaseCoverViewController * coverVC = [[GeeBaseCoverViewController alloc]init];
    
    coverVC.cString = string;
    
    coverVC.coverButtonType = ^(CoverViewButtonType type,NSString * string) {
        
        
        
        
    
//        GeeHomeSearchResultViewController *controller = [[GeeHomeSearchResultViewController alloc]init];
        if (type == CoverViewButtonTypemakeSuperSearchTB) {
            
//            controller.shop = @"2";
        }else if(type == CoverViewButtonTypemakeSuperSearchJD){
//            controller.shop = @"3";
            
        }else if(type == CoverViewButtonTypemakeSuperSearchMGJ){
//            controller.shop = @"5";
            
        }
        YKYGoodsListViewController *resultController = [[YKYGoodsListViewController alloc]init];
        resultController.tip = string;
        [navController pushViewController:resultController animated:YES];
        [Utils copyText:@""];
        
    };
    coverVC.GlobalCoverVCType = GlobalCoverVCTypeSuperSearch;
    coverVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    coverVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [navController presentViewController:coverVC animated:YES completion:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
/**
 push远程推送界面
 
 @param remoteInfo 远程推送信息
 */
- (void)pushReomteNotificationController:(NSDictionary *)remoteInfo {
    // 解析推送信息
    if (!remoteInfo) {
        return;
    }
    NSLog(@"%@", remoteInfo);
    NSError *error = nil;
    if ([remoteInfo valueForKey:@"data"]) {
        // 极光推送
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:[[remoteInfo valueForKey:@"data"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        
    }
}
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
@end
