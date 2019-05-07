//
//  YKYMyEarningViewController.m
//  ShengYa
//
//  Created by apple on 2019/4/22.
//  Copyright © 2019 Wkz. All rights reserved.
//

#import "YKYMyEarningViewController.h"


#import "YKYEarningChildViewController.h"

@interface YKYMyEarningViewController ()<GLViewPagerViewControllerDataSource,GLViewPagerViewControllerDelegate>
{
    
    NSInteger selfIndex;
}
@property (nonatomic,strong)NSMutableArray *viewControllers;
@property (nonatomic,strong)NSMutableArray *tagTitles;

@property(nonatomic,strong)NSMutableArray *columnArray;

@property(nonatomic,strong)UIView *searchView;
@property(nonatomic,strong)UITextField *seacrhText;
@property(nonatomic,strong)UILabel *titleLabel;
@end

@implementation YKYMyEarningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"累计收益";
    
    
    self.navigationController.navigationBarHidden = YES;
    //    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-SafeAreaTopHeight - 35);
    self.columnArray = [[NSMutableArray alloc]init];
    
    self.viewControllers = [[NSMutableArray alloc]init];
    self.tagTitles = [[NSMutableArray alloc]init];
    
    
    self.dataSource = self;
    self.delegate = self;
    self.fixTabWidth = NO;
    self.indicatorWidth = 35;
    self.fixIndicatorWidth = NO;
    
    self.padding = 35;
    self.leadingPadding = 35;
    self.trailingPadding = 35;
    
    self.tabHeight = 35;
    self.tabAnimationType = GLTabAnimationType_whileScrolling;
    
    self.indicatorColor = kColor(255, 87, 1);
    
//    self.tabFontSelected = kColor(255, 87, 1);

    self.tagTitles = @[@"全部",@"即将到账",@"已到账",@"无效订单",];
    //    orderChildVC *viewControl = [[orderChildVC alloc]init];
    //    __weak typeof(self) weakself = self;
    //    viewControl.returnBlock = ^(NSDictionary * _Nonnull dictionary) {
    //        orderDetailVC *VC = [[orderDetailVC alloc]init];
    //        weakself.navigationController.navigationBarHidden=NO;
    //        [VC setHidesBottomBarWhenPushed:YES];
    //        [weakself.navigationController pushViewController:VC animated:YES];
    //    };
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
    
    // Do any additional setup after loading the view.
}
-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    [self.view endEditing:YES];
    
}
-(void)viewWillAppear:(BOOL)animated{
  
    self.defaultDisplayPageIndex = self.PageIndex;
    
    [self.navigationController.navigationBar setBarTintColor:kColor(255, 255, 255)];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kColor(51, 51, 51)}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    NSLog(@"00000");
    self.navigationController.navigationBarHidden = NO;
    NSLog(@"self.menuArr = %@",self.menuArr);
    
    for (int i =0; i < 4; i ++) {
        YKYEarningChildViewController *viewControl = [[YKYEarningChildViewController alloc]initWithTitle:nil andType:[NSString stringWithFormat:@"%d",i+1]];
        __weak typeof(self) weakself = self;
//        viewControl.fromVC = self.fromVC;
//        viewControl.returnBlock = ^(NSDictionary * _Nonnull dictionary) {
//            orderDetailVC *VC = [[orderDetailVC alloc]init];
//            VC.dictionary = dictionary;
//            VC.type = self.type;
//            weakself.navigationController.navigationBarHidden=NO;
//            [VC setHidesBottomBarWhenPushed:YES];
//            [weakself.navigationController pushViewController:VC animated:YES];
//        };
        [self.viewControllers addObject:viewControl];
   
        //        [self.tagTitles addObject:@"待发货"];
        //        NSLog(@"self.menuArr = %@",self.menuArr[i][@"typeName"]);
    }

}





-(void)backPress{
    
    //    [self.navigationController popViewControllerAnimated:YES];
    NSArray *pushVCAry=[self.navigationController viewControllers];
    UIViewController *popVC=[pushVCAry objectAtIndex:0];
    [self.navigationController popToViewController:popVC animated:YES];
}
#pragma mark - GLViewPagerViewControllerDataSource
- (NSUInteger)numberOfTabsForViewPager:(GLViewPagerViewController *)viewPager {
    return self.viewControllers.count;
}



- (UIView *)viewPager:(GLViewPagerViewController *)viewPager
      viewForTabIndex:(NSUInteger)index {
    UILabel *label = [[UILabel alloc]init];
    label.text = [self.tagTitles objectAtIndex:index];
    label.font = KPFFont(13);
    label.textColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    //    label.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    
    return label;
}

- (UIViewController *)viewPager:(GLViewPagerViewController *)viewPager
contentViewControllerForTabAtIndex:(NSUInteger)index {
    
    return self.viewControllers[index];
}
#pragma mark - GLViewPagerViewControllerDelegate
- (void)viewPager:(GLViewPagerViewController *)viewPager didChangeTabToIndex:(NSUInteger)index fromTabIndex:(NSUInteger)fromTabIndex {
    NSLog(@"点击%ld",index);
    selfIndex = index;
    UILabel *prevLabel = (UILabel *)[viewPager tabViewAtIndex:fromTabIndex];
    UILabel *currentLabel = (UILabel *)[viewPager tabViewAtIndex:index];
    prevLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    currentLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    prevLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    currentLabel.textColor = kColor(255, 87, 1);
    
    //    UIView * view =(UIView *)[viewPager tabViewAtIndex:index];
    //    view.backgroundColor = [UIColor orangeColor];
}

- (void)viewPager:(GLViewPagerViewController *)viewPager willChangeTabToIndex:(NSUInteger)index fromTabIndex:(NSUInteger)fromTabIndex withTransitionProgress:(CGFloat)progress {
    
    if (fromTabIndex == index) {
        return;
    }
    
    UILabel *prevLabel = (UILabel *)[viewPager tabViewAtIndex:fromTabIndex];
    UILabel *currentLabel = (UILabel *)[viewPager tabViewAtIndex:index];
    prevLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity,
                                                 1.0 - (0.1 * progress),
                                                 1.0 - (0.1 * progress));
    currentLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity,
                                                    0.9 + (0.1 * progress),
                                                    0.9 + (0.1 * progress));
    prevLabel.textColor = [UIColor colorWithWhite:0.0 alpha:1.0 - (0.5 * progress)];
    currentLabel.textColor = kCOLOR_RGBA(255, 87, 1, 0.5 +(0.5 * progress));
    
    
}

- (CGFloat)viewPager:(GLViewPagerViewController *)viewPager widthForTabIndex:(NSUInteger)index {
    static UILabel *prototypeLabel ;
    if (!prototypeLabel) {
        prototypeLabel = [[UILabel alloc]init];
    }
    prototypeLabel.text = [self.tagTitles objectAtIndex:index];
    prototypeLabel.textAlignment = NSTextAlignmentCenter;
    prototypeLabel.font = [UIFont systemFontOfSize:16.0];
    return prototypeLabel.intrinsicContentSize.width;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        //        [self.textView resignFirstResponder];
        NSLog(@"1111");
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //判断当前Textfield输入几个字符之后跳转到下一个Textfield
    
    
    return YES;
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
