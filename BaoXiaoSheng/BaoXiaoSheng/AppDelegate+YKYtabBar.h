//
//  AppDelegate+YKYtabBar.h
//  ShengYa
//
//  Created by 王开政 on 2019/4/11.
//  Copyright © 2019年 Wkz. All rights reserved.
//

#import "AppDelegate.h"
#import "YKYBaseTabBarViewController.h"
@interface AppDelegate (YKYtabBar)

- (NSArray<UIViewController *> *)viewControllers;

- (NSArray<NSDictionary *> *)tabBarItemsAttributesForController;

- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController;
@end
