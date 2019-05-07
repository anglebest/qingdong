//
//  NJRecommendLanguageCell.m
//  Beesgarden
//
//  Created by 张阳 on 2018/5/25.
//  Copyright © 2018年 ningjukeji. All rights reserved.
//

#import "NJRecommendLanguageCell.h"

@interface NJRecommendLanguageCell ()

@property (weak, nonatomic) IBOutlet UILabel *recommendLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UIButton *copBtn;

@end
@implementation NJRecommendLanguageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.titleLab.font = KPFMFont(15);
    
    
    [self.copBtn setTitleColor:kColor(199, 98, 127) forState:0];
    self.copBtn.backgroundColor = kColor(255, 232, 232);
    self.copBtn.layer.cornerRadius= self.copBtn.frame.size.height/2;
    self.copBtn.layer.masksToBounds = YES;
    [self.copBtn setTitle:@" 复制" forState:0];
    self.copBtn.titleLabel.font = KPFFont(12);
    [self.copBtn setImage:[UIImage imageNamed:@"复制"] forState:0];
    self.copBtn.hidden = YES;
    
	self.recommendLabel.userInteractionEnabled = YES;
	[Utils addClickEvent:self action:@selector(showCopy:) owner:self.recommendLabel];
    [Utils addClickEvent:self action:@selector(showCopy:) owner:self.copBtn];
    
//    @weakify(self);
//    [[button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        @strongify(self);
//        [self.delegate sendNext:@(1)];
//    }];
}

- (void)setRecommendString:(NSString *)recommendString
{
    _recommendString = recommendString;
	
    NSMutableAttributedString *priceString = [[NSMutableAttributedString alloc]init];
    [priceString appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@""] attributes:@{NSForegroundColorAttributeName:kColor(51, 51, 51),NSFontAttributeName: KPFFont(12)}]];
    [priceString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",recommendString] attributes:@{NSForegroundColorAttributeName:kColor(51, 51, 51),NSFontAttributeName: KPFFont(12)}]];
//    priceString.lineSpacing = 5*RATIO;
    self.recommendLabel.attributedText = priceString;
    
}

-(BOOL)canBecomeFirstResponder {
	return YES;
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
	
	[Utils copyText:self.recommendString];
	
}

- (void)showCopy:(UIGestureRecognizer *)gesture {
	if ([self isFirstResponder]) {
		[self resignFirstResponder];
		[[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
		return;
	}
	[self becomeFirstResponder];
	
	if (![NSString isNULLString:self.recommendString]) {
		UIMenuItem *menuItem = [[UIMenuItem alloc] initWithTitle:@"复制"
														  action:@selector(copyText)];
		[[UIMenuController sharedMenuController] setMenuItems:@[menuItem]];
		[[UIMenuController sharedMenuController] setTargetRect:self.recommendLabel.bounds inView:self.recommendLabel];
		[[UIMenuController sharedMenuController] update];
		[[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
