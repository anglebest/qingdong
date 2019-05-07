//
//  YKYHomeTableViewCell.m
//  ShengYa
//
//  Created by 王开政 on 2019/4/11.
//  Copyright © 2019年 Wkz. All rights reserved.
//

#import "YKYHomeTableViewCell.h"
@interface YKYHomeTableViewCell()
// 商品图片
@property (nonatomic, strong) UIImageView *productImgView;


/**
 商品标题
 */
@property (nonatomic, strong) YYLabel *titleLbl;

/**
 已买人数
 */
@property (nonatomic, strong) UILabel *saledLbl;

/**
 券后价
 */
@property (nonatomic, strong) UILabel *priceLbl;


/**
 返利
 */
@property (nonatomic, strong) UIButton *rebateBtn;


/**
 优惠券
 */
@property (nonatomic, strong) UIButton *couponBtn;



@end
@implementation YKYHomeTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setupSubviews];
        
    }
    
    return self;
}
- (void)setModel:(YKYHomeModel *)model {
    _model = model;
    
    [self.productImgView sd_setImageWithURL:[NSURL URLWithString:model.itempictUrl]];
    
//    self.titleLbl.text =model.itemTitle;
    
    
    NSMutableAttributedString *titleString = [NSMutableAttributedString attachmentStringWithContent:[UIImage imageNamed:[NSString stringWithFormat:@"%@",model.itemType]] contentMode:UIViewContentModeScaleAspectFit attachmentSize:CGSizeMake(13*RATIO,13*RATIO) alignToFont:KPFFont(13) alignment:YYTextVerticalAlignmentCenter];
    [titleString appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@", model.itemTitle] attributes:@{NSFontAttributeName: KPFMFont(13), NSForegroundColorAttributeName: kColor(50, 50, 50)}]];
    
    titleString.lineSpacing = 0*RATIO;
    self.titleLbl.attributedText = titleString;
    
    
    [self.couponBtn setTitle:[NSString stringWithFormat:@"券%@",model.couponMoney] forState:0];
    
    
    
    self.saledLbl.text =[NSString stringWithFormat:@"已抢%@件",model.itemSale];
    
    NSMutableAttributedString *priceString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥ %@",model.fanlihoMoney]];
    NSArray *array = [model.fanlihoMoney componentsSeparatedByString:@"."];
    NSString *str = array[0];
    [priceString addAttribute:NSFontAttributeName value:KFont(21) range:NSMakeRange(2,str.length)];
    
    NSString *itemPriceStr = [NSString stringWithFormat:@"  ¥ %@",model.itemPrice];
    NSMutableAttributedString *cpriceString = [[NSMutableAttributedString alloc]initWithString:itemPriceStr];
    [cpriceString addAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor]} range:NSMakeRange(0, itemPriceStr.length)];
    [cpriceString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(2, itemPriceStr.length-2)];
    [cpriceString addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(2, itemPriceStr.length-2)];
    
    
    [priceString appendAttributedString:cpriceString];
    
    self.priceLbl.attributedText = priceString;
    
    
    [self.rebateBtn setTitle:[NSString stringWithFormat:@" 补贴%@   ",model.fanliMoney] forState:0];
    
    
}
- (void)setupSubviews {
    UIView *shadowView = [UIView new];
    [self.contentView addSubview:shadowView];
    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    shadowView.clipsToBounds = NO;
    self.clipsToBounds = NO;
    self.contentView.clipsToBounds = NO;
    shadowView.layer.shadowColor = [UIColor colorWithRed:103.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:0.15f].CGColor;
    shadowView.layer.shadowOpacity = 1;
    shadowView.layer.shadowOffset = CGSizeMake(0, 2);
    shadowView.layer.shadowRadius = 3;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, [[self classForCoder] cellSize].width, [[self classForCoder] cellSize].height) cornerRadius:5.f];
    shadowView.layer.shadowPath = shadowPath.CGPath;
    
    UIView *cornerView = [UIView new];
    cornerView.backgroundColor = [UIColor whiteColor];
    cornerView.clipsToBounds = YES;
    cornerView.layer.cornerRadius = 5.f;
    [shadowView addSubview:cornerView];
    [cornerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(shadowView);
    }];
    
    UIImageView *productImgView = [UIImageView new];
    productImgView.contentMode = UIViewContentModeScaleAspectFill;
    productImgView.clipsToBounds = YES;
    productImgView.layer.cornerRadius = 5.f;
//    productImgView.backgroundColor = [UIColor redColor];
    [cornerView addSubview:productImgView];
    [productImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(cornerView).mas_offset(15*RATIO);
        make.top.equalTo(cornerView).mas_offset(18*RATIO);
        make.height.width.mas_equalTo(140*RATIO);
    }];
    self.productImgView = productImgView;
    
  
    
 
    
    YYLabel *titleLbl = [YYLabel new];
    titleLbl.numberOfLines = 2;
    titleLbl.preferredMaxLayoutWidth = [[self classForCoder] cellSize].width - 10.f*RATIO;
    titleLbl.font = KPFFont(14);
    titleLbl.textColor = kColor(72, 72, 72);
    titleLbl.text = @"荣事达落地扇静音摇头荣事达静音摇头荣事达...";
    [cornerView addSubview:titleLbl];
    self.titleLbl = titleLbl;
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cornerView).mas_offset(171*RATIO);
        make.right.equalTo(cornerView).mas_offset(-15.f*RATIO);
        make.top.equalTo(productImgView);
        make.height.mas_equalTo(40*RATIO);
    }];
    
    
    // 券后价
    UILabel *priceLbl = [UILabel new];
    priceLbl.font = KPFFont(12);
    priceLbl.textColor = kColor(251, 81, 3);
    priceLbl.text = @"¥:65.5";
    [cornerView addSubview:priceLbl];
    self.priceLbl = priceLbl;
    [priceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLbl);
        make.height.mas_equalTo(20.f*RATIO);
        make.bottom.equalTo(cornerView).mas_offset(-20*RATIO);
    }];
    
    
  
    // 已买人数
    UILabel *saledLbl = [UILabel new];
    saledLbl.textColor = kColor(149, 149, 149);
    saledLbl.font = KPFMFont(10);
    saledLbl.text =  @"已抢2.35万件";
    [cornerView addSubview:saledLbl];
    self.saledLbl = saledLbl;
    [saledLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cornerView).mas_offset(-15);
        make.height.mas_equalTo(14.f * RATIO);
        make.top.equalTo(priceLbl);
    }];
    
   
    
//    // 已买人数
//    UILabel *lab = [UILabel new];
//    lab.textColor = kColor(149, 149, 149);
//    lab.font = KPFMFont(12);
//    lab.text =  @"收货后";
//    [cornerView addSubview:lab];
//    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(titleLbl);
//        make.height.mas_equalTo(14.f * RATIO);
//        make.top.equalTo(priceLbl.mas_bottom).mas_offset(10*RATIO);
//    }];
    
    UIButton *couponBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    couponBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [couponBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    couponBtn.titleLabel.font = KPFMFont(10);
    couponBtn.backgroundColor =kColor(255, 98, 27);
    [couponBtn setTitle:@"券60" forState:0];
    couponBtn.layer.masksToBounds = YES;
    couponBtn.layer.cornerRadius = 4;

    [cornerView addSubview:couponBtn];
    self.couponBtn = couponBtn;
    [couponBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLbl);
        make.height.mas_equalTo(16*RATIO);
//        make.width.mas_equalTo(62.f*RATIO);
        make.bottom.equalTo(cornerView.mas_bottom).mas_offset(-47.f * RATIO);
    }];
    
    
    UIButton *rebateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rebateBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [rebateBtn setTitleColor:kColor(255, 83, 1) forState:UIControlStateNormal];
    rebateBtn.titleLabel.font = KPFMFont(10);
    rebateBtn.layer.masksToBounds = YES;
    rebateBtn.layer.cornerRadius = 4;
    rebateBtn.layer.borderWidth = 1;
    rebateBtn.layer.borderColor =kColor(255, 83, 1).CGColor;
    
    rebateBtn.backgroundColor = kColor(254, 234, 225);
    
//    [rebateBtn setBackgroundImage:[[UIImage imageNamed:@"返利背景"]];
    [cornerView addSubview:rebateBtn];
    self.rebateBtn = rebateBtn;
    [rebateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(couponBtn.mas_right).mas_offset(5 * RATIO);
        make.height.mas_equalTo(16*RATIO);
//        make.width.mas_equalTo(62.f*RATIO);
        make.bottom.equalTo(couponBtn);
    }];
}
+ (CGSize)cellSize {
    
   
    return CGSizeMake(kScreenWidth, 160*RATIO);
}

@end
