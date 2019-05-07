//
//  NJNectarTableViewCell.m
//  Beesgarden
//
//  Created by YR on 2018/4/21.
//  Copyright © 2018年 ningjukeji. All rights reserved.
//

#import "NJNectarTableViewCell.h"
//#import "GeeNectarModel.h"
// 响应式开发
#import <ReactiveObjC/ReactiveObjC.h>
//#import "UIColor+NJUniteColor.h"

@interface NJNectarTableViewCell ()

@property (strong, nonatomic) UIButton *bottomBtn;

@property (strong, nonatomic) IBOutlet UIImageView *headerImgView;

@property (strong, nonatomic) IBOutlet UILabel *nickNameLbl;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *shareCountLabel;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIView *bootmView;
@property (weak, nonatomic) IBOutlet UIButton *btnCopy;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UILabel *feebl;
@property (weak, nonatomic) IBOutlet UIButton *firstButton;

@property (weak, nonatomic) IBOutlet UIButton *secondButton;

@property (weak, nonatomic) IBOutlet UIButton *thirdButton;

@property (weak, nonatomic) IBOutlet UIButton *fourthButton;

@property (weak, nonatomic) IBOutlet UIButton *fifthButton;

@property (weak, nonatomic) IBOutlet UIButton *sixthButton;

@property (weak, nonatomic) IBOutlet UIButton *seventhButton;

@property (weak, nonatomic) IBOutlet UIButton *eighthButton;

@property (weak, nonatomic) IBOutlet UIButton *ninthButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *boomViewOffcontranist;

@property (copy, nonatomic) NSArray<UIButton *> *buttons;

@end

@implementation NJNectarTableViewCell

- (void)setModel:(GeeNectarModel *)model {
	if (!model) {
		return;
	}
    self.bgView.layer.cornerRadius = 10;
    self.bgView.clipsToBounds = YES;
    self.bootmView.backgroundColor = kColor(255, 255, 255);
    self.bootmView.layer.cornerRadius = 10;
    self.bootmView.clipsToBounds = YES;
    
    [self.shareButton setBackgroundColor:kColor(249, 111, 20)];
    [self.shareButton setTitleColor:kColor(255, 255, 255) forState:UIControlStateNormal];

    self.shareButton.layer.cornerRadius = 13;
    self.shareButton.clipsToBounds = YES;
//    [self.feebl setTextColor:[UIColor format_colorWithHex:0xC7627F Withalpha:1]];
    
//    [self.btnCopy setBackgroundColor:[UIColor format_colorWithHex:0xFFE8E8 Withalpha:1]];
//    [self.btnCopy setTitleColor:[UIColor format_colorWithHex:0xC7627F Withalpha:1] forState:UIControlStateNormal];
    self.btnCopy.layer.cornerRadius = 13;
    self.btnCopy.clipsToBounds = YES;
	_model = model;
    /*
    if (model.commfee.integerValue == 0){
        self.feebl.hidden = YES;
    } else {
         self.feebl.text = model.commfee.floatValue >= 1000.f?[NSString stringWithFormat:@"赚￥%.2fk",model.commfee.floatValue/1000.f]:[NSString stringWithFormat:@"赚￥%.2f",model.commfee.floatValue];
        self.feebl.hidden = NO;
    }
   
	[self.headerImgView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:nil];
	[Utils addClickEvent:self action:@selector(clickHeaderImageView) owner:self.headerImgView];
	self.nickNameLbl.text = model.nickname;

    self.timeLabel.text = [NSString stringWithTimeString:[model.createtime doubleValue]];
	self.contentLbl.text = model.text;
    
    self.shareCountLabel.text = [NSString stringWithFormat:@"已分享%@次",model.shareCount];
    
    if (model.images.count <= 0) {
        if (self.bottomBtn) {
            [self.bottomBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                
            }];
        }
        [self.contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).mas_offset(kWidth(-100.f));
        }];
    }
   else if (model.images.count == 1) {
        if (self.contentLbl) {
            [self.contentLbl mas_remakeConstraints:^(MASConstraintMaker *make) {

            }];
        }
        [self.firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).mas_offset(kWidth(-130.f));
        }];
        

    }
    else if (model.images.count == 2){
        if (self.contentLbl) {
            [self.contentLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
                
            }];
        }
        [self.secondButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).mas_offset(kWidth(-130.f));
        }];
    } else if (model.images.count <= 6 && model.images.count > 3 ) {
        if (self.contentLbl) {
            [self.contentLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
                
            }];
        }
        [self.fourthButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).mas_offset(kWidth(-130.f));
        }];
        self.boomViewOffcontranist.constant = 130;
        
    }
    else if (model.images.count > 6){
        if (self.bottomBtn) {
            [self.bottomBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                
            }];
        } else {
            [self.contentLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
                
            }];
        }
        self.bottomBtn = self.seventhButton;
        [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).mas_offset(kWidth(-120.f));
        }];
        self.boomViewOffcontranist.constant = 245;
       
    }
    

    for (UIButton* button in self.buttons) {
        button.alpha = 0;
        for (id label in button.subviews) {
            if ([label isKindOfClass:[UILabel class]]) {
            
                ((UILabel*)label).hidden = YES;
            }
        }
    }
    
    [self.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.clipsToBounds = YES;
        obj.layer.borderColor = kNectarImageBorderColor.CGColor;
        obj.layer.borderWidth = 0.5;
        if (idx >= model.images.count) {
            if (idx > 0) {
                if (self.bottomBtn) {
                    [self.bottomBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                    }];
                } else {
                    [self.contentLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                    }];
                }
                self.bottomBtn = self.buttons[idx - 1];
                [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.contentView.mas_bottom).offset(kWidth(-30));
                }];
            }
            
            
            *stop = YES;
        } else {
            obj.alpha = 1;
			[obj sd_setImageWithURL:[NSURL URLWithString:model.images[idx].image] forState:UIControlStateNormal placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
				if (error) {
					NSLog(@"duanduan%@\n%@", imageURL, error.localizedDescription);
				}
			}];
            if (model.isOpenDetail) {
                for (id label in obj.subviews) {
                    if ([label isKindOfClass:[UILabel class]] && model.images[idx].type.integerValue == 1) {
                        if(((UILabel *)label).tag == 100){
                            
                            if (model.images[idx].invalid.integerValue == 1){
                                ((UILabel*)label).hidden = YES;
                               
                            }else {
                                ((UILabel*)label).hidden = NO;
                                ((UILabel*)label).text = [NSString stringWithFormat:@"购买¥%.1f",model.images[idx].priceAfterCoupons.floatValue];
                            }
                        }else if(model.images[idx].invalid.integerValue == 1){
                            ((UILabel*)label).hidden = NO;
                            
                        }
                    }
                }
            }
        }
    }];
    
//    [self.shareButton setTitleColor:kNormalColor forState:UIControlStateNormal];
    [self.shareButton setTitle:@"分享" forState:UIControlStateNormal];
	CGRect rect = [self.shareButton.titleLabel textRectForBounds:CGRectMake(0, 0, kScreenWidth/2.f, 24.f) limitedToNumberOfLines:1];
	if (rect.size.width + 12.f <= 74.f) {
		[self.shareButton mas_updateConstraints:^(MASConstraintMaker *make) {
			make.width.mas_equalTo(74.f);
		}];
	} else {
		[self.shareButton mas_updateConstraints:^(MASConstraintMaker *make) {
			make.width.mas_equalTo(rect.size.width + 12.f);
		}];
	}

    self.shareButton.hidden = NO;
*/
}

/**
 点击头像
 */
- (void)clickHeaderImageView {
	if ([self.delegate respondsToSelector:@selector(personCenter:)]) {
//        [self.delegate personCenter:self.model.uid];
	}
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
	NSMutableArray *buttons = [NSMutableArray array];
	[buttons addObject:self.firstButton];
	[buttons addObject:self.secondButton];
	[buttons addObject:self.thirdButton];
	[buttons addObject:self.fourthButton];
	[buttons addObject:self.fifthButton];
	[buttons addObject:self.sixthButton];
    [buttons addObject:self.seventhButton];
    [buttons addObject:self.eighthButton];
    [buttons addObject:self.ninthButton];
    
    
	self.buttons = buttons;
    [self.contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).mas_offset(kWidth(-30.f));
    }];
    
    
	@weakify(self)
	[self.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.imageView.contentMode = UIViewContentModeScaleAspectFill;
        obj.imageView.clipsToBounds = YES;
        
        //价格
        UILabel * pirceLabel = [[UILabel alloc]init];
        pirceLabel.text = @"";
        pirceLabel.font = KPFFont(10);
        pirceLabel.tag = 100;
        pirceLabel.textAlignment = NSTextAlignmentCenter;
        pirceLabel.textColor = [UIColor whiteColor];
        pirceLabel.layer.cornerRadius = 5;
        pirceLabel.layer.masksToBounds = YES;
        [obj addSubview:pirceLabel];
        [pirceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(obj.mas_bottom).mas_offset(kWidth(-15.f));
            make.right.equalTo(obj.mas_right);
            make.height.equalTo(@(kWidth(20)));
            make.width.equalTo(@(kWidth(72)));
        }];
//        [pirceLabel setBackgroundColor:[UIColor format_colorWithHex:0xFF6491 Withalpha:1]];
        
        [obj layoutIfNeeded];
        //过期图片
        UILabel *failureLabel = [[UILabel alloc]init];
        failureLabel.text = @"已抢完";
        failureLabel.font = KFont(25);
        failureLabel.tag = 101;
        failureLabel.textAlignment = NSTextAlignmentCenter;
        failureLabel.textColor = [UIColor whiteColor];
        failureLabel.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.5];
        failureLabel.layer.cornerRadius = obj.height/2;
        failureLabel.layer.masksToBounds = YES;

        [obj addSubview:failureLabel];
        [failureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(obj);
        }];
        
		[[obj rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
			@strongify(self);
			if ([self.delegate respondsToSelector:@selector(preview:index:imageArray:superView:)]) {
                [self.delegate preview:self.model index:idx imageArray:self.buttons superView:self.contentView];
			}
		}];
	}];
	
    
	self.headerImgView.clipsToBounds = YES;
	self.headerImgView.layer.cornerRadius = 20.f;
//    [self.shareButton setTitleColor:kNormalColor forState:UIControlStateNormal];
	[[self.shareButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
		@strongify(self);
        
		if ([self.delegate respondsToSelector:@selector(share:)]) {
			[self.delegate share:self.model];
		}
	}];
    [[self.btnCopy rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        if ([self.delegate respondsToSelector:@selector(copyData:)]) {
            [self.delegate copyData:self.model];
        }
    }];
	[self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.mas_equalTo(74.f);
	}];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
