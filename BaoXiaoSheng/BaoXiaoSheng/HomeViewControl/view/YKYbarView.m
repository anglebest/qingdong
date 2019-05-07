//
//  YKYbarView.m
//  ShengYa
//
//  Created by 王开政 on 2019/4/12.
//  Copyright © 2019年 Wkz. All rights reserved.
//

#import "YKYbarView.h"
@interface YKYbarView()

@property (nonatomic, strong) NSMutableArray<UIButton *> *buttons;

@property (nonatomic, strong) NSMutableArray<UILabel *> *labels;

@property (nonatomic, strong) UILabel *line;

@end
@implementation YKYbarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        self.line = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 26.f, 13.f)];
        self.
        self.line.layer.cornerRadius = 6;
        self.line.layer.masksToBounds = YES;
        self.line.alpha = 0;
        //        self.line.backgroundColor = UIColorFromRGB0X(0xff
        self.line.backgroundColor = [UIColor clearColor];
        [self addSubview:self.line];
        //        self.generalColor = kNormalColor;
        //        self.selectedColor = kTheme1Color;
        self.becomeBigger = NO;
    }
    return self;
}

- (instancetype)init {
    if (self=[super init]) {
        self.line = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 26.f, 3.f)];
        self.line.layer.cornerRadius = 6;
        self.line.layer.masksToBounds = YES;
        self.line.backgroundColor = [UIColor clearColor];
        self.line.alpha = 0;
        [self addSubview:self.line];
        //        self.generalColor = kNormalColor;
        //        self.selectedColor = kTheme1Color;
        self.becomeBigger = NO;
    }
    return self;
}

- (void)setSelectedIdx:(NSInteger)selectedIdx {
    [self.buttons[self.selectedIdx] setTitleColor:self.generalColor forState:UIControlStateNormal];
    self.buttons[self.selectedIdx].titleLabel.font = KFont(15*RATIO);
    _selectedIdx = selectedIdx;
    UIButton *x = self.buttons[selectedIdx];
    if (self.becomeBigger) {
        x.titleLabel.font = KFont(15*RATIO);
        x.layer.masksToBounds = YES;
    }
    for (UILabel * b in self.labels) {
        b.textColor = kColor(153, 153, 153);
        
        if (b.tag == x.tag) {
            b.textColor = [UIColor whiteColor];
        }
    }
    [x setTitleColor:self.selectedColor forState:UIControlStateNormal];
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        //                [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
        //                    line.left = idx < self.selectedIdx?(x.centerX - line.width/2.f):line.left;
        //                    line.width = width + line.width + space;
        //                }];
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
            if (x.centerX > self.width/2.f) {
                if (x.centerX >= self.contentSize.width - self.width/2.f) {
                    [self setContentOffset:CGPointMake(self.contentSize.width - self.width, self.contentOffset.y)  animated:YES];
                } else {
                    [self setContentOffset:CGPointMake(x.centerX - self.width/2.f, self.contentOffset.y) animated:YES];
                }
            } else if ((x.centerX <= self.width/2.f)) {
                [self setContentOffset:CGPointMake(0, self.contentOffset.y) animated:YES];
            }
            self.line.width = x.width-20;
            self.line.centerX = x.centerX;
            x.layer.cornerRadius =  x.height/2;
            x.backgroundColor = kColor(245, 245, 245);
            
        }];
    } completion:^(BOOL finished) {
        
    }];
}

- (NSMutableArray<UIButton *> *)buttons {
    if (!_buttons) {
        _buttons = [[NSMutableArray alloc] init];
    }
    return _buttons;
}

- (NSMutableArray<UILabel *> *)labels {
    if (!_labels) {
        _labels = [[NSMutableArray alloc] init];
    }
    return _labels;
}


- (void)setTitles:(NSArray<NSString *> *)titles {
    if (!titles || (NSInteger)titles.count <= 0 || _titles == titles) {
        return;
    }
    self.line.alpha = 1.f;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    [self.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    _titles = titles;
    // 添加下划线
    CGFloat top = 10.f;
    CGFloat height = 24;
    [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:obj forState:UIControlStateNormal];
        button.titleLabel.font = KFont(12*RATIO);
        [button setTitleColor:kColor(51, 51, 51) forState:UIControlStateNormal];
        if (idx == self.selectedIdx) {
            if (self.becomeBigger) {
                button.titleLabel.font = KFont(15*RATIO);
            }
            [button setTitleColor:self.selectedColor forState:UIControlStateNormal];
        }
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius =  height/2;
        button.backgroundColor = kColor(245, 245, 245);
        [self addSubview:button];
        
        
        CGRect rect = [button.titleLabel textRectForBounds:[UIScreen mainScreen].bounds limitedToNumberOfLines:1];
        button.frame = CGRectMake(self.buttons.lastObject.right + 15, top, rect.size.width + 40.f, height);
        button.tag = idx;
        
        
        
        
        //小竖线
        /*
        UIView *verticalLine = [UIView new];
        verticalLine.backgroundColor = kColor(232, 232, 232);
        [self addSubview:verticalLine];
        //        [self bringSubviewToFront:lab];
        
        [verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.equalTo(button.mas_right) ;
            make.height.mas_equalTo(38);
            make.width.mas_equalTo(1);
            //            make.bottom.equalTo(hCell);
        }];
         */
        //小标题
        /*
        UILabel *lab = [UILabel new];
        lab.backgroundColor = [UIColor clearColor];
        [self addSubview:lab];
        lab.tag = idx;
        lab.font = KFont(12*RATIO);
        if (idx == 0) {
            lab.textColor = [UIColor whiteColor];
        }else{
            lab.textColor = kColor(153, 153, 153);
        }
        
        lab.text = self.descs[idx];
        lab.textAlignment = NSTextAlignmentCenter;
        
        [self bringSubviewToFront:lab];
        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(button);
            make.top.equalTo(button.mas_bottom) ;
            make.height.mas_equalTo(14);
            //            make.bottom.equalTo(hCell);
        }];
         */
        @weakify(self);
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (self.selectedIdx == idx) {
//                return;
            }
            [self selectButton:x];
        }];
        [self.buttons addObject:button];
        
//        [self.labels addObject:lab];
    }];
    self.contentSize = CGSizeMake(self.buttons.lastObject.right, self.frame.size.height);
    self.line.width = self.buttons[self.selectedIdx].width-20;
    self.line.centerX = self.buttons[self.selectedIdx].centerX;
    self.line.mj_y = self.buttons[self.selectedIdx].centerY * 2-10;
    //    [self bringSubviewToFront:self.line];
    
    
}

- (void)selectButton:(UIButton *)x {
    NSInteger idx = x.tag;
    
    for (UIButton * b in self.buttons) {
        [b setTitleColor:self.generalColor forState:UIControlStateNormal];
    }
    for (UILabel * b in self.labels) {
        b.textColor = kColor(153, 153, 153);
        
        if (b.tag == x.tag) {
            b.textColor = [UIColor whiteColor];
        }
    }
    //    [self.buttons[self.selectedIdx] setTitleColor:kColor(159, 112, 37) forState:UIControlStateNormal];
    self.buttons[self.selectedIdx].titleLabel.font = KFont(15*RATIO);
    if (self.becomeBigger) {
        x.titleLabel.font = KFont(15*RATIO);
        //        [x setTitleColor:self.generalColor forState:UIControlStateNormal];
    }
    [x setTitleColor:self.selectedColor forState:UIControlStateNormal];
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        //                [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
        //                    line.left = idx < self.selectedIdx?(x.centerX - line.width/2.f):line.left;
        //                    line.width = width + line.width + space;
        //                }];
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
            if (x.centerX > self.width/2.f) {
                if (x.centerX >= self.contentSize.width - self.width/2.f) {
                    [self setContentOffset:CGPointMake(self.contentSize.width - self.width, self.contentOffset.y)  animated:YES];
                } else {
                    [self setContentOffset:CGPointMake(x.centerX - self.width/2.f, self.contentOffset.y) animated:YES];
                }
            } else if ((x.centerX <= self.width/2.f)) {
                [self setContentOffset:CGPointMake(0, self.contentOffset.y) animated:YES];
            }
            self.line.width = x.width-20;
            self.line.centerX = x.centerX;
        }];
    } completion:^(BOOL finished) {
        
    }];
    _selectedIdx = idx;
    if ([self.njDelegate respondsToSelector:@selector(didSelect:)]) {
        [self.njDelegate didSelect:idx];
    }
}

@end
