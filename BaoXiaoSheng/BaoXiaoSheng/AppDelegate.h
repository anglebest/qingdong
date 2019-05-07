//
//  AppDelegate.h
//  ShengYa
//
//  Created by 王开政 on 2019/4/11.
//  Copyright © 2019年 王开政. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKYBaseTabBarViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) YKYBaseTabBarViewController *tabBarController;




/**
 push远程推送界面
 
 @param remoteInfo 远程推送信息
 */
- (void)pushReomteNotificationController:(NSDictionary *)remoteInfo;


@end

