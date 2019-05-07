//
//  AppDelegate+YKYtabBar.m
//  ShengYa
//
//  Created by 王开政 on 2019/4/11.
//  Copyright © 2019年 Wkz. All rights reserved.
//

#import "AppDelegate+YKYtabBar.h"
#import "YKYHomeViewController.h"
#import "YKYFriendViewController.h"
#import "YKYShoppingCartViewController.h"
#import "YKYMyViewController.h"
#import "YKYBaseNavigationControler.h"

#import "YKYMessageViewController.h"

@implementation AppDelegate (YKYtabBar)
- (NSArray<UIViewController *> *)viewControllers {
    NSMutableArray<YKYBaseNavigationControler *> *childViewControllers = [[NSMutableArray alloc]init];
    // 首页
    YKYHomeViewController *home = [[YKYHomeViewController alloc]init];
    YKYBaseNavigationControler *homeNavigation = [[YKYBaseNavigationControler alloc]initWithRootViewController:home];
//    [homeNavigation setNavigationBarHidden:YES animated:NO];
    [childViewControllers addObject:homeNavigation];
    
    // 朋友圈
        
        YKYFriendViewController *nectar = [[YKYFriendViewController alloc]init];
        YKYBaseNavigationControler *nectarNavigation = [[YKYBaseNavigationControler alloc]initWithRootViewController:nectar];
        [nectarNavigation.navigationBar setBarTintColor:kColor(251, 81, 3)];
        [childViewControllers addObject:nectarNavigation];
        
    
    
    // 购物车
    YKYMessageViewController *cart = [[YKYMessageViewController alloc]init];
    YKYBaseNavigationControler *cartNavigation = [[YKYBaseNavigationControler alloc]initWithRootViewController:cart];
    //    nectarNavigation.navigationBar.hidden = YES;
    [childViewControllers addObject:cartNavigation];
    // 我的
    YKYMyViewController *mine = [[YKYMyViewController alloc]init];
    YKYBaseNavigationControler *mineNavigation = [[YKYBaseNavigationControler alloc]initWithRootViewController:mine];
    [childViewControllers addObject:mineNavigation];
    
    return childViewControllers;
}

/*
 *
 在`-setViewControllers:`之前设置TabBar的属性，
 *
 */
- (NSArray<NSDictionary *> *)tabBarItemsAttributesForController {
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"首页",
                            CYLTabBarItemImage : @"首页未选中",
                            CYLTabBarItemSelectedImage : @"首页"
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"朋友圈",
                            CYLTabBarItemImage : @"朋友圈未选中",
                            CYLTabBarItemSelectedImage : @"朋友圈"
                            };
    
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"购物车",
                            CYLTabBarItemImage : @"购物车未选中",
                            CYLTabBarItemSelectedImage : @"购物车"
                            };
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"我的未选中",
                            CYLTabBarItemSelectedImage : @"我的"
                            };
    NSArray *tabBarItemsAttributes;
//    if (![[NJUserInfoManager shared] auditStatus]) {
//        tabBarItemsAttributes = @[ dict1, dict2, dict3, dict4];
//    }else {
//        tabBarItemsAttributes = @[ dict1, dict3, dict4];
//    }
    tabBarItemsAttributes = @[ dict1, dict2, dict3, dict4];
    return tabBarItemsAttributes;
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    
    // Customize UITabBar height
    // 自定义 TabBar 高度
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] =kColor(153, 153, 153);
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    
    selectedAttrs[NSForegroundColorAttributeName] =kCOLOR_RGBA(255, 85, 3,1);
    
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    // [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
    // [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    //    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
    
    // set the bar background image
    // 设置背景图片
    //    UITabBar *tabBarAppearance = [UITabBar appearance];
    
    //FIXED: #196
    //    UIImage *tabBarBackgroundImage = [UIImage imageNamed:@"tab_bar"];
    //    UIImage *scanedTabBarBackgroundImage = [[self class] scaleImage:tabBarBackgroundImage toScale:1.0];
    //     [tabBarAppearance setBackgroundImage:scanedTabBarBackgroundImage];
    
    // remove the bar system shadow image
    // 去除 TabBar 自带的顶部阴影
    // iOS10 后 需要使用 `-[CYLTabBarController hideTabBadgeBackgroundSeparator]` 见 AppDelegate 类中的演示;
    //    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

@end
