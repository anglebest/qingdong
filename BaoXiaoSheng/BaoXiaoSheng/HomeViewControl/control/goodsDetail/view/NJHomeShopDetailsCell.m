//
//  NJHomeShopDetailsCell.m
//  Beesgarden
//
//  Created by 张阳 on 2018/5/25.
//  Copyright © 2018年 ningjukeji. All rights reserved.
//

#import "NJHomeShopDetailsCell.h"
@interface NJHomeShopDetailsCell ()
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *describeLabelOne;
@property (weak, nonatomic) IBOutlet UILabel *describeLabelTow;
@property (weak, nonatomic) IBOutlet UILabel *describeLabelThree;
@property (weak, nonatomic) IBOutlet UIButton *enterShop;

@end
@implementation NJHomeShopDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.enterShop setTitleColor:kColor(51, 51, 51) forState:0];
//    self.enterShop.backgroundColor = kColor(255, 232, 232);
    self.enterShop.layer.masksToBounds = YES;
    [self.enterShop setTitle:@"进入店铺  " forState:0];
    self.enterShop.titleLabel.font = KPFFont(12);
    
    self.describeLabelOne.font = KPFFont(12);
    self.describeLabelOne.textColor = kColor(153, 153, 153);
    
    self.describeLabelTow.font = KPFFont(12);
    self.describeLabelTow.textColor = kColor(153, 153, 153);
    
    self.describeLabelThree.font = KPFFont(12);
    self.describeLabelThree.textColor = kColor(153, 153, 153);
    [self.enterShop setImage:[UIImage imageNamed:@"箭头"] forState:0];
    
    [self.enterShop setTitleEdgeInsets:UIEdgeInsetsMake(0,-self.enterShop.imageView.size.width, 0, self.enterShop.imageView.size.width)];
    
    [self.enterShop setImageEdgeInsets:UIEdgeInsetsMake(0, self.enterShop.titleLabel.bounds.size.width, 0, -self.enterShop.titleLabel.bounds.size.width)];
}

- (void)addStrePinJiaDic:(NSDictionary*)dic
{
    if (dic == nil) {
        self.shopNameLabel.text = @"";
        self.describeLabelOne.text = @"";
        self.describeLabelTow.text = @"";
        self.describeLabelThree.text = @"";
        self.enterShop.hidden = YES;
        return;
    }
    
   
    
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:[NSString PlatformTypeShop:self.shop.integerValue]];
    // 设置图片大小
    attch.bounds = CGRectMake(0, -7, 24, 24);
    
    // 创建带有图片的富文本
    NSMutableAttributedString *string = [NSMutableAttributedString attributedStringWithAttachment:attch];
//     [string appendString:[NSString stringWithFormat:@"%@",dic[@"storeName"]]];

     [string appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"   %@",dic[@"storeName"]] attributes:@{NSFontAttributeName: KPFMFont(15), NSForegroundColorAttributeName: kColor(51, 51, 51)}]];
    
    // 用label的attributedText属性来使用富文本
    self.shopNameLabel.attributedText = string ;
    self.describeLabelOne.text = [NSString stringWithFormat:@"%@",dic[@"baobei"]];
    self.describeLabelTow.text = [NSString stringWithFormat:@"%@",dic[@"maijia"]];
    self.describeLabelThree.text = [NSString stringWithFormat:@"%@",dic[@"wuliu"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
