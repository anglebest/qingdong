//
//  NJBaseCoverViewController.m
//  Beesgarden
//
//  Created by 张阳 on 2018/4/19.
//  Copyright © 2018年 ningjukeji. All rights reserved.
//

#import "GeeBaseCoverViewController.h"
#import "GeeTextView.h"
//#import "UIColor+NJUniteColor.h"

@interface GeeBaseCoverViewController ()

@property (nonatomic,strong) UIView * bgview;
@property (nonatomic,assign) CGFloat coverViewHeight;

@property (nonatomic,strong) UITextField * inviteCodeTextFeild;

@property (nonatomic,strong) UITextField *weixinLabel;

@property (nonatomic,strong) UILabel *superSearchLabel;

@property (nonatomic,strong) UIImageView *productImg;

@property (nonatomic,strong) YYLabel *titleLabel;

@property (nonatomic,strong) UILabel *priceLabel;

@property (nonatomic,strong) UILabel *numberLabel;

@property (nonatomic,strong) UIButton *rebateBtn;

@property (nonatomic,strong) UIButton *couponBtn;

@property (nonatomic,strong) UIButton *searchBtn;

@property (nonatomic,strong) UIButton *drawCouponBtn;


@property (nonatomic,strong) NSString *string;

@property (nonatomic,strong) NSString *type;

@property (nonatomic,strong)YKYHomeModel *model;


@end

@implementation GeeBaseCoverViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.6];
    self.view.userInteractionEnabled = YES;
    
    
    [self checkString];
}
-(void)checkString{
    //1标题2淘口令3商品ID

    if ([self.cString containsString:@"http"] && [self.cString containsString:@"id"]) {
        NSArray *array = [self.cString componentsSeparatedByString:@"="];
        self.string = array[1];
        self.type =@"3";
    }else if ([self.cString containsString:@"¥"]){
        
        NSArray *array = [self.cString componentsSeparatedByString:@"¥"];
        self.string = array[1];
        self.type =@"2";
        
    }else{
        
        self.string = self.cString;
        self.type =@"1";
        
    }
    
    
    [self searchGoodsRequest];
    
    
}
- (void)popViewTime
{
    if (self.GlobalCoverVCType == GlobalCoverVCTypeShopOwner) {
        
        
    }else if (self.GlobalCoverVCType == GlobalCoverVCTypeInviteCode) {
        
    }else if (self.GlobalCoverVCType == GlobalCoverVCTypeCustomerService){
    }else if (self.GlobalCoverVCType == GlobalCoverVCTypeSuperSearch) {
        [self setGlobalCoverVCTypeSuperSearch];
//        [self setNoSearch];
    }else if (self.GlobalCoverVCType == GlobalCoverVCTypeVIPSeePermissions){
    }else if (self.GlobalCoverVCType == GlobalCoverVCTypeNectarShare) {
        [self setGlobalCoverVCTypeNectarShare];
    }
    
    UITapGestureRecognizer * tapBgView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBgview)];
    [self.view addGestureRecognizer:tapBgView];
    
}

-(void)setNoSearch{
    
    
    
    UIView * topImageView = [UIView new];
    topImageView.backgroundColor = [UIColor whiteColor];
    topImageView.layer.masksToBounds = YES;
    topImageView.layer.cornerRadius = 10;
    [self.view addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(kWidth(53));
        make.right.equalTo(self.view.mas_right).offset(kWidth(-53));
        make.top.equalTo(self.view.mas_top).offset(kWidth(160));
        make.height.equalTo(@(kWidth(360)));
    }];
    [topImageView layoutIfNeeded];
    
    UIImageView *productImg = [UIImageView new];
    productImg.contentMode = UIViewContentModeScaleAspectFill;
//    productImg.backgroundColor = [UIColor redColor];
    productImg.image = [UIImage imageNamed:@"乌鸦"];
    [topImageView addSubview:productImg];
    self.productImg = productImg;
    [productImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topImageView).mas_offset(kWidth(45));
        make.right.equalTo(topImageView).mas_offset(kWidth(-45));
        make.top.equalTo(topImageView).mas_offset(kWidth(41));
        make.height.equalTo(@(kWidth(113)));
    }];
    
    
    YYLabel *titleLabel = [[YYLabel alloc]init];
    titleLabel.text = @"亲，此商品没有找到优惠券~\n换一款商品试下哦\n或者点击：更多搜索";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:@"亲，此商品没有找到优惠券~\n换一款商品试下哦\n或者点击：更多搜索"];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.alignment = NSTextAlignmentCenter; //设置两端对齐显示
    
    paragraphStyle.lineSpacing = 8.0; // 设置行间距
    
    titleLabel.numberOfLines = 3;
    [titleLabel setBackgroundColor:[UIColor whiteColor]];
    titleLabel.textColor = kColor(149, 149, 149);
//    titleLabel.attributedText =attributedStr;
    //    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = KPFFont(15);
    self.titleLabel = titleLabel;
    [topImageView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topImageView).mas_offset(kWidth(8));
        make.right.equalTo(topImageView).mas_offset(kWidth(-8));
        make.top.equalTo(productImg.mas_bottom).mas_offset(kWidth(27));
        //        make.height.equalTo(@(kWidth(220)));
    }];
    
    
    UIButton *searchBtn = [[UIButton alloc]init];
    //    searchBtn.titleLabel.textColor = kColor(149, 149, 149);
    searchBtn.titleLabel.font = KPFFont(13);
    [searchBtn setTitleColor:kColor(149, 149, 149) forState:0];
//    [searchBtn setTitle:@"更多搜索" forState:0];
    //    [searchBtn setImage:[UIImage imageNamed:@"优惠券背景1"] forState:0];
    
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"更多搜索"] forState:UIControlStateNormal];
    [topImageView addSubview:searchBtn];
    self.searchBtn = searchBtn;
    [self.searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topImageView).mas_offset(kWidth(0));
        make.bottom.equalTo(topImageView).mas_offset(kWidth(0));
        make.height.equalTo(@(kWidth(43)));
        make.width.equalTo(topImageView);
    }];
    
}
#pragma mark - 超级搜索
- (void)setGlobalCoverVCTypeSuperSearch
{
    
    UIView * topImageView = [UIView new];
    topImageView.backgroundColor = [UIColor whiteColor];
    topImageView.layer.masksToBounds = YES;
    topImageView.layer.cornerRadius = 10;
    [self.view addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(kWidth(53));
        make.right.equalTo(self.view.mas_right).offset(kWidth(-53));
        make.top.equalTo(self.view.mas_top).offset(kWidth(160));
        make.height.equalTo(@(kWidth(360)));
    }];
    [topImageView layoutIfNeeded];
    
    UIImageView *productImg = [UIImageView new];
    productImg.contentMode = UIViewContentModeScaleAspectFill;
    productImg.layer.masksToBounds = YES;
    productImg.layer.cornerRadius = 10;
//    productImg.backgroundColor = [UIColor redColor];
    [topImageView addSubview:productImg];
    self.productImg = productImg;
    [productImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topImageView).mas_offset(kWidth(8));
        make.right.equalTo(topImageView).mas_offset(kWidth(-8));
        make.top.equalTo(topImageView).mas_offset(kWidth(6));
        make.height.equalTo(@(kWidth(220)));
    }];
    
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:self.model.itempictUrl]];
    
    
    YYLabel *titleLabel = [[YYLabel alloc]init];
//    titleLabel.text = @"猜你想找以下的商品";
    titleLabel.numberOfLines = 2;
    [titleLabel setBackgroundColor:[UIColor whiteColor]];
    titleLabel.textColor = kColor(77, 77, 77);
//    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = KPFFont(13);
    self.titleLabel = titleLabel;
    [topImageView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topImageView).mas_offset(kWidth(8));
        make.right.equalTo(topImageView).mas_offset(kWidth(-8));
        make.top.equalTo(productImg.mas_bottom).mas_offset(kWidth(10));
        make.height.mas_equalTo(38*RATIO);
    }];
    
    
    
    NSMutableAttributedString *titleString = [NSMutableAttributedString attachmentStringWithContent:[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.model.itemType]] contentMode:UIViewContentModeScaleAspectFit attachmentSize:CGSizeMake(13*RATIO,13*RATIO) alignToFont:KPFFont(13) alignment:YYTextVerticalAlignmentCenter];
    [titleString appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@", self.model.itemTitle] attributes:@{NSFontAttributeName: KPFMFont(13), NSForegroundColorAttributeName: kColor(50, 50, 50)}]];
    
    titleString.lineSpacing = 0*RATIO;
    self.titleLabel.attributedText = titleString;
    
    UILabel *priceLabel = [[UILabel alloc]init];
    priceLabel.text = @"返后¥12.66";
//    titleLabel.numberOfLines = 2;
//    [titleLabel setBackgroundColor:[UIColor whiteColor]];
    priceLabel.textColor = kColor(255, 87, 1);
    //    titleLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.font = KPFFont(9);
    self.priceLabel = priceLabel;
    [topImageView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topImageView).mas_offset(kWidth(8));
//        make.right.equalTo(topImageView).mas_offset(kWidth(-8));
        make.top.equalTo(titleLabel.mas_bottom).mas_offset(kWidth(25));
        make.height.equalTo(@(kWidth(11)));
    }];
    
    
    NSMutableAttributedString *priceString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"到手价¥ %@",self.model.fanlihoMoney]];
    NSArray *array = [self.model.fanlihoMoney componentsSeparatedByString:@"."];
    NSString *str = array[0];
    [priceString addAttribute:NSFontAttributeName value:KFont(18) range:NSMakeRange(5,str.length)];
    
    self.priceLabel.attributedText = priceString;
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"原价";
    label.textColor = kColor(149, 149, 149);
    //    titleLabel.textAlignment = NSTextAlignmentCenter;
    label.font = KPFFont(9);
    [topImageView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topImageView).mas_offset(kWidth(8));
//        make.right.equalTo(topImageView).mas_offset(kWidth(-8));
        make.top.equalTo(titleLabel.mas_bottom).mas_offset(kWidth(5));
        make.height.equalTo(@(kWidth(11)));
    }];
    
    
    NSMutableAttributedString *originalPriceString = [[NSMutableAttributedString alloc]init];
    
    
    [originalPriceString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"原价￥%.2f",self.model.itemPrice.floatValue] attributes:@{NSForegroundColorAttributeName:kColor(149, 149, 149),NSFontAttributeName: KPFFont(9),NSStrikethroughStyleAttributeName:@(NSUnderlineStyleThick)}]];
    label.attributedText = originalPriceString;
    
    
    UILabel *numberLabel = [[UILabel alloc]init];
//    numberLabel.text = @"已抢购2.29万件";
    numberLabel.textColor = kColor(149, 149, 149);
    //    titleLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.font = KPFFont(9);
    [topImageView addSubview:numberLabel];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topImageView).mas_offset(kWidth(-8));
        //        make.right.equalTo(topImageView).mas_offset(kWidth(-8));
        make.top.equalTo(titleLabel.mas_bottom).mas_offset(kWidth(25));
        make.height.equalTo(@(kWidth(11)));
    }];
    
    numberLabel.text = self.model.itemSale.integerValue > 10000?[NSString stringWithFormat:@"已抢:%.1f万件",self.model.itemSale.floatValue/10000.0]:self.model.itemSale.integerValue == 10000?@"1万":[NSString stringWithFormat:@"已抢:%ld件",self.model.itemSale.integerValue];
    
    
    UIButton *rebateBtn = [[UIButton alloc]init];
    rebateBtn.titleLabel.textColor = kColor(250, 23, 48);
    rebateBtn.titleLabel.font = KPFFont(10);
    [rebateBtn setTitleColor:kColor(250, 23, 48) forState:0];
    [rebateBtn setTitle:@"补贴5.4" forState:0];
    [topImageView addSubview:rebateBtn];
//    [rebateBtn setImage:[UIImage imageNamed:@"返利背景1"] forState:0];
    
    [rebateBtn setBackgroundImage:[UIImage imageNamed:@"补贴背景"] forState:UIControlStateNormal];
    self.rebateBtn = rebateBtn;
    [rebateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_right).mas_offset(kWidth(1));
        make.top.equalTo(titleLabel.mas_bottom).mas_offset(kWidth(5));
        make.height.equalTo(@(kWidth(11)));
    }];
    
    
   
    
    UIImageView *line = [UIImageView new];
    line.contentMode = UIViewContentModeScaleAspectFill;
//    productImg.backgroundColor = [UIColor redColor];
    [topImageView addSubview:line];
    line.image = [UIImage imageNamed:@"虚线"];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topImageView).mas_offset(kWidth(0));
        make.right.equalTo(topImageView).mas_offset(kWidth(0));
        make.bottom.equalTo(topImageView).mas_offset(kWidth(-43));
//        make.height.equalTo(@(kWidth(1)));
    }];
    
    if (self.model.hasCoupon) {
        UIButton *couponBtn = [[UIButton alloc]init];
        couponBtn.titleLabel.textColor = kColor(250, 23, 48);
        couponBtn.titleLabel.font = KPFFont(10);
        [couponBtn setTitleColor:kColor(250, 255, 255) forState:0];
        [couponBtn setTitle:[NSString stringWithFormat:@" %@元券 ",self.model.couponMoney] forState:0];
        //    [couponBtn setImage:[UIImage imageNamed:@"优惠券背景1"] forState:0];
        
        [couponBtn setBackgroundImage:[UIImage imageNamed:@"优惠券背景"] forState:UIControlStateNormal];
        [topImageView addSubview:couponBtn];
        self.couponBtn = couponBtn;
        [couponBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rebateBtn.mas_right).mas_offset(kWidth(5));
            make.top.equalTo(rebateBtn);
            make.height.equalTo(@(kWidth(12)));
        }];
        
        
        
        UIButton *drawCouponBtn = [[UIButton alloc]init];
        //    drawCouponBtn.titleLabel.textColor = kColor(149, 149, 149);
        //    drawCouponBtn.titleLabel.font = KPFFont(13);
        //    [drawCouponBtn setTitle:@"更多搜索" forState:0];
        //    [drawCouponBtn setImage:[UIImage imageNamed:@"立即领券"] forState:0];
        
        [drawCouponBtn setBackgroundImage:[UIImage imageNamed:@"立即领券"] forState:UIControlStateNormal];
        [topImageView addSubview:drawCouponBtn];
        self.drawCouponBtn = drawCouponBtn;
        
        [self.drawCouponBtn addTarget:self action:@selector(drawCouponAction) forControlEvents:UIControlEventTouchUpInside];
        [drawCouponBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(topImageView).mas_offset(kWidth(0));
            make.bottom.equalTo(topImageView).mas_offset(kWidth(0));
            make.height.equalTo(@(kWidth(43)));
            make.width.equalTo(topImageView).multipliedBy(0.5);
        }];
    }else{
        
        
        UIButton *drawCouponBtn = [[UIButton alloc]init];
        //    drawCouponBtn.titleLabel.textColor = kColor(149, 149, 149);
        //    drawCouponBtn.titleLabel.font = KPFFont(13);
        //    [drawCouponBtn setTitle:@"更多搜索" forState:0];
        //    [drawCouponBtn setImage:[UIImage imageNamed:@"立即领券"] forState:0];
        
        [drawCouponBtn setBackgroundImage:[UIImage imageNamed:@"购买拿补贴"] forState:UIControlStateNormal];
        [topImageView addSubview:drawCouponBtn];
        self.drawCouponBtn = drawCouponBtn;
        [drawCouponBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(topImageView).mas_offset(kWidth(0));
            make.bottom.equalTo(topImageView).mas_offset(kWidth(0));
            make.height.equalTo(@(kWidth(43)));
            make.width.equalTo(topImageView).multipliedBy(0.5);
        }];
    }
    UIButton *searchBtn = [[UIButton alloc]init];
//    searchBtn.titleLabel.textColor = kColor(149, 149, 149);
    searchBtn.titleLabel.font = KPFFont(13);
    [searchBtn setTitleColor:kColor(149, 149, 149) forState:0];
    [searchBtn setTitle:@"更多搜索" forState:0];
    
    
//    [searchBtn setImage:[UIImage imageNamed:@"优惠券背景1"] forState:0];
    [topImageView addSubview:searchBtn];
    self.searchBtn = searchBtn;
    [self.searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topImageView).mas_offset(kWidth(0));
        make.bottom.equalTo(topImageView).mas_offset(kWidth(0));
        make.height.equalTo(@(kWidth(43)));
        make.width.equalTo(topImageView).multipliedBy(0.5);
    }];
    
    
    
    
   
    
    UITapGestureRecognizer * tapBgView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBgview)];
    [self.view addGestureRecognizer:tapBgView];
}
-(void)searchGoodsRequest{

    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:self.string forKey:@"str"];
    [parameters setObject:self.type forKey:@"type"];
    [[YKYNetWorking sharedYKYNetWorking] sendNetworkRequestURL:KAPIMobileHomegetPopup param:parameters superView:self.view methodType:Get andBlock:^(id  _Nullable data, NSError * _Nullable error) {
        
        NSLog(@"%@",data[@"data"][@"data"][0]);
        if ([NSString isNULLString:data[@"data"][@"data"]]) {
            [self setNoSearch];
        }else{
    
            NSArray<YKYHomeModel *> *models = [NSArray modelArrayWithClass:[YKYHomeModel classForCoder] json:data[@"data"][@"data"]];
            self.model = models[0];
            if (self.model.hasCoupon) {
                [self setGlobalCoverVCTypeSuperSearch];
            }else{
                
                [self setGlobalCoverVCTypeSuperSearch];
            }
        }
//        [self popViewTime];
    }];
    
}
#pragma mark - 采蜜暂不支持直接查看

- (void)setGlobalCoverVCTypeNectarShare
{
    UIView * bgView = [[UIView alloc]init];
    self.bgview = bgView;
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.userInteractionEnabled = YES;
    self.bgview.layer.cornerRadius = 10;
    self.bgview.layer.masksToBounds = YES;
    [self.view addSubview:bgView];
    
    [self.bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(kWidth(25));
        make.right.equalTo(self.view.mas_right).offset(kWidth(-25));
        make.centerY.equalTo(self.view);
        make.height.equalTo(@(kHeight(300)));
    }];
    
    
    UIImageView * topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nectar"]];
    topImageView.contentMode = UIViewContentModeScaleAspectFit;
    topImageView.clipsToBounds = YES;
    [self.bgview addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgview).offset(kWidth(30));
        make.right.equalTo(self.bgview).offset(kWidth(-30));
        make.top.equalTo(self.bgview).offset(kWidth(30));
        make.height.equalTo(@(kHeight(130)));
    }];
    
    
    UIButton * closeButton = [[UIButton alloc]init];
    [closeButton setImage:[UIImage imageNamed:@"login_close"]  forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgview.mas_top).offset(kWidth(5));
        make.left.equalTo(self.bgview.mas_left).offset(kWidth(5));
        make.width.equalTo(@(kWidth(50)));
    }];
    
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"暂不支持直接查看";
    titleLabel.font = KFont(20);
    titleLabel.numberOfLines = 1;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    [bgView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left);
        make.right.equalTo(bgView.mas_right);
        make.top.equalTo(topImageView.mas_bottom).offset(kHeight(10));
    }];
    
    UILabel * contentLabel = [[UILabel alloc]init];
    contentLabel.text = @"分享给微信好友，即可在其中打开链接查看内容";
    contentLabel.font = KFont(10);
    contentLabel.numberOfLines = 2;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.textColor = kColor(149, 149, 149);
    [bgView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left);
        make.right.equalTo(bgView.mas_right);
        make.top.equalTo(titleLabel.mas_bottom).offset(kHeight(15));
    }];
    
    //立即分享到微信
    UIButton * shopOwnerButton = [[UIButton alloc]init];
    shopOwnerButton.backgroundColor = kColor(149, 149, 149);
    shopOwnerButton.layer.cornerRadius = 10;
    shopOwnerButton.layer.masksToBounds = YES;
    [shopOwnerButton setTitle:@"立即分享至微信" forState:UIControlStateNormal];
    shopOwnerButton.titleLabel.font = KFont(17);
    [shopOwnerButton setTitleColor:kColor(149, 149, 149) forState:UIControlStateNormal];
    [shopOwnerButton addTarget:self action:@selector(nectarShareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shopOwnerButton];
    [shopOwnerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.bgview.mas_right).offset(kWidth(-25));
        make.left.equalTo(self.bgview.mas_left).offset(kWidth(25));
        make.bottom.equalTo(bgView.mas_bottom).offset(kHeight(-15));
        make.height.equalTo(@(kHeight(50)));
    }];
}


//立即成为店主
- (void)shopOwnerButtonClick:(UIButton*)sender
{
     [self tapBgview];
    
    if (self.coverButtonType) {
        self.coverButtonType(CoverViewButtonTypeMakeShopOwner,@"");
    }
   
}

//完成邀请
- (void)inviteCodeButtonClick:(UIButton*)sender
{
    [self tapBgview];
    if (self.coverButtonType) {
        self.coverButtonType(CoverViewButtonTypeMakeInviteCode,self.inviteCodeTextFeild.text);
    }
    
}

//粘贴
- (void)pasteButtonClick:(UIButton*)sender
{
    UIPasteboard * pasteBoard = [UIPasteboard generalPasteboard];
    self.inviteCodeTextFeild.text = pasteBoard.string;

}

//设置客服取消
- (void)cancelButtonClick:(UIButton*)sender
{
    if (self.coverButtonType) {
        self.coverButtonType(CoverViewButtonTypeMakeCancelAccount,@"");
    }
}

//设置客服确定
- (void)successButtonClick:(UIButton*)sender
{
    [self tapBgview];
//    [[GeeAFNetworkManager shared] NJ_updateKefu:@{@"kefu":self.weixinLabel.text} superView:self.view andBlock:^(id  _Nullable data, NSError * _Nullable error) {
//        if (error) {
//
//        }else {
//            if (self.coverButtonType) {
//                self.coverButtonType(CoverViewButtonTypeMakeSuccessAccount,self.weixinLabel.text);
//            }
//        }
//    }];
    
}

//VIP视频取消
- (void)VipcancelButtonClick:(UIButton*)sender
{
    [self tapBgview];
    if (self.coverButtonType) {
        self.coverButtonType(CoverViewButtonTypemakeVIPCancel,@"");
    }
}

//VIP视频权限确认
- (void)VIpSuccessButtonClick:(UIButton*)sender
{
    
//    [[GeeAFNetworkManager shared] NJ_judgeFilmCommandApi:@{@"command":self.weixinLabel.text} superView:self.view andBlock:^(id  _Nullable data, NSError * _Nullable error) {
//        if (error) {
//
//        }else {
//            if (self.coverButtonType) {
//                [self tapBgview]; self.coverButtonType(CoverViewButtonTypemakeVIPSuccess,self.weixinLabel.text);
//            }
//
//        }
//    }];
}


//超级搜素
- (void)jindongSuperSearchButtonClick:(UIButton*)sender
{
    [self tapBgview];
    if (self.coverButtonType) {
        self.coverButtonType(CoverViewButtonTypemakeSuperSearchJD,self.superSearchLabel.text);
    }
}

- (void)tobaoSuperSearchButtonClick:(UIButton*)sender
{
    [self tapBgview];
    if (self.coverButtonType) {
        self.coverButtonType(CoverViewButtonTypemakeSuperSearchTB,self.superSearchLabel.text);
    }
}

- (void)mogujieSuperSearchButtonClick:(UIButton*)sender
{
    [self tapBgview];
    if (self.coverButtonType) {
        self.coverButtonType(CoverViewButtonTypemakeSuperSearchMGJ,self.superSearchLabel.text);
    }
}

//采蜜不支持直接查看的弹框

- (void)nectarShareButtonClick:(UIButton*)sender
{
    [self tapBgview];
    
    if (self.coverButtonType) {
        self.coverButtonType(CoverViewButtonTypemakeNectarShare,@"");
    }
}

//关闭按钮
- (void)closeButtonClick:(UIButton*)sender
{
    if (self.GlobalCoverVCType == GlobalCoverVCTypeSuperSearch) {
        
         [Utils copyText:@""];
        
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)tapBgview
{
    [self dismissViewControllerAnimated:NO completion:nil];
    
    [Utils copyText:@""];
}
-(void)drawCouponAction{
    
    if (self.coverButtonType) {
        self.coverButtonType(CoverViewButtonTypemakeSuperSearchTB,self.superSearchLabel.text);
    }
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

-(void)searchAction{
    
    if (self.coverButtonType) {
        self.coverButtonType(CoverViewButtonTypemakeSuperSearchTB,self.string);
    }
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
