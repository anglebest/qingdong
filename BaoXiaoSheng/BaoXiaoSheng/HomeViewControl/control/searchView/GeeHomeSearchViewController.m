//
//  NJHomeSearchViewController.m
//  Beesgarden
//
//  Created by YR on 2018/4/18.
//  Copyright © 2018年 ningjukeji. All rights reserved.
//

#import "GeeHomeSearchViewController.h"

#import "YKYGoodsListViewController.h"

//#import "LrdOutputView.h"
//#import "GeeHomeDetailViewController.h"
//#import "GeeHomeQiangModel.h"
//#import "GeeHomeSearchResultViewController.h"
// 响应式开发
#import <ReactiveObjC/ReactiveObjC.h>

#import "YKYUserInfor.h"
//#import "Beesgarden-Swift.h"

@interface GeeHomeSearchViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) NSArray<NSDictionary *> *hotTips;

@property (nonatomic, strong) UITextField *searchTf;

//@property (nonatomic, strong) UIButton *typeBtn;

@property (nonatomic, strong) UIButton *searchBtn;

//@property (nonatomic, strong) NSArray<NSString *> *types;

@property (nonatomic, strong) UIView *backHotTipView;

@property (nonatomic, strong) UIView *backHistoryTipView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIScrollView *superBgView;

@property (nonatomic, copy) NSString *shop;

/**
 标签刷新任务
 */
@property (nonatomic, strong) NSURLSessionDataTask *refreshTipTask;

@property (nonatomic, strong) UIView * topSearchView;

@property (nonatomic, strong) UIButton * normalButton;

@property (nonatomic, strong) UIButton * superButton;

@property (nonatomic, strong) UIView *instructionsView;

@property (nonatomic,strong) UITableView * picsTabelView;

@property (nonatomic, strong) NSMutableArray<NSNumber *> *cellHeights;

@property (nonatomic, strong) NSArray<NSString *> *imagePaths;

@end

@implementation GeeHomeSearchViewController

@synthesize typeArray = _typeArray;

#pragma mark - 懒加载

- (NSArray<NSString *> *)typeArray {
    if (!_typeArray) {
        NSMutableArray *array = [NSMutableArray array];
//        [[[NJUserInfoManager shared] homeModuleType] enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if (obj[@"name"]) {
//                [array addObject:obj[@"name"]];
//            } else if (obj[@"shoptext"]) {
//                [array addObject:obj[@"shoptext"]];
//            }
//        }];
        _typeArray = array;
    }
    return _typeArray;
}

- (UIButton *)backBtn {
	if (!_backBtn) {
		_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		[_backBtn setImage:[UIImage imageNamed:@"搜索页面-返回"] forState:UIControlStateNormal];
	}
	return _backBtn;
}

//- (UIView *)topSearchView
//{
//    if (!_topSearchView) {
//        _topSearchView = [[UIView alloc]init];
//        _topSearchView.backgroundColor = [UIColor redColor];
//        NSArray * searchArray = @[@"蜜蜂搜",@"超级搜"];
//        NSInteger i = 0;
//        for (NSString * title in searchArray) {
//            UIButton * button = [[UIButton alloc]init];
//            [button setTitle:title forState:UIControlStateNormal];
//            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//
//            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//            [_topSearchView addSubview:button];
//            [button mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.equalTo(self->_topSearchView.mas_centerY);
//                make.centerX.equalTo(self->_topSearchView.mas_centerX).offset(i == 0?-kScreenWidth/4:kScreenWidth/4);
//
//            }];
//
//            if (i == 0) {
//                button.selected = YES;
//                button.titleLabel.font = KBoldFont(16);
//                self.normalButton = button;
//            }else if (i == 1) {
//                button.selected = NO;
//                button.titleLabel.font = KFont(16);
//                self.superButton = button;
//            }
//            i ++;
//
//        }
//
//
//        UIView * lineView = [[UIView alloc]init];
//        lineView.backgroundColor = [UIColor clearColor];
//        [_topSearchView addSubview:lineView];
//        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self->_topSearchView.mas_left);
//            make.right.equalTo(self->_topSearchView.mas_right);
//            make.bottom.equalTo(self->_topSearchView.mas_bottom);
//            make.height.equalTo(@(kWidth(1)));
//        }];
//
//        UIView *instructionsView = [[UIView alloc]init];
//        instructionsView.backgroundColor = kTheme1Color;
//        self.instructionsView = instructionsView;
//        [_topSearchView addSubview:instructionsView];
//        [instructionsView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self->_topSearchView.mas_centerX).offset(-kScreenWidth/4);
//            make.bottom.equalTo(lineView.mas_top);
//            make.height.equalTo(@(2));
//            make.width.equalTo(@(kWidth(60)));
//        }];
//    }
//    return _topSearchView;
//}

- (UITextField *)searchTf {
	if (!_searchTf) {
		_searchTf = [[UITextField alloc] init];
		_searchTf.layer.cornerRadius = 15;
		_searchTf.clipsToBounds = YES;
		_searchTf.font = KPFFont(13);
		_searchTf.delegate = self;
		_searchTf.backgroundColor = kColor(245, 245, 245);
		NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]init];
		NSAttributedString *attachment = [NSAttributedString attachmentStringWithContent:[UIImage imageNamed:@"搜索灰"] contentMode:UIViewContentModeScaleAspectFit attachmentSize:CGSizeMake(13.f, 13.f) alignToFont:KFont(13) alignment:YYTextVerticalAlignmentCenter];
		[attributedString appendAttributedString:attachment];
		[attributedString appendAttributedString:[[NSAttributedString alloc]initWithString:@"粘贴宝贝标题  先领券再购物" attributes:@{NSForegroundColorAttributeName:kColor(153, 153, 153), NSFontAttributeName: KFont(13),NSBaselineOffsetAttributeName:@(-1.f)}]];
        _searchTf.attributedPlaceholder = attributedString;
        
        _searchTf.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"搜索灰"]];
        
        
        //文本框左视图
        UIView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
        leftView.backgroundColor = [UIColor clearColor];
        img.frame = CGRectMake(14, 10, 15, 15);
        
        [leftView addSubview:img];
        
        _searchTf.leftView = leftView;
//        _searchTf.textAlignment = NSTextAlignmentLeft;
        
//        _searchTf.leftView = self.typeBtn;
//        _searchTf.rightViewMode = UITextFieldViewModeAlways;
        
         _searchTf.clearButtonMode = UITextFieldViewModeAlways;
//        _searchTf.rightView = self.searchBtn;
		_searchTf.returnKeyType = UIReturnKeySearch;
        
        
        //设置左边视图的宽度(占位)
//        _searchTf.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//        //设置显示模式为永远显示(默认不显示 必须设置 否则没有效果)
//        _searchTf.leftViewMode = UITextFieldViewModeAlways;
	}
	return _searchTf;
}

//- (UIButton *)typeBtn {
//    if (!_typeBtn) {
//        _typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _typeBtn.frame = CGRectMake(0, 0, 60.f, 30.f);
//        _typeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -33.f, 0, 0);
//        _typeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 37.f, 0, 0);
//        _typeBtn.contentMode = UIViewContentModeScaleAspectFit;
//        _typeBtn.titleLabel.font = kFontLevel3;
//        [_typeBtn setTitleColor:kTheme2Color forState:UIControlStateNormal];
//        [_typeBtn setTitleColor:kTheme2Color forState:UIControlStateHighlighted];
//        [_typeBtn setImage:[[UIImage imageNamed:@"home_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
//        [_typeBtn setImage:[[UIImage imageNamed:@"home_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateHighlighted];
//        _typeBtn.imageView.tintColor = kTheme2Color;
//        if (self.types[0].length >= 3) {
//            _typeBtn.titleLabel.font = kFontLevel5;
//        }else {
//            _typeBtn.titleLabel.font = kFontLevel3;
//        }
//        [_typeBtn setTitle:self.types[0] forState:UIControlStateNormal];
//        UIView *VLine = [[UIView alloc]initWithFrame:CGRectMake(60.f, 5.f, 0.5f, 20.f)];
//        VLine.backgroundColor = kSearchVLineColor;
//        [_typeBtn addSubview:VLine];
//    }
//    return _typeBtn;
//}

- (UIButton *)searchBtn {
	if (!_searchBtn) {
		_searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		_searchBtn.bounds = CGRectMake(0, 0, 36.f, 36.f);
//        [_searchBtn setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
        [_searchBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        [_searchBtn setTitleColor:kColor(51, 51, 51) forState:(UIControlStateNormal)];
        _searchBtn.titleLabel.font = KPFFont(13);
        _searchBtn.backgroundColor = [UIColor clearColor];
	}
	return _searchBtn;
}

- (NSArray<NSDictionary *> *)hotTips {
	if (!_hotTips) {
		_hotTips = @[];
	}
	return _hotTips;
}

//- (NSArray<NSString *> *)types {
//    if (!_types) {
//        if (self.typeArray.count > 0) {
//
//            _types = [NSArray arrayWithArray:self.typeArray];
//        }else {
//            _types = @[@"淘宝"];
//        }
//    }
//    return _types;
//}

- (NSMutableArray<NSNumber *> *)cellHeights {
    if (!_cellHeights) {
        _cellHeights = [NSMutableArray array];
    }
    return _cellHeights;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.title = @"搜索";
	self.view.backgroundColor = [UIColor whiteColor];
	[self setupSubviews];
	[self bindEvents];
	[self loadTips];
	
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self.backHistoryTipView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		if ([obj isKindOfClass:[UIButton class]] && obj.tag == 19940909) {
			[obj removeFromSuperview];
		}
	}];
	// 添加历史搜索
	__block CGFloat top = 46.f;
	CGFloat height = 23.f;
	__block CGFloat width = 0;
	__block CGFloat left = 0;
	CGFloat vspace = 8.f;
	CGFloat space = 20.f;
	[[[YKYUserInfor shared] searchKeywords] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.tag = 19940909;
		button.clipsToBounds = YES;
		button.layer.cornerRadius = 11.5;
		button.titleLabel.font = KFont(14);
		[button setTitle:obj forState:UIControlStateNormal];
		[button setBackgroundColor: [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1/1.0]];
		[button setTitleColor:kColor(51, 51, 51) forState:UIControlStateNormal];
		CGRect rect = [button.titleLabel textRectForBounds:[UIScreen mainScreen].bounds limitedToNumberOfLines:1];
		left += width + space;
		width = rect.size.width + 18.f;
		if (left + width > kScreenWidth - space && idx != 0) {
			left = space;
			top += height+vspace;
		}
		// 限定宽度
		if (width > kScreenWidth - 2.f*space) {
			width = kScreenWidth - 2.f*space;
		}
		[self.backHistoryTipView addSubview:button];
		[button mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(self.backHistoryTipView).mas_offset(left);
			make.width.mas_equalTo(width);
			make.height.mas_equalTo(height);
			make.top.equalTo(self.backHistoryTipView).mas_offset(top);
		}];
		@weakify(self)
		[[button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIButton * _Nullable x) {
			@strongify(self);
            
            YKYGoodsListViewController *resultController = [[YKYGoodsListViewController alloc]init];
            resultController.tip = obj;
            [self.navigationController pushViewController:resultController animated:YES];
//            GeeHomeSearchResultViewController *resultController = [[GeeHomeSearchResultViewController alloc]init];
//            [self getShopTypeNumber];
//            resultController.shop = self.shop;
//            resultController.tip = [x titleForState:UIControlStateNormal];
//            [self.navigationController pushViewController:resultController animated:YES];
		}];
	}];
	[self.backHistoryTipView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(top + height + 30.f);
	}];
}

- (void)setupSubviews {
    

    
	[self.view addSubview:self.searchTf];
	[self.searchTf mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(30);
		make.right.equalTo(self.view.mas_right).mas_offset(-58);
		make.left.equalTo(self.view).mas_offset(40.f);
		make.top.equalTo(self.view).mas_offset(12.f+kStateBarHeight);
	}];
	
//    [self.view addSubview:self.backBtn];
//    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.searchTf);
//        make.left.equalTo(self.view.mas_left);
//        make.height.mas_equalTo(36.f);
//        make.width.mas_equalTo(40.f);
//    }];
    
    [self.view addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.searchTf);
        make.height.mas_equalTo(self.searchTf);
        make.left.mas_equalTo(self.searchTf.mas_right);
        make.right.mas_equalTo(self.view.mas_right);
    }];
    
//    [self.view addSubview:self.topSearchView];
//    [self.topSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.top.equalTo(self.searchTf.mas_bottom);
//        make.height.mas_equalTo(35.f);
//        make.left.equalTo(self.view);
//        make.right.equalTo(self.view);
//    }];
    
	self.scrollView = [[UIScrollView alloc]init];
	self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
	self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollEnabled = NO;
    self.scrollView.contentSize = CGSizeMake(2*kScreenWidth, 0);
    self.scrollView.backgroundColor = kColor(255, 255, 255);
	[self.view addSubview:self.scrollView];
	[self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.searchTf.mas_bottom).mas_offset(10.f);
		make.left.right.bottom.equalTo(self.view);
	}];
    
	UIView *backView = [[UIView alloc]init];
	backView.backgroundColor = [UIColor whiteColor];
//    [backView setHidden:YES];
	[self.scrollView addSubview:backView];
//    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.scrollView);
//        make.width.mas_equalTo(kScreenWidth);
//        make.top.equalTo(self.scrollView.mas_top).mas_offset(5.f);
//    }];
	// 热门推荐
	UILabel *hotTipLbl = [[UILabel alloc]init];
	hotTipLbl.textColor = kColor(51, 51, 51);
	hotTipLbl.textAlignment = NSTextAlignmentCenter;
	hotTipLbl.font = KPFMFont(15);
	hotTipLbl.text = @"大家都在搜";
	CGRect rect = [hotTipLbl textRectForBounds:[UIScreen mainScreen].bounds limitedToNumberOfLines:1];
	[backView addSubview:hotTipLbl];
	[hotTipLbl mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(backView);
		make.left.equalTo(backView).mas_offset(10.f);
		make.height.mas_equalTo(27.f);
		make.width.mas_equalTo(rect.size.width + 4.f);
	}];
	
    UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshBtn.contentMode = UIViewContentModeScaleAspectFill;
    refreshBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    @weakify(self)
    [[refreshBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self loadTips];
    }];
//    [refreshBtn setImage:[UIImage imageNamed:@"shuaxin"] forState:UIControlStateNormal];
    [backView addSubview:refreshBtn];
    [refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(hotTipLbl);
        make.width.mas_equalTo(40.f);
        make.height.mas_equalTo(20.f);
        make.right.equalTo(backView.mas_right).mas_offset(-10.f);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor clearColor];
    [backView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).mas_offset(10.f);
        make.right.equalTo(backView).mas_offset(-10.f);
        make.height.mas_equalTo(1.f);
        make.top.equalTo(hotTipLbl.mas_bottom).mas_offset(5.f);
    }];
    self.backHotTipView = backView;
    
	
	// 历史搜索
	UIView *backHistoryView = [[UIView alloc]init];
//    [backHistoryView setHidden:YES];
	backHistoryView.backgroundColor = kColor(255, 255, 255);
	[self.scrollView addSubview:backHistoryView];
    [backHistoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView);
        make.width.mas_equalTo(kScreenWidth);
        make.top.equalTo(self.scrollView.mas_top).mas_offset(5.f);
    }];
	UILabel *historyTipLbl = [[UILabel alloc]init];
	historyTipLbl.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
	historyTipLbl.textAlignment = NSTextAlignmentCenter;
	historyTipLbl.font = KPFMFont(15);
	historyTipLbl.text = @"历史搜索";
    
    
    
	rect = [historyTipLbl textRectForBounds:[UIScreen mainScreen].bounds limitedToNumberOfLines:1];
	[backHistoryView addSubview:historyTipLbl];
	[historyTipLbl mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(backHistoryView);
		make.left.equalTo(backHistoryView).mas_offset(10.f);
		make.height.mas_equalTo(27.f);
		make.width.mas_equalTo(rect.size.width + 4.f);
	}];
	UIView *line1 = [UIView new];
	line1.backgroundColor = [UIColor clearColor];
	[backHistoryView addSubview:line1];
	[line1 mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(backHistoryView).mas_offset(10.f);
		make.right.equalTo(backHistoryView).mas_offset(-10.f);
		make.height.mas_equalTo(1.f);
		make.top.equalTo(historyTipLbl.mas_bottom).mas_offset(5.f);
	}];
	// 清空按钮
	UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	clearBtn.contentMode = UIViewContentModeScaleAspectFill;
	clearBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
	[[clearBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
		@strongify(self);
		[[YKYUserInfor shared] clearLocalKeywords];
		[self.backHistoryTipView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
			if ([obj isKindOfClass:[UIButton class]] && obj.tag == 19940909) {
				[obj removeFromSuperview];
			}
		}];
		[backHistoryView mas_updateConstraints:^(MASConstraintMaker *make) {
			make.height.mas_equalTo(63.f);
		}];
	}];
	[clearBtn setImage:[UIImage imageNamed:@"icon-qingkong"] forState:UIControlStateNormal];
    
    [clearBtn setTitle:@" 清空" forState:(UIControlStateNormal)];
    [clearBtn setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0] forState:(UIControlStateNormal)];
//    clearBtn.titleLabel.text = @"清空";
    clearBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
//    clearBtn.titleLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0];
	[backHistoryView addSubview:clearBtn];
	[clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.equalTo(historyTipLbl);
		make.width.mas_equalTo(60.f);
		make.height.mas_equalTo(20.f);
		make.right.equalTo(backHistoryView.mas_right).mas_offset(-10.f);
	}];
	// 添加历史搜索
	__block CGFloat top = 46.f;
	CGFloat height = 23.f;
	__block CGFloat width = 0;
	__block CGFloat left = 0;
	CGFloat vspace = 8.f;
	CGFloat space = 20.f;
	[[[YKYUserInfor shared] searchKeywords] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.tag = 19940909;
		button.clipsToBounds = YES;
		button.layer.cornerRadius = 11.5 ;
		button.titleLabel.font = KPFFont(14);
		[button setTitle:obj forState:UIControlStateNormal];
        [button setBackgroundColor: [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1/1.0]];
		[button setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0] forState:UIControlStateNormal];
		CGRect rect = [button.titleLabel textRectForBounds:[UIScreen mainScreen].bounds limitedToNumberOfLines:1];
		left += width + space;
		width = rect.size.width + 18.f;
		if (left + width > kScreenWidth - space && idx != 0) {
			left = space;
			top += height+vspace;
		}
		// 限定宽度
		if (width > kScreenWidth - 2.f*space) {
			width = kScreenWidth - 2.f*space;
		}
		[backHistoryView addSubview:button];
		[button mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(backHistoryView).mas_offset(left);
			make.width.mas_equalTo(width);
			make.height.mas_equalTo(height);
			make.top.equalTo(backHistoryView).mas_offset(top);
		}];
		@weakify(self)
		[[button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIButton * _Nullable x) {
			@strongify(self);
//            GeeHomeSearchResultViewController *resultController = [[GeeHomeSearchResultViewController alloc]init];
//            [self getShopTypeNumber];
//            resultController.shop = self.shop;
//            resultController.tip = [x titleForState:UIControlStateNormal];
//            [self.navigationController pushViewController:resultController animated:YES];
		}];
	}];
	self.backHistoryTipView = backHistoryView;
	[backHistoryView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(top + height + 30.f);
	}];
    
    
    
    UIScrollView * superBgView = [[UIScrollView alloc]init];
    superBgView.backgroundColor = [UIColor whiteColor];
    superBgView.delegate =self;
    self.superBgView = superBgView;
    [self.scrollView addSubview:superBgView];
    [superBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView.mas_left).offset(kScreenWidth);
        make.width.mas_equalTo(kScreenWidth);
        make.top.equalTo(self.scrollView.mas_top);
        make.bottom.equalTo(self.scrollView.mas_bottom);
        make.height.equalTo(@(kScreenHeight-36.f - 40.f - 12.f-kStateBarHeight));
        make.right.equalTo(self.scrollView.mas_right);
    }];
    
    //超级搜
    self.picsTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-12.f-kStateBarHeight-40 -36) style:UITableViewStylePlain];
    self.picsTabelView.dataSource = self;
    self.picsTabelView.delegate = self;
    self.picsTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.superBgView addSubview:self.picsTabelView];
    [self requestCursePicsApi];
    
	[self.view sendSubviewToBack:self.scrollView];
    
	// 监听frame改变事件
	[RACObserve(backHistoryView, frame) subscribeNext:^(NSValue * _Nullable x) {
		@strongify(self);
		CGRect frame = x.CGRectValue;
		self.scrollView.contentSize = CGSizeMake(2*kScreenWidth, frame.origin.y + frame.size.height);
	}];
    
    
    // 热门推荐跟到历史搜索下面
    [backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backHistoryView.mas_bottom).mas_offset(10);
        make.left.equalTo(backHistoryView);
        make.right.equalTo(backHistoryView);
        
    }];
    
    
    // 新增“如何查找优惠券”
    
//    view.frame = CGRectMake(15, 337, 345, 81);
    UIButton *jumpBtn = [[UIButton alloc] init];
//    jumpBtn.frame = CGRectMake(15, 337, 345, 81);
    [jumpBtn setImage:[UIImage imageNamed:@"教程入口"] forState:UIControlStateNormal];
     [self.view addSubview:jumpBtn];
    [jumpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView.mas_bottom).mas_offset(10);
        make.left.equalTo(backView).mas_offset(15);
        make.right.equalTo(backView).mas_offset(-15);
//        make.height.mas_equalTo(jumpBtn.width).multipliedBy(345/81);// 高/宽 == 345/81
    }];
    [[jumpBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self jumpToGuide];
    }];
    
    // 新增顶部主题色
    UIView *topRedView = [[UIView alloc] init];
    topRedView.backgroundColor =  [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
    [self.view addSubview:topRedView];
    [self.view sendSubviewToBack:topRedView];
    [topRedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.mas_equalTo(backHistoryView.mas_top).mas_offset(-15);
    }];
    
//    // 新增顶部圆角
//    UIView *topWhiteView = [[UIView alloc] init];
//    topWhiteView.layer.masksToBounds = YES;
//    topWhiteView.layer.cornerRadius = 15;
//    topWhiteView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:topWhiteView];
//    [topWhiteView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(topRedView);
//        make.right.equalTo(topRedView);
//        make.height.mas_equalTo(30);
//        make.bottom.mas_equalTo(backHistoryView.mas_top);
//    }];
    
}

-(void)jumpToGuide {
    NSLog(@"点击如何查找优惠券按钮");
//    WebVC *webVC = [[WebVC alloc] init];
//    webVC.url = @"https://beesgarden.yooopon.com/app/page/tutorial";
//    [self.navigationController pushViewController:webVC animated:YES];
//    webVC.title = @"如何查找优惠券";
    
}

- (void)loadTips {
//    if (self.refreshTipTask) {
//        [self.refreshTipTask cancel];
//    }
    
    
    [[YKYNetWorking sharedYKYNetWorking] sendNetworkRequestURL:KAPIMobileHomeGetHotKey param:nil superView:self.view methodType:Get andBlock:^(id  _Nullable data, NSError * _Nullable error) {
        
        if (!error) {
            if ([NSString isNULLString:data[@"data"]]) {
                [MBProgressHUD showMessage:data[@"msg"] toView:self.view];
                
            }else{
           
                
                
                self.hotTips = data[@"data"];
                [self.backHotTipView removeAllSubviews];
                UILabel *hotTipLbl = [[UILabel alloc]init];
                hotTipLbl.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
                hotTipLbl.textAlignment = NSTextAlignmentCenter;
                hotTipLbl.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
                hotTipLbl.text = @"热门推荐";
                CGRect rect = [hotTipLbl textRectForBounds:[UIScreen mainScreen].bounds limitedToNumberOfLines:1];
                [self.backHotTipView addSubview:hotTipLbl];
                [hotTipLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.backHotTipView);
                    make.left.equalTo(self.backHotTipView).mas_offset(10.f);
                    make.height.mas_equalTo(27.f);
                    make.width.mas_equalTo(rect.size.width + 4.f);
                }];
                UIView *line = [UIView new];
                line.backgroundColor = [UIColor clearColor];
                [self.backHotTipView addSubview:line];
                [line mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.backHotTipView).mas_offset(10.f);
                    make.right.equalTo(self.backHotTipView).mas_offset(-10.f);
                    make.height.mas_equalTo(1.f);
                    make.top.equalTo(hotTipLbl.mas_bottom).mas_offset(5.f);
                }];
                __block CGFloat top = 46.f;
                CGFloat height = 23.f;
                __block CGFloat width = 0;
                __block CGFloat left = 0;
                CGFloat vspace = 8.f;
                CGFloat space = 20.f;
                [self.hotTips enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.clipsToBounds = YES;
                    button.layer.cornerRadius = 11.5 ;
                    button.titleLabel.font = KPFFont(14);
                    [button setTitle:obj[@"keyword"] forState:UIControlStateNormal];
                    [button setBackgroundColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1/1.0]];
                    [button setTitleColor: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0] forState:UIControlStateNormal];
                    CGRect rect = [button.titleLabel textRectForBounds:[UIScreen mainScreen].bounds limitedToNumberOfLines:1];
                    left += width + space;
                    width = rect.size.width + 18.f;
                    if (left + width > kScreenWidth - space && idx != 0) {
                        left = space;
                        top += height+vspace;
                    }
                    // 限定宽度
                    if (width > kScreenWidth - 2.f*space) {
                        width = kScreenWidth - 2.f*space;
                    }
                    [self.backHotTipView addSubview:button];
                    
//                    self.backHotTipView.backgroundColor = [UIColor redColor];
                    [button mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.backHotTipView).mas_offset(left);
                        make.width.mas_equalTo(width);
                        make.height.mas_equalTo(height);
                        make.top.equalTo(self.backHotTipView).mas_offset(top);
                    }];
                    
//                    [button addTarget:self action:@selector(ac) forControlEvents:UIControlEventTouchUpInside];
                    @weakify(self)
                    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIButton * _Nullable x) {
                        @strongify(self);
                        
                        YKYGoodsListViewController *resultController = [[YKYGoodsListViewController alloc]init];
                        resultController.tip = obj[@"keyword"];
                        [self.navigationController pushViewController:resultController animated:YES];
//                        GeeHomeSearchResultViewController *resultController = [[GeeHomeSearchResultViewController alloc]init];
//                        [self getShopTypeNumber];
//                        resultController.shop = self.shop;
//                        resultController.tip = [x titleForState:UIControlStateNormal];
//                        [self.navigationController pushViewController:resultController animated:YES];
                    }];
                    
                    [self.backHotTipView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(top + height + 30.f);
                    }];
                }];
            }
            
        }
        NSLog(@"KAPIMobileHomeGetClassifyItemList %@",data);
        
        
        
        
     
    }];
    
    /*
	self.refreshTipTask = [[GeeAFNetworkManager shared] NJ_hotTips:@{} superView:self.view andBlock:^(id  _Nullable data, NSError * _Nullable error) {
		if (!error) {
			self.hotTips = data[@"data"];
			[self.backHotTipView removeAllSubviews];
			UILabel *hotTipLbl = [[UILabel alloc]init];
			hotTipLbl.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
			hotTipLbl.textAlignment = NSTextAlignmentCenter;
			hotTipLbl.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
			hotTipLbl.text = @"热门推荐";
			CGRect rect = [hotTipLbl textRectForBounds:[UIScreen mainScreen].bounds limitedToNumberOfLines:1];
			[self.backHotTipView addSubview:hotTipLbl];
			[hotTipLbl mas_makeConstraints:^(MASConstraintMaker *make) {
				make.top.equalTo(self.backHotTipView);
				make.left.equalTo(self.backHotTipView).mas_offset(10.f);
				make.height.mas_equalTo(27.f);
				make.width.mas_equalTo(rect.size.width + 4.f);
			}];
			UIView *line = [UIView new];
			line.backgroundColor = [UIColor clearColor];
			[self.backHotTipView addSubview:line];
			[line mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.equalTo(self.backHotTipView).mas_offset(10.f);
				make.right.equalTo(self.backHotTipView).mas_offset(-10.f);
				make.height.mas_equalTo(1.f);
				make.top.equalTo(hotTipLbl.mas_bottom).mas_offset(5.f);
			}];
			__block CGFloat top = 46.f;
			CGFloat height = 23.f;
			__block CGFloat width = 0;
			__block CGFloat left = 0;
			CGFloat vspace = 8.f;
			CGFloat space = 20.f;
			[self.hotTips enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
				UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
				button.clipsToBounds = YES;
				button.layer.cornerRadius = 11.5 ;
				button.titleLabel.font = kFontLevel6;
				[button setTitle:obj[@"name"] forState:UIControlStateNormal];
				[button setBackgroundColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1/1.0]];
				[button setTitleColor: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0] forState:UIControlStateNormal];
				CGRect rect = [button.titleLabel textRectForBounds:[UIScreen mainScreen].bounds limitedToNumberOfLines:1];
				left += width + space;
				width = rect.size.width + 18.f;
				if (left + width > kScreenWidth - space && idx != 0) {
					left = space;
					top += height+vspace;
				}
				// 限定宽度
				if (width > kScreenWidth - 2.f*space) {
					width = kScreenWidth - 2.f*space;
				}
				[self.backHotTipView addSubview:button];
				[button mas_makeConstraints:^(MASConstraintMaker *make) {
					make.left.equalTo(self.backHotTipView).mas_offset(left);
					make.width.mas_equalTo(width);
					make.height.mas_equalTo(height);
					make.top.equalTo(self.backHotTipView).mas_offset(top);
				}];
				@weakify(self)
				[[button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIButton * _Nullable x) {
					@strongify(self);
					GeeHomeSearchResultViewController *resultController = [[GeeHomeSearchResultViewController alloc]init];
                    [self getShopTypeNumber];
                    resultController.shop = self.shop;
					resultController.tip = [x titleForState:UIControlStateNormal];
					[self.navigationController pushViewController:resultController animated:YES];
				}];
			}];
			UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
			refreshBtn.contentMode = UIViewContentModeScaleAspectFill;
			refreshBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//            [refreshBtn setImage:[UIImage imageNamed:@"shuaxin"] forState:UIControlStateNormal];
			@weakify(self)
			[[refreshBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
				@strongify(self)
				[self loadTips];
			}];
            [self.backHotTipView addSubview:refreshBtn];
			[refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
				make.centerY.equalTo(hotTipLbl);
				make.width.mas_equalTo(40.f);
				make.height.mas_equalTo(20.f);
				make.right.equalTo(self.backHotTipView.mas_right).mas_offset(-10.f);
			}];
			
			[self.backHotTipView mas_updateConstraints:^(MASConstraintMaker *make) {
				make.height.mas_equalTo(top + height + 30.f);
			}];
		}
	}];
     */
}
//-(void)ac{
//    NSLog(@"11");
//}
- (void)bindEvents {
	@weakify(self)
//    [[self.typeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        @strongify(self)
//        NSMutableArray *dataModels = [[NSMutableArray alloc]init];
//        [self.types enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            LrdCellModel *model = [[LrdCellModel alloc]initWithTitle:obj imageName:nil];
//            [dataModels addObject:model];
//        }];
//        LrdOutputView *popView = [[LrdOutputView alloc]initWithDataArray:dataModels origin:CGPointMake(self.searchTf.left, self.searchTf.bottom + 5.f) width:self.typeBtn.width+15.f height:30.f direction:kLrdOutputViewDirectionCenter];
//        NSString *typeString = [self.typeBtn titleForState:UIControlStateNormal];
//        popView.selectedRow = [self.types indexOfObject:typeString];
//        popView.delegate = self;
//        [popView pop];
//    }];
	[[self.backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
		@strongify(self)
		[self.navigationController popViewControllerAnimated:YES];
	}];
	[[self.searchBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
		@strongify(self)
//        GeeHomeSearchResultViewController *resultController = [[GeeHomeSearchResultViewController alloc]init];
//        [self getShopTypeNumber];
//        resultController.shop = self.shop;
//        resultController.tip = self.searchTf.text;
//        [self.navigationController pushViewController:resultController animated:YES];
        
         [self.navigationController popViewControllerAnimated:YES];
	}];
    
    [[self.normalButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self);
        if (x.isSelected == YES) {
            return;
        }
        x.selected = YES;
        self.superButton.selected = NO;
        x.titleLabel.font = KFont(16);
        self.superButton.titleLabel.font = KFont(16);
        
        [self.instructionsView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX).offset(-kScreenWidth/4);
        }];

        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }];
    
    [[self.superButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        @strongify(self);
        if (x.isSelected == YES) {
            return;
        }
        x.selected = YES;
        self.normalButton.selected = NO;
        x.titleLabel.font = KFont(16);
        self.normalButton.titleLabel.font = KFont(16);
        [self.instructionsView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX).offset(kScreenWidth/4);
        }];
         [self.scrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
//    self.fd_prefersNavigationBarHidden = YES;
    self.navigationController.navigationBar.hidden = YES;
//    if (!self.navigationController.navigationBar.isHidden) {
//        [self.navigationController setNavigationBarHidden:YES animated:self.navigationBarHideAnimated];
//    }
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
	[IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}


//MARK 状态栏单独设置成白色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - LrdOutputViewDelegate

- (void)didSelectedAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (self.types[indexPath.row].length >= 3) {
//        self.typeBtn.titleLabel.font = kFontLevel5;
//    }else {
//        self.typeBtn.titleLabel.font = kFontLevel3;
//    }
//    [self.typeBtn setTitle:self.types[indexPath.row] forState:UIControlStateNormal];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([NSString isNULLString:textField.text]) {
        return YES;
    }
    YKYGoodsListViewController *resultController = [[YKYGoodsListViewController alloc]init];
    resultController.tip = self.searchTf.text;
    [self.navigationController pushViewController:resultController animated:YES];
	return YES;
}


- (void)getShopTypeNumber
{

//    if ([@"京东" isEqualToString:[self.typeBtn titleForState:UIControlStateNormal]]) {
//        self.shop = @"3";
//    } else if ([@"淘宝" isEqualToString:[self.typeBtn titleForState:UIControlStateNormal]]) {
//        self.shop = @"2";
//    }else if ([@"天猫" isEqualToString:[self.typeBtn titleForState:UIControlStateNormal]]) {
//        self.shop = @"1";
//    }else if ([@"蘑菇街" isEqualToString:[self.typeBtn titleForState:UIControlStateNormal]]) {
//        self.shop = @"4";
//    }else if ([@"拼多多" isEqualToString:[self.typeBtn titleForState:UIControlStateNormal]]) {
//        self.shop = @"5";
//    }else if ([@"苏宁" isEqualToString:[self.typeBtn titleForState:UIControlStateNormal]]) {
//        self.shop = @"6";
//    }
}

#pragma mark - 超级搜索

- (void)requestCursePicsApi
{
//    [[GeeAFNetworkManager shared] NJ_getkCoursePicsApi:@{@"shop":@"0"} superView:self.view andBlock:^(id  _Nullable data, NSError * _Nullable error) {
//
//        if (error) {
//
//        }else {
//            self.imagePaths = data[@"data"];
//            self.cellHeights = [NSMutableArray array];
//            [self.imagePaths enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//                [self.cellHeights addObject:[NSNumber numberWithFloat:0]];
//            }];
//            [self.picsTabelView reloadData];
//        }
//    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.imagePaths.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"picsCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"picsCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView * imageView = [[UIImageView alloc]initWithImage:nil];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.tag = 11111222;
        [cell.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }
    UIImageView *imageView = [cell.contentView viewWithTag:11111222];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.imagePaths[indexPath.row]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image) {
            if (self.cellHeights[indexPath.row].integerValue > 0) {
                return;
            }
            CGFloat height = kScreenWidth * image.size.height / image.size.width;
            
            self.cellHeights[indexPath.row] = [NSNumber numberWithFloat:height];
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView performWithoutAnimation:^{
                    [self.picsTabelView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                }];
            });
        }
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSNumber *height = self.cellHeights[indexPath.row];
    return height.floatValue;
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
