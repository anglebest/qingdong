//
//  NJHomeDetailTableViewCell.m
//  Beesgarden
//
//  Created by YR on 2018/4/19.
//  Copyright © 2018年 ningjukeji. All rights reserved.
//

#import "NJHomeDetailTableViewCell.h"

@interface NJHomeDetailTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *titleLbl;

@property (strong, nonatomic) YYLabel *detailLbl;

@property (strong, nonatomic) IBOutlet UILabel *afterPriceLbl;

@property (strong, nonatomic) IBOutlet UILabel *saleCountLbl;
@property (weak, nonatomic) IBOutlet UIImageView *couponImg;

@property (strong, nonatomic) IBOutlet UILabel *quanLbl;

@property (weak, nonatomic) IBOutlet UIButton *couponBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (weak, nonatomic) IBOutlet UILabel *couponNumber;

@property (weak, nonatomic) IBOutlet UIButton *expectedEarnLabel;

@property (weak, nonatomic) IBOutlet UIButton *directorEarnLabel;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLbl;


@end

@implementation NJHomeDetailTableViewCell

- (YYLabel *)detailLbl {
    if (!_detailLbl) {
        _detailLbl = [[YYLabel alloc] init];
        _detailLbl.preferredMaxLayoutWidth = kScreenWidth;
        _detailLbl.numberOfLines = 2;
        _detailLbl.userInteractionEnabled = YES;
        [Utils addClickEvent:self action:@selector(showCopy:) owner:_detailLbl];
    }
    return _detailLbl;
}

- (void)setModel:(YKYHomeModel *)model {
    if (!model) {
        return;
    }
    _model = model;
    // 数据
    self.titleLbl.hidden = YES;
    NSMutableAttributedString *titleString = [NSMutableAttributedString attachmentStringWithContent:[UIImage imageNamed:[NSString stringWithFormat:@"%@",model.itemType]] contentMode:UIViewContentModeScaleAspectFit attachmentSize:CGSizeMake(16.f*RATIO,16.f*RATIO) alignToFont:KPFFont(16) alignment:YYTextVerticalAlignmentCenter];
    [titleString appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@", model.itemTitle] attributes:@{NSFontAttributeName: KPFMFont(16), NSForegroundColorAttributeName: kColor(50, 50, 50)}]];
    
    titleString.lineSpacing = 5*RATIO;
    self.detailLbl.attributedText = titleString;
    
    
    //
    NSMutableAttributedString *priceString = [[NSMutableAttributedString alloc]init];
    [priceString appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"券后￥ "] attributes:@{NSForegroundColorAttributeName:kColor(153, 153, 153),NSFontAttributeName: KPFFont(12)}]];
    
    [priceString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f",model.fanlihoMoney.floatValue] attributes:@{NSForegroundColorAttributeName:kColor(255, 34, 98),NSFontAttributeName: KPFFont(16)}]];
    
    
    NSMutableAttributedString *originalPriceString = [[NSMutableAttributedString alloc]init];
    
    
    [originalPriceString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"原价￥%.2f",model.itemPrice.floatValue] attributes:@{NSForegroundColorAttributeName:kColor(153, 153, 153),NSFontAttributeName: KPFFont(12),NSStrikethroughStyleAttributeName:@(NSUnderlineStyleThick)}]];
    self.originalPriceLbl.attributedText = originalPriceString;
    
//    [priceString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6, 4)];
    
    [priceString addAttribute:NSFontAttributeName value:KDIBFont(24) range:NSMakeRange(4, priceString.length-7)];
    self.afterPriceLbl.attributedText = priceString;
    
    //
    self.saleCountLbl.text = model.itemSale.integerValue > 10000?[NSString stringWithFormat:@"已抢:%.1f万件",model.itemSale.floatValue/10000.0]:model.itemSale.integerValue == 10000?@"1万":[NSString stringWithFormat:@"已抢:%ld件",model.itemSale.integerValue];
    
    //优惠券为零的时候隐藏
    
//    self.quanBtn.titleLabel.text = @"用券抢购";
//    [self.quanBtn setTitle:@"用券抢购" forState:0];
    UIButton *btn =[UIButton new];
//    if (model.coupon.floatValue == 0) {
//        self.quanBtn.hidden = YES;
//        btn.hidden = YES;
//        self.couponImg.hidden = YES;
//        self.quanLbl.hidden = YES;
////        self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width,200);
//    }else {
//        self.quanBtn.hidden = NO;
//        self.quanLbl.hidden = NO;
//        self.couponImg.hidden = NO;
//        btn.hidden = NO;
//    }
    
    
    NSMutableAttributedString *couponString = [[NSMutableAttributedString alloc]init];
    [couponString appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.0f",model.couponMoney.floatValue] attributes:@{NSForegroundColorAttributeName:kColor(255, 255, 255),NSFontAttributeName: KPFFont(26)}]];
    
    [couponString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"元优惠券"] attributes:@{NSForegroundColorAttributeName:kColor(255, 255, 255),NSFontAttributeName: KPFFont(16)}]];
//    self.couponNumber.text = [NSString stringWithFormat:@"%.0f元优惠券",model.couponMoney.floatValue];
    self.couponNumber.attributedText = couponString;
    
    
    self.timeLab.text =[NSString stringWithFormat:@"使用期限%@-%@",[NSString timeStampTransToDate:model.couponStartTime.doubleValue formatter:@"yyyy.mm.dd"],[NSString timeStampTransToDate:model.couponEndTime.doubleValue formatter:@"yyyy.mm.dd"]];
    
    
    [self.expectedEarnLabel setTitle:[NSString stringWithFormat:@" 补贴%@ ",model.fanliMoney] forState:UIControlStateNormal];
//    NSString *commfee = [NSString stringWithFormat:@"%.2f",model.commfee.floatValue];
//    if (![@"0.00" isEqualToString:commfee]) {
//
//        //预计赚
//        self.expectedEarnLabel.hidden = NO;
//        [self.expectedEarnLabel setTitle:[NSString stringWithFormat:@" 分享赚¥%.2f ",model.commfee.floatValue] forState:UIControlStateNormal];
//
//    }else {
//        self.expectedEarnLabel.hidden = YES;
//
//    }

//    NSString *expected = [NSString stringWithFormat:@"%.2f",model.commfee.floatValue];
//    [self.directorEarnLabel setTitle:[NSString stringWithFormat:@" 现在升级VIP，可赚%.2f元                              查看",model.zhuanCommfee.floatValue] forState:UIControlStateNormal];
//    [self.directorEarnLabel addTarget:self action:@selector(earnLabelGesture) forControlEvents:UIControlEventTouchUpInside];
    
//    btn.backgroundColor = [UIColor clearColor];
//    btn.frame = self.quanBtn.frame;
//    [self.contentView addSubview:btn];
    [self.couponBtn addTarget:self action:@selector(enterQuanBtn) forControlEvents:UIControlEventTouchUpInside];

}

-(BOOL)canBecomeFirstResponder {
    return YES;
}
-(void)enterQuanBtn{
    if (self.addToCartsBlock) {
        self.addToCartsBlock();
    }
}
// 可以响应的方法
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if ([NSStringFromSelector(action) isEqualToString:@"copyText"]) {
        return YES;
    }
    return NO;
}

//针对于响应方法的实现
-(void)copyText {
    
    [Utils copyText:self.detailLbl.text];

}

- (void)showCopy:(UIGestureRecognizer *)gesture {
    if ([self isFirstResponder]) {
        [self resignFirstResponder];
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
        return;
    }
    [self becomeFirstResponder];
    
    if (![NSString isNULLString:self.detailLbl.text]) {
        UIMenuItem *menuItem = [[UIMenuItem alloc] initWithTitle:@"复制"
                                                          action:@selector(copyText)];
        [[UIMenuController sharedMenuController] setMenuItems:@[menuItem]];
        [[UIMenuController sharedMenuController] setTargetRect:self.detailLbl.bounds inView:self.detailLbl];
        [[UIMenuController sharedMenuController] update];
        [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.titleLbl.font = kFontLevel5;
//    self.titleLbl.textColor = kTitleColor;
    [self.contentView addSubview:self.detailLbl];
    [self.detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.titleLbl);
    }];
    self.originalPriceLbl.font = KPFFont(12);
//    self.afterPriceLbl.font = kFontLevel5;
    
    self.saleCountLbl.font = KPFFont(12);
    self.saleCountLbl.textColor = kColor(153, 153, 153);
    
    self.quanLbl.font = KPFMFont(24);
    self.quanLbl.textColor = kColor(255, 255, 255);
    
//    [self.quanBtn setBackgroundImage:[[UIImage imageNamed:@"youhuiquan"] stretchableImageWithLeftCapWidth:30.f topCapHeight:0] forState:UIControlStateNormal];
    
    self.quanBtn.titleLabel.font = KPFFont(10);
//    [self.quanBtn setTitleColor:kColor(255, 34, 98) forState:0];
    
//    self.expectedEarnLabel.layer.cornerRadius = 5;
//    self.expectedEarnLabel.layer.masksToBounds = YES;
//    self.expectedEarnLabel.titleLabel.font = KPFFont(12);
    [self.expectedEarnLabel setTitleColor:kColor(199, 98, 127) forState:0];
//    [self drawLinearGradientColor:self.expectedEarnLabel colorType:1];
//    self.expectedEarnLabel.backgroundColor = kColor(255, 242, 242);
    
    self.directorEarnLabel.layer.cornerRadius = 5;
    self.directorEarnLabel.layer.masksToBounds = YES;
    self.directorEarnLabel.backgroundColor = kColor(255, 242, 242);
    [self.directorEarnLabel setTitleColor:kColor(199, 98, 127) forState:0];
//    [self drawLinearGradientColor:self.directorEarnLabel colorType:2];
    
}

- (void)drawLinearGradientColor:(UIButton*)sender colorType:(NSInteger)type {
    UIGraphicsBeginImageContextWithOptions(sender.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //创建CGMutablePathRef
    CGPathRef path = [UIBezierPath bezierPathWithRect:sender.bounds].CGPath;
    //绘制渐变
//    if (type == 1) {
//        [Utils drawLinearGradient:context
//                             path:path
//                       startColor:[UIColor colorWithRGBHex:0xfa4ab2].CGColor
//                         endColor:[UIColor colorWithRGBHex:0xfec366].CGColor];
//    }else if(type == 2){
//        [Utils drawLinearGradient:context
//                             path:path
//                       startColor:[UIColor colorWithRGBHex:0x7b4fd5].CGColor
//                         endColor:[UIColor colorWithRGBHex:0xfda4f8].CGColor];
//    }
    
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [sender setBackgroundImage:backgroundImage forState:UIControlStateNormal];
}

+ (CGFloat)cellHeight {
    return 212;
}
/*
- (void)earnLabelGesture
{
    //判断用户是否登陆
    if([NJUserInfoManager shared].loginState != UserOnlineByLogin) {
        
        NJWXLoginViewController * loginVc = [[NJWXLoginViewController alloc]init];
        GeeBaseNavigationViewController * navi = [[GeeBaseNavigationViewController alloc]initWithRootViewController:loginVc];
        [[self viewController] presentViewController:navi animated:YES completion:nil];
    }else {
        
        if (kUserSystemModelInfo == 1) {
            NJWebPViewController * webViewVc = [[NJWebPViewController alloc]init];
            if ([NJUserInfoManager shared].token.length == 0) {
                webViewVc.urlString = [NSString stringWithFormat:@"%@%@",BASEURL,@"/app/web/study"];
            }else {
                webViewVc.urlString = [NSString stringWithFormat:@"%@%@%@",BASEURL,@"/app/web/study",[NSString stringWithFormat:@"?auth_token=%@",[NJUserInfoManager shared].token]];
            }
            
            webViewVc.titleString = @"我要赚钱";
            [[self viewController].navigationController pushViewController:webViewVc animated:YES];
        }else if (kUserSystemModelInfo == 2){
            if ([@"4" isEqualToString:[NJUserInfoManager shared].userInfo.rolecode]) {
                
                [self pushWebViewController:@"/app/web/cmodeIntroduce?type=type=huiyuan" title:@"我要赚钱"];
            }else if ([@"2" isEqualToString:[NJUserInfoManager shared].userInfo.rolecode]) {
                [self pushWebViewController:@"/app/web/cmodeIntroduce?type=zongjian" title:@"我要赚钱"];
                
            }else if([@"3" isEqualToString:[NJUserInfoManager shared].userInfo.rolecode]){
                [self pushWebViewController:@"/app/web/cmodeIntroduce?type=yunyingzongjian" title:@"我要赚钱"];
            }else {
                [self pushWebViewController:@"/app/web/cmodeIntroduce" title:@"我要赚钱"];
            }
        }
    }
}

- (void)pushWebViewController:(NSString*)urlString title:(NSString*)titleString
{
    NJWebPViewController * webViewVc = [[NJWebPViewController alloc]init];
    
    
    if ([NJUserInfoManager shared].token.length == 0) {
        urlString = urlString;
    }else {
        if ([urlString rangeOfString:@"?"].location == NSNotFound) {
            urlString = [NSString stringWithFormat:@"%@%@",urlString,[NSString stringWithFormat:@"?auth_token=%@",[NJUserInfoManager shared].token]];
        }else {
            urlString = [NSString stringWithFormat:@"%@%@",urlString,[NSString stringWithFormat:@"&auth_token=%@",[NJUserInfoManager shared].token]];
        }
    }
    
    webViewVc.urlString = [NSString stringWithFormat:@"%@%@",BASEURL,urlString];
    
    webViewVc.titleString = titleString;
    [[self viewController].navigationController pushViewController:webViewVc animated:YES];
}
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
