//
//  YKYBaseNavigationControler.m
//  ShengYa
//
//  Created by 王开政 on 2019/4/11.
//  Copyright © 2019年 Wkz. All rights reserved.
//

#import "YKYBaseNavigationControler.h"

@interface YKYBaseNavigationControler ()

@end

@implementation YKYBaseNavigationControler

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 自定义导航栏
    [self customNavigationBar];
}

/**
 自定义导航栏第一步（第二步在BaseViewController）
 */
- (void)customNavigationBar {
//    UIGraphicsBeginImageContextWithOptions(self.navigationBar.frame.size, NO, [UIScreen mainScreen].scale);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
//    CGContextFillRect(context, CGRectMake(0, 0, self.navigationBar.frame.size.width, self.navigationBar.frame.size.height));
//    //    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    UIImage *originImage = [UIImage imageNamed:@"navigationbar_back"];
    // 返回按钮图标距离原始位置的偏移量
    CGFloat backImageLeft = 7.0f;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(originImage.size.width + backImageLeft, originImage.size.height), NO, [UIScreen mainScreen].scale);
    CGContextRef context2 = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context2, 0, originImage.size.height);
    CGContextScaleCTM(context2, 1.0, -1.0);
    CGContextDrawImage(context2, CGRectMake(backImageLeft, 0, originImage.size.width, originImage.size.height), originImage.CGImage);
    UIImage *backImage = [UIGraphicsGetImageFromCurrentImageContext() imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIGraphicsEndImageContext();
    // 全体[UINavigationBar appearance]
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, 0)
                                                         forBarMetrics:UIBarMetricsDefault];
    // 设置返回按钮
    [self.navigationBar setBackIndicatorImage:backImage];
    [self.navigationBar setBackIndicatorTransitionMaskImage:backImage];
    
    self.navigationController.navigationBar.topItem.title = @"";
    
    //    [self.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    // 背景颜色
    [self.navigationBar setBarTintColor:kColor(251, 81, 3)];
    
//    [self.navigationBar setBarTintColor:kColor(255, 255, 255)];
//
//    [self.navigationBar setBackgroundColor:[UIColor redColor]];
    
    
    self.navigationBar.translucent = NO;
    // 去除线
//    [self.navigationBar setShadowImage:[UIImage new]];
    // setBackgroundImage之后状态栏会变为纯黑色（iOS11 之前）
    UIView *stateBarBackView = [[UIView alloc]initWithFrame:CGRectMake(0, -kStateBarHeight, kScreenWidth, kStateBarHeight)];
//    stateBarBackView.backgroundColor = [UIColor format_colorWithHex:0xFF2262 Withalpha:1];
    [self.navigationBar addSubview:stateBarBackView];
    // 设置title颜色和字体
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName: KFont(18), NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
//    self.navigationItem.title = @"购物车";
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;
}

/**
 重写控制器pop方法
 
 @param animated 是否有pop动画
 @return 退出的控制器
 */
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    // 视图推出前先取消所有请求
//    [[GeeAFNetworkManager shared] NJ_cancelAllTasks];
    return [super popViewControllerAnimated:animated];
}

/**
 重写控制器push方法
 
 @param viewController 被push的控制器
 @param animated 是否有push动画
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ((NSInteger)self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    } else {
        viewController.hidesBottomBarWhenPushed = NO;
    }
    
//    if ([NSStringFromClass([viewController class]) isEqualToString:NSStringFromClass([BeeVipWebViewController class])]) {
//        viewController.hidesBottomBarWhenPushed = NO;
//    }
//
    [super pushViewController:viewController animated:animated];
}

- (void)goDirectback {
    [self.view endEditing:YES];
    [self popViewControllerAnimated:YES];
}

- (void)loginViewController
{
//    NJWXLoginViewController * loginVc = [[NJWXLoginViewController alloc]init];
//    GeeBaseNavigationViewController * navi = [[GeeBaseNavigationViewController alloc]initWithRootViewController:loginVc];
//    [self presentViewController:navi animated:YES completion:nil];
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
