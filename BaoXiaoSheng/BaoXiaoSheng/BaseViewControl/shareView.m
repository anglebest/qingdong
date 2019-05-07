//
//  shareView.m
//  充电桩
//
//  Created by 王开政 on 2018/2/1.
//  Copyright © 2018年 李超杰. All rights reserved.
//
#define screenWidth [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height

#define items 2 //分享列表数
#define itemsScrWidth 60 //分享列表宽度

#import "shareView.h"
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/TencentApiInterface.h>
//#import <TencentOpenAPI/QQApiInterfaceObject.h>
//#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
//#import "WeiboSDK.h"
//#import "hdView.h"
@implementation shareView
-(id)initFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-150, kScreenWidth, 150)];
    
    view.backgroundColor = kColor(245, 245, 245);
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 101, screenWidth, 0.5)];
    line.backgroundColor = [UIColor colorWithHexString:@"#E5E5E5"];
    [view addSubview:self.cancelBut];
    [view addSubview:self.shareWXBut];
    [view addSubview:self.shareFriendsBut];
    [view addSubview:self.shareWXLabel];
    [view addSubview:self.shareFriendsLabel];
    
    [view addSubview:line];
    [self addSubview:view];
    
    
    UITapGestureRecognizer * tapBgView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelPress)];
    [self addGestureRecognizer:tapBgView];
    return  self;
    
}
-(UIButton *)cancelBut{
    
    if (!_cancelBut) {
        
        _cancelBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBut.frame = CGRectMake(0, 105, screenWidth, 44);
        //        self.cancelBut.layer.masksToBounds = YES;
        //        self.cancelBut.layer.cornerRadius = 22;
        [_cancelBut addTarget:self action:@selector(cancelPress) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake((screenWidth-16)/2, 20, 16, 16)];
//        imgView.image = [UIImage imageNamed:@"关闭"];
        //        self.cancelBut.backgroundColor = [UIColor colorWithRed:27/255.0 green:180/255.0 blue:63/255.0 alpha:1];
        [_cancelBut setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBut.backgroundColor = [UIColor whiteColor];
        [_cancelBut setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        //        [self.cancelBut setBackgroundColor:[UIColor whiteColor]];
        [_cancelBut addSubview:imgView];
    }
    
    
    return  _cancelBut;
}

-(UIButton *)shareQQBut{
    
    if (!_shareQQBut) {
        
        _shareQQBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareQQBut.frame = CGRectMake((screenWidth - itemsScrWidth*items)*3/(items +1)+itemsScrWidth * 2, 20, itemsScrWidth, itemsScrWidth);
        _shareQQBut.layer.masksToBounds = YES;
        _shareQQBut.layer.cornerRadius = 5;
        [_shareQQBut addTarget:self action:@selector(shareQQPress) forControlEvents:UIControlEventTouchUpInside];
        [_shareQQBut setImage:[UIImage imageNamed:@"shareQQ"] forState:UIControlStateNormal];
    }
    
    
    return  _shareQQBut;
}
-(UIButton *)shareFriendsBut{
    
    if (!_shareFriendsBut) {
        
        _shareFriendsBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareFriendsBut.frame = CGRectMake((screenWidth - itemsScrWidth*items)*2/(items +1) +itemsScrWidth, 20, itemsScrWidth, itemsScrWidth);
        _shareFriendsBut.layer.masksToBounds = YES;
        _shareFriendsBut.layer.cornerRadius = 5;
        [_shareFriendsBut addTarget:self action:@selector(shareFriendsPress) forControlEvents:UIControlEventTouchUpInside];
        [_shareFriendsBut setImage:[UIImage imageNamed:@"分享朋友圈"] forState:UIControlStateNormal];
    }
    
    
    return  _shareFriendsBut;
}
-(UIButton *)shareWXBut{
    
    if (!_shareWXBut) {
        
        _shareWXBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareWXBut.frame = CGRectMake((screenWidth - itemsScrWidth*items)*1/(items +1) , 20, itemsScrWidth, itemsScrWidth);
        _shareWXBut.layer.masksToBounds = YES;
        _shareWXBut.layer.cornerRadius = 5;
        [_shareWXBut addTarget:self action:@selector(shareWXPress) forControlEvents:UIControlEventTouchUpInside];
        //        self.cancelBut.backgroundColor = [UIColor colorWithRed:27/255.0 green:180/255.0 blue:63/255.0 alpha:1];
        [_shareWXBut setImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
    }
    
    
    return  _shareWXBut;
}
-(UIButton *)shareWBBut{
    
    if (!_shareWBBut) {
        
        _shareWBBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareWBBut.frame = CGRectMake((screenWidth - itemsScrWidth*items)*4/(items +1) +itemsScrWidth*3, 20, itemsScrWidth, itemsScrWidth);
        _shareWBBut.layer.masksToBounds = YES;
        _shareWBBut.layer.cornerRadius = 5;
        [_shareWBBut addTarget:self action:@selector(shareWBPress) forControlEvents:UIControlEventTouchUpInside];
        //        self.cancelBut.backgroundColor = [UIColor colorWithRed:27/255.0 green:180/255.0 blue:63/255.0 alpha:1];
        [_shareWBBut setImage:[UIImage imageNamed:@"shareWB"] forState:UIControlStateNormal];
    }
    
    
    return  _shareWBBut;
}
-(UILabel *)shareTitleLabel{
    
    if (!_shareTitleLabel) {
        
        _shareTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 60, 30)];
        _shareTitleLabel.text = @"分享到 ";
        _shareTitleLabel.textAlignment = NSTextAlignmentCenter;
        _shareTitleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _shareTitleLabel.font = [UIFont systemFontOfSize:14];
        
    }
    
    
    return  _shareTitleLabel;
}

-(UILabel *)shareQQLabel{
    
    if (!_shareQQLabel) {
        
        _shareQQLabel = [[UILabel alloc]initWithFrame:CGRectMake((screenWidth - itemsScrWidth*items)*3/(items +1)+itemsScrWidth * 2, 87, itemsScrWidth, 12)];
        _shareQQLabel.text = @"QQ ";
        _shareQQLabel.textAlignment = NSTextAlignmentCenter;
        _shareQQLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _shareQQLabel.font = [UIFont systemFontOfSize:12];
        
    }
    
    
    return  _shareQQLabel;
}
-(UILabel *)shareFriendsLabel{
    
    if (!_shareFriendsLabel) {
        
        _shareFriendsLabel = [[UILabel alloc]initWithFrame:CGRectMake((screenWidth - itemsScrWidth*items)*2/(items +1) +itemsScrWidth, 75, itemsScrWidth, 12)];
        _shareFriendsLabel.text = @"朋友圈 ";
        _shareFriendsLabel.textAlignment = NSTextAlignmentCenter;
        _shareFriendsLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _shareFriendsLabel.font = [UIFont systemFontOfSize:12];
        
    }
    
    
    return  _shareFriendsLabel;
}
-(UILabel *)shareWXLabel{
    
    if (!_shareWXLabel) {
        
        _shareWXLabel = [[UILabel alloc]initWithFrame:CGRectMake((screenWidth - itemsScrWidth*items)*1/(items +1) , 80, itemsScrWidth, 12)];
        _shareWXLabel.text = @"微信好友 ";
        _shareWXLabel.textAlignment = NSTextAlignmentCenter;
        _shareWXLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _shareWXLabel.font = [UIFont systemFontOfSize:12];
        
    }
    
    
    return  _shareWXLabel;
}
-(UILabel *)shareWBLabel{
    
    if (!_shareWBLabel) {
        
        _shareWBLabel = [[UILabel alloc]initWithFrame:CGRectMake((screenWidth - itemsScrWidth*items)*4/(items +1) +itemsScrWidth*3, 87, itemsScrWidth, 12)];
        _shareWBLabel.text = @"微博";
        _shareWBLabel.textAlignment = NSTextAlignmentCenter;
        _shareWBLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _shareWBLabel.font = [UIFont systemFontOfSize:12];
        
    }
    
    
    return  _shareWBLabel;
}
-(void)sharePress
{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.coverView.hidden = NO;
        self.shareView.frame = CGRectMake(0, screenHeight -157, screenWidth, 300);
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}

-(void)cancelPress
{
    __weak typeof(self) weakself = self;
    
    if (weakself.cancleSharePress) {
        
        weakself.cancleSharePress();
    }

}

/*
//qq分享
-(void)shareQQPress
{
    [self cancelPress];
    //shareChannel:分享途径：0-微信，1-QQ，2-微博，3-朋友圈
    NSDictionary *shareDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:self.shareType,@"shareType",self.titleStr,@"shareTitle",@"1",@"shareChannel",nil];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:shareDictionary forKey:@"shareDictionary"];
    
    if ([QQApiInterface isQQInstalled] ){
        //判断当前微信的版本是否支持OpenApi
        if ([QQApiInterface isQQSupportApi]) {
    NSURL *url = [NSURL URLWithString:self.urlStr];
    
    NSURL *preimageUrl = [NSURL URLWithString:self.imageUrlStr];
    QQApiNewsObject* img = [QQApiNewsObject objectWithURL:url title:self.titleStr description:[NSString stringWithFormat:@"%@",self.descriptionStr] previewImageURL:preimageUrl];
    
    //请求帮助类,分享的所有基础对象，都要封装成这种请求对象。
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
            NSLog(@"QQApiSendResultCode %d",sent);
            if (sent ==0) {
                [hdView showSuccessViewMessage:@"分享成功"];
            }
            else{
//                [hdView showSuccessViewMessage:@"分享失败"];
            }
    //通过自定义的qqdelegate来通知本controller，是否成功分享
        }else{
            NSLog(@"请升级微信至最新版本！");
            [hdView showErrorViewMessage:@"请升级QQ至最新版本！"];
        }
    }else{
        NSLog(@"请安装微信客户端");
        [hdView showErrorViewMessage:@"请安装QQ客户端！"];
        
    }
    
    
    
}
 */
//朋友圈
-(void)shareFriendsPress
{
    [self cancelPress];
    //shareChannel:分享途径：0-微信，1-QQ，2-微博，3-朋友圈
    NSDictionary *shareDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:self.shareType,@"shareType",self.titleStr,@"shareTitle",@"3",@"shareChannel",nil];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:shareDictionary forKey:@"shareDictionary"];
    if ([WXApi isWXAppInstalled] ){
        //判断当前微信的版本是否支持OpenApi
        if ([WXApi isWXAppSupportApi]) {
    
    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
    sendReq.bText = NO;//不使用文本信息
    sendReq.scene = 1;//0 = 好友列表 1 = 朋友圈 2 = 收藏
    
    //创建分享内容对象
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    urlMessage.title = self.titleStr;//分享标题
    urlMessage.description = self.descriptionStr;//分享描述
    //1.url
    NSURL *url =[NSURL URLWithString:self.imageUrlStr];
    //2.根据URL获取数据
    NSData *data =[NSData dataWithContentsOfURL:url];
    //3.根据数据获取图片
    UIImage *image =[UIImage imageWithData:data];
    
    [urlMessage setThumbImage:image];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
    
    //创建多媒体对象
    WXWebpageObject *webObj = [WXWebpageObject object];
    webObj.webpageUrl = self.urlStr;//分享链接
    
    //完成发送对象实例
    urlMessage.mediaObject = webObj;
    sendReq.message = urlMessage;
    
    //发送分享信息
    [WXApi sendReq:sendReq];
    }else{
            NSLog(@"请升级微信至最新版本！");
            [MBProgressHUD showMessage:@"请升级微信至最新版本！" toView:self];
        }
    }else{
        NSLog(@"请安装微信客户端");
        
        [MBProgressHUD showMessage:@"请安装微信客户端！" toView:self];
        
    }
    
    
    
}
//微信好友
-(void)shareWXPress
{
    [self cancelPress];
    //shareChannel:分享途径：0-微信，1-QQ，2-微博，3-朋友圈
    NSDictionary *shareDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:self.shareType,@"shareType",self.titleStr,@"shareTitle",@"0",@"shareChannel",nil];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:shareDictionary forKey:@"shareDictionary"];
    NSLog(@"微信分享 = %@",self.imageUrlStr);
    if ([WXApi isWXAppInstalled] ){
        //判断当前微信的版本是否支持OpenApi
        if ([WXApi isWXAppSupportApi]) {
            SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
            sendReq.bText = NO;//不使用文本信息
            sendReq.scene = 0;//0 = 好友列表 1 = 朋友圈 2 = 收藏
            
            //创建分享内容对象
            WXMediaMessage *urlMessage = [WXMediaMessage message];
            urlMessage.title = self.titleStr;//分享标题
            urlMessage.description = self.descriptionStr;//分享描述
            
            //1.url
            NSURL *url =[NSURL URLWithString:self.imageUrlStr];
            //2.根据URL获取数据
            NSData *data =[NSData dataWithContentsOfURL:url];
            //3.根据数据获取图片
            UIImage *image =[UIImage imageWithData:data];
            
            
            [urlMessage setThumbImage:image];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
            //创建多媒体对象
            WXWebpageObject *webObj = [WXWebpageObject object];
            webObj.webpageUrl = self.urlStr;//分享链接
            
            //完成发送对象实例
            urlMessage.mediaObject = webObj;
            sendReq.message = urlMessage;
            
            //发送分享信息
            [WXApi sendReq:sendReq];
        }else{
//            NSLog(@"请升级微信至最新版本！");
//            [hdView showErrorViewMessage:@"请升级微信至最新版本！"];
            [MBProgressHUD showMessage:@"请升级微信至最新版本！" toView:self];
        }
    }else{
//        NSLog(@"请安装微信客户端");
//        [hdView showErrorViewMessage:@"请安装微信客户端！"];
        [MBProgressHUD showMessage:@"请安装微信客户端！" toView:self];
        
    }

   
//     [WXApi sendAuthReq:sendReq viewController:self delegate:nil];
    
    
}
/*
//微博
-(void)shareWBPress
{
    [self cancelPress];
    //shareChannel:分享途径：0-微信，1-QQ，2-微博，3-朋友圈
    NSDictionary *shareDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:self.shareType,@"shareType",self.titleStr,@"shareTitle",@"2",@"shareChannel",nil];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:shareDictionary forKey:@"shareDictionary"];
    
    if (![WeiboSDK isWeiboAppInstalled]) {
        
        [hdView showErrorViewMessage:@"请安装新浪微博客户端！"];
        
    }else {
        WBMessageObject *message = [WBMessageObject message];
        message.text  = [self.titleStr stringByAppendingString:self.descriptionStr];
        NSLog(@"descriptionStr = %@",self.descriptionStr);
        // 消息的图片内容中，图片数据不能为空并且大小不能超过10M
        WBImageObject *imageObject = [WBImageObject object];
        //1.url
        NSURL *url =[NSURL URLWithString:self.imageUrlStr];
        //2.根据URL获取数据
        NSData *data =[NSData dataWithContentsOfURL:url];
        //3.根据数据获取图片
        UIImage *image =[UIImage imageWithData:data];
        imageObject.imageData = UIImageJPEGRepresentation(image, 1.0);
        message.imageObject = imageObject;
        
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
        [WeiboSDK sendRequest:request];
    }
    
    
    
    
    
}
 */
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
