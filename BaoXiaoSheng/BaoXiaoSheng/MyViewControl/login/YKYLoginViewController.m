//
//  YKYLoginViewController.m
//  ShengYa
//
//  Created by apple on 2019/4/30.
//  Copyright © 2019 Wkz. All rights reserved.
//
#define kWXAPP_ID @"wxf449a8a6cb17cb00"
#define kWXAPP_SECRET @"6c9f4bc9cb8e17c1a9116c3b3ec6b65d"
#import "YKYLoginViewController.h"
#import "WXApi.h"

#import "YKYUserInforModel.h"

@interface YKYLoginViewController ()
@property(nonatomic , strong)UIImageView *headImg;

@property(nonatomic , strong)UIImageView *logoImg;

@property(nonatomic , strong)UILabel *label;

@property(nonatomic , strong)UIButton *loginBtn;

@property(nonatomic , strong)UIButton *backBtn;

@property(nonatomic , strong)UIButton *WXBtn;

@property(nonatomic, strong) UITextField *phoneField;

@property(nonatomic, strong) UITextField *codeField;

@end

@implementation YKYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor(255, 255, 255);
    
    
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(SafeAreaTopHeight-30);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(35*RATIO);
        
        make.width.mas_equalTo(35*RATIO);
    }];
    [self.view addSubview:self.headImg];
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(80);
        make.left.mas_equalTo(128*RATIO);
        make.height.mas_equalTo(130*RATIO);
        make.width.mas_equalTo(111*RATIO);
    }];
    
    [self.view addSubview:self.logoImg];
    [self.logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImg.mas_bottom).mas_offset(10);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(78*RATIO);
        
        make.width.mas_equalTo(78*RATIO);
    }];
    
    
    [self.view addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImg.mas_bottom).mas_offset(10);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(40*RATIO);
        
        make.width.mas_equalTo(kScreenWidth);
    }];
    
    
    [self.view addSubview:self.WXBtn];
    [self.WXBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label.mas_bottom).mas_offset(66);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(35*RATIO);

        make.width.mas_equalTo(195*RATIO);
    }];
    
    UILabel *lab = [UILabel new];
//    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = kColor(51, 51, 51);
    lab.font = KFont(10);
    lab.text = @"登录即代表您同意";
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_offset(-50);
        make.left.mas_equalTo(self.view).mas_offset(117*RATIO);
        make.height.mas_equalTo(12*RATIO);
//        make.width.mas_equalTo(kScreenWidth);
    }];
    
    UIButton *agreeBtn = [UIButton new];
    [agreeBtn setTitle:@"省丫使用条款" forState:0];
    agreeBtn.titleLabel.font = KPFFont(10);
    [agreeBtn setTitleColor:kColor(51, 51, 51) forState:0];
    
    [self.view addSubview:agreeBtn];
    [agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_offset(-50);
        make.left.mas_equalTo(lab.mas_right).mas_offset(2*RATIO);
        make.height.mas_equalTo(12*RATIO);
        //        make.width.mas_equalTo(kScreenWidth);
    }];
    
    
    UIButton *changeBtn = [UIButton new];
    [changeBtn setTitle:@"其他登录方式" forState:0];
    changeBtn.titleLabel.font = KPFFont(10);
    [changeBtn setTitleColor:kColor(51, 51, 51) forState:0];
    
    [self.view addSubview:changeBtn];
    [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_offset(-30);
        make.left.mas_equalTo(self.view);
        make.height.mas_equalTo(12*RATIO);
        make.width.mas_equalTo(kScreenWidth);
    }];
    
    
//    [self setUI];
    // Do any additional setup after loading the view.
}
-(void)setUI{
 
    
   
    [self.view addSubview:self.phoneField];
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label.mas_bottom).mas_offset(40);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(35*RATIO);
        
        make.width.mas_equalTo(220*RATIO);
    }];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = kColor(153, 153, 153);
    
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneField.mas_bottom).mas_offset(0.5);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(1*RATIO);
        
        make.width.mas_equalTo(186*RATIO);
    }];
    
    [self.view addSubview:self.codeField];
    [self.codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneField.mas_bottom).mas_offset(10);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(35*RATIO);
        
        make.width.mas_equalTo(220*RATIO);
    }];
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = kColor(153, 153, 153);
    
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeField.mas_bottom).mas_offset(0.5);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(1*RATIO);
        
        make.width.mas_equalTo(186*RATIO);
    }];
    
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeField.mas_bottom).mas_offset(60);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(24*RATIO);
        
        make.width.mas_equalTo(70*RATIO);
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessByCode:) name:@"wechatDidLoginNotification" object:nil];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"wechatDidLoginNotification" object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"notificationLogin" object:nil];
    
}
-(UIImageView *)headImg{
    if (!_headImg) {
        _headImg = [UIImageView new];
        _headImg.image = [UIImage imageNamed:@"登陆头部"];
    }
    
    return _headImg;
}

-(UIImageView *)logoImg{
    if (!_logoImg) {
        _logoImg = [UIImageView new];
        _logoImg.image = [UIImage imageNamed:@"logo"];
    }
    
    return _logoImg;
}
-(UILabel *)label{
    if (!_label) {
        _label = [UILabel new];
        _label.font = KPFFont(12);
        _label.numberOfLines = 2;
        _label.textColor = kColor(253, 80, 63);
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = @"省钱高达90%的\n购物优惠券搜索平台";
        
    }
    return _label;
}

-(UIButton *)WXBtn{
    if (!_WXBtn) {
        _WXBtn = [UIButton new];
        
        _WXBtn.layer.masksToBounds = YES;
        _WXBtn.layer.cornerRadius =17.5;
        _WXBtn.backgroundColor = kColor(0, 200, 0);
        
        _WXBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5.f);
        [_WXBtn setTitleColor:[UIColor whiteColor] forState:0];
        [_WXBtn setImage:[UIImage imageNamed:@"微信登陆"] forState:UIControlStateNormal];
        [_WXBtn setTitle:@" 微信登陆" forState:UIControlStateNormal];
        [_WXBtn addTarget:self action:@selector(weixinLogin) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _WXBtn;
}
-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton new];
        
        _backBtn.layer.masksToBounds = YES;
        _backBtn.layer.cornerRadius =17.5;
//        _backBtn.backgroundColor = kColor(0, 200, 0);
        
        _backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5.f);
        [_backBtn setTitleColor:[UIColor whiteColor] forState:0];
        [_backBtn setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
//        [_backBtn setTitle:@" 微信登陆" forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _backBtn;
}

-(UITextField *)phoneField{
    
    if (!_phoneField) {
        _phoneField = [UITextField new];
        _phoneField.placeholder = @"输入验证码";
        _phoneField.textColor = kColor(153, 153, 153);
        _phoneField.font = KPFFont(13);
        UIImageView *imgView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
        imgView.contentMode  =  UIViewContentModeScaleAspectFit;
        imgView.image =[UIImage imageNamed:@"手机"];
        _phoneField.leftView = imgView;
        
        _phoneField.leftViewMode= UITextFieldViewModeAlways;
    }
    
    return _phoneField;
}

-(UITextField *)codeField{
    
    if (!_codeField) {
        _codeField = [UITextField new];
        _codeField.placeholder = @"输入手机号";
        _codeField.textColor = kColor(153, 153, 153);
        _codeField.font = KPFFont(13);
        UIImageView *imgView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
        imgView.contentMode  =  UIViewContentModeScaleAspectFit;
        imgView.image =[UIImage imageNamed:@"锁"];
        _codeField.leftView = imgView;
        
        _codeField.leftViewMode= UITextFieldViewModeAlways;
    }
    
    return _codeField;
}

-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton new];
        
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius =12;
//        _loginBtn.backgroundColor = kColor(0, 200, 0);
        _loginBtn.layer.borderWidth = 1;
        _loginBtn.layer.borderColor = kColor(255, 83, 3).CGColor;
        _loginBtn.titleLabel.font = KPFFont(13);
//        _loginBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5.f);
        [_loginBtn setTitleColor:kColor(255, 83, 3) forState:0];
//        [_loginBtn setImage:[UIImage imageNamed:@"微信登陆"] forState:UIControlStateNormal];
        [_loginBtn setTitle:@"登    录" forState:UIControlStateNormal];
        
    }
    return _loginBtn;
}
-(void)back{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
-(void)weixinLogin{
    
    
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo"; // @"post_timeline,sns"
//    req.state = @"wx_oauth_authorization_state";
    req.openID = @"wxf449a8a6cb17cb00";
    
    [WXApi sendReq:req];
    
    
   
}
//微信获取openID
-(void)loginSuccessByCode:(NSDictionary *)code{
    
    NSString *codeString = [[code valueForKey:@"userInfo" ] valueForKey:@"code"];
    NSLog(@"code %@",codeString);
    __weak typeof(*&self) weakSelf = self;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json",@"text/plain", nil];
    //通过 appid  secret 认证code . 来发送获取 access_token的请求
//    NSLog(@"kWXAPP_SECRET = %@",kWXAPP_SECRET);
//    NSLog(@"kWXAPP_SECRET = %@",[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",kWXAPP_ID,kWXAPP_SECRET,codeString] );
    [manager GET:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",kWXAPP_ID,kWXAPP_SECRET,codeString] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {  //获得access_token，然后根据access_token获取用户信息请求。
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dic %@",dic);
        
        /*
         access_token   接口调用凭证
         expires_in access_token接口调用凭证超时时间，单位（秒）
         refresh_token  用户刷新access_token
         openid 授权用户唯一标识
         scope  用户授权的作用域，使用逗号（,）分隔
         unionid     当且仅当该移动应用已获得该用户的userinfo授权时，才会出现该字段
         */
        NSString* accessToken=[dic valueForKey:@"access_token"];
        NSString* openID=[dic valueForKey:@"unionid"];
//        self.openID = openID;
//        NSLog(@"微信 openID == %@",openID);
        [weakSelf requestUserInfoByToken:accessToken andOpenid:openID];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@",error.localizedFailureReason);
    }];
    //移除通知
    //     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"wechatDidLoginNotification" object:nil];
}
//微信根据openID 获取个人信息
-(void)requestUserInfoByToken:(NSString *)token andOpenid:(NSString *)openID{
    NSLog(@"获取个人信息");
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",token,openID] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"11111dic  ==== %@",dic);
        if ([[dic allKeys] containsObject:@"errcode"]) {
            
            //             [SVProgressHUD showInfoWithStatus:@"授权登录失败，请重试"];
            
        }
        else
        {
            NSLog(@"openid = %@",[dic valueForKey:@"openid"]);
            
            
            YKYUserInforModel *userModel = [YKYUserInforModel modelWithJSON:dic];
            
            
            
            [[YKYUserInfor shared]setUserInfo:userModel];
            //        self.openID  = [dic valueForKey:@"openid"];
//            self.address =[[dic valueForKey:@"province"] stringByAppendingString:[dic valueForKey:@"city"]];
//            self.headPic = [dic valueForKey:@"headimgurl"];
//            self.gender = [dic valueForKey:@"sex"];
//            self.nickname = [dic valueForKey:@"nickname"];
//            [self thirdPartyLoginRequest:@"0" andOpenID:self.openID];
            //绑定类型 0-微信 1-qq 2-微博
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %ld",(long)error.code);
    }];
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
