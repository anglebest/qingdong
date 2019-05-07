//
//  YKYBaseTabBarViewController.m
//  ShengYa
//
//  Created by 王开政 on 2019/4/11.
//  Copyright © 2019年 Wkz. All rights reserved.
//

#import "YKYBaseTabBarViewController.h"

@interface YKYBaseTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation YKYBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.delegate = self;
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUpTabBarItemTextAttributes];
}
/**
 *  tabBarItem 的选中和不选中文字属性
 */
- (void)setUpTabBarItemTextAttributes {
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateHighlighted];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    //判断用户是否登陆
    if([viewController.tabBarItem.title isEqualToString:@"首页"]){
        
    }else if([viewController.tabBarItem.title isEqualToString:@"热销"]){
        
    }else if([viewController.tabBarItem.title isEqualToString:@"发圈"]){
        
    }else if([viewController.tabBarItem.title isEqualToString:@"我的"]){
        
    }
    return YES;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
