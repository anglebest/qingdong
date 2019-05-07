//
//  YKYGoodsViewController.m
//  ShengYa
//
//  Created by apple on 2019/4/17.
//  Copyright © 2019 Wkz. All rights reserved.
//

#import "YKYGoodsViewController.h"
#import "SDCycleScrollView.h"
#import "YRPreviewImageView.h"


#import "NJRecommendLanguageCell.h"
#import "NJHomeShopDetailsCell.h"
#import "NJHomeDetailTableViewCell.h"

#import "shareView.h"

#import <FLAnimatedImage/FLAnimatedImageView.h>
#import <FLAnimatedImage/FLAnimatedImage.h>


#import "YKYWebViewViewController.h"

#import <WebKit/WebKit.h>
@interface YKYGoodsViewController ()<SDCycleScrollViewDelegate,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;


@property (nonatomic,strong)WKWebView * wkWebView;


@property (nonatomic, strong) NSArray<NSString *> *imagePaths;


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITableViewHeaderFooterView *tableViewFooter;


@property (nonatomic, strong) NSMutableArray<NSNumber *> *cellHeights;


@property (nonatomic, strong) NSMutableArray<NSString *> *bottomImagePaths;


@property (nonatomic, strong) UIButton *leftBtn;

@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, strong) UIButton *HomeBtn;

@property (nonatomic, strong) UIButton *shareBtn;

@property (nonatomic, strong) UIButton *buyBtn;


@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) shareView *shareview;




@end

@implementation YKYGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:kColor(255, 255, 255)];
    self.title = @"商品详情";
    
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kColor(51, 51, 51)}];
    self.imagePaths = [self.model.itemSmallImages componentsSeparatedByString:@","];
    [self.view addSubview:self.tableView];
    
//    UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(clickEvent)];
//    self.navigationItem.rightBarButtonItem = myButton;
    
    self.shareview = [[shareView alloc]initFrame:self.view.frame];
    
    
    __weak typeof(self) weakSelf = self;
    self.shareview.cancleSharePress = ^{
        [weakSelf cancelPress];
    };
    
    
    [self getImgData];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self setupSubview];
    // Do any additional setup after loading the view.
}
-(UIView *)topView{
    if (!_topView) {
        _topView = [UIView new];
        
    }
    
    return _topView;
}
-(void)viewWillAppear:(BOOL)animated{
 
    self.navigationController.navigationBar.hidden = YES;
    
//    [self.navigationController.navigationBar setBarTintColor:[UIColor clearColor]];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = NO;
    
}
-(void)setupSubview{
    
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(SafeAreaTopHeight);
        make.width.mas_equalTo(kScreenWidth);
    
    }];
    
    [self.topView addSubview:self.leftBtn];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).mas_offset(15);
        make.top.equalTo(self.topView).mas_offset(SafeAreaTopHeight-40);
        make.height.mas_equalTo(25*RATIO);
        make.width.mas_equalTo(25*RATIO);
    }];
    
    
    [self.topView addSubview:self.rightBtn];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topView).mas_offset(-15);
        make.top.equalTo(self.topView).mas_offset(SafeAreaTopHeight-40);
        make.height.mas_equalTo(25*RATIO);
        make.width.mas_equalTo(25*RATIO);
    }];
    
    
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(50.f + kTabBarHeight - 49.f);
    }];
    [bottomView addSubview:self.HomeBtn];
    [self.HomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).mas_offset(30);
        make.top.equalTo(bottomView.mas_top).mas_offset(0);
        make.height.mas_equalTo(50.f*RATIO);
        make.width.mas_equalTo(50*RATIO);
        //        make.height.(50.f);
        //        make.width.equalTo(bottomView).multipliedBy(0.259);
    }];
    
    self.HomeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [_HomeBtn setTitleEdgeInsets:UIEdgeInsetsMake(self.HomeBtn.imageView.frame.size.height ,-self.HomeBtn.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [self.HomeBtn setImageEdgeInsets:UIEdgeInsetsMake(-10.0, 0.0,0.0, -self.HomeBtn.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
    
   
    
    self.shareBtn.frame = CGRectMake(117*RATIO, 6*RATIO, 100*RATIO, 40*RATIO);
    [bottomView addSubview:self.shareBtn];
    //    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(bottomView);
    //        make.height.mas_equalTo(50.f);
    //        make.left.equalTo(self.collectionBtn.mas_right).mas_offset(15);
    ////        make.width.equalTo(bottomView).multipliedBy(0.5);
    //        make.width.equalTo(bottomView).multipliedBy(0.373);
    //    }];
    //    self.shareBtn.backgroundColor = [UIColor redColor];
    //    UIBezierPath *maskPath=[UIBezierPath bezierPathWithRoundedRect:self.shareBtn.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(self.shareBtn.size.height/2, self.shareBtn.size.height/2)];
    //    CAShapeLayer *maskLayer=[[CAShapeLayer alloc]init];
    //    maskLayer.frame=self.shareBtn.bounds;
    //    maskLayer.path=maskPath.CGPath;
    //    self.shareBtn.layer.mask=maskLayer;
    
    CGFloat radius = 21.0f;
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.shareBtn.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer * mask  = [[CAShapeLayer alloc] init];
    mask.lineWidth = 1;
    mask.lineCap = kCALineCapSquare;
    
    // 带边框则两个颜色不要设置成一样即可
    mask.strokeColor = kColor(251, 83, 1).CGColor;
    mask.fillColor = kColor(251, 83, 1).CGColor;
    
    mask.path = path.CGPath;
    [self.shareBtn.layer addSublayer:mask];
    [bottomView addSubview:self.buyBtn];
    
    self.buyBtn.frame = CGRectMake(217*RATIO, 6*RATIO, 144*RATIO, 40*RATIO);
    //    self.buyBtn.backgroundColor = [UIColor redColor];
    
    
    
    
    UIBezierPath * path1 = [UIBezierPath bezierPathWithRoundedRect:self.buyBtn.bounds byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer * mask1  = [[CAShapeLayer alloc] init];
    mask1.lineWidth = 1;
    mask1.lineCap = kCALineCapSquare;
    
    // 带边框则两个颜色不要设置成一样即可
    mask1.strokeColor = kColor(245, 34, 98).CGColor;
    mask1.fillColor = kColor(245, 34, 98).CGColor;
    //    mask1.fillColor = [UIColor whiteColor].CGColor;
    
    mask1.path = path1.CGPath;
    
    [self.buyBtn.layer addSublayer:mask1];
    //    self.buyBtn.backgroundColor = kColor(245, 34, 98);
    //    [_buyBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    
    
    NSMutableAttributedString *buyTitle = [[NSMutableAttributedString alloc]initWithString:@"用券抢购" attributes:@{NSFontAttributeName: KPFFont(14),NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.buyBtn setAttributedTitle:buyTitle forState:UIControlStateNormal];
    
    
    [self.tableView bringSubviewToFront:self.leftBtn];
}
-(WKWebView *)wkWebView{
    
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.frame];
        [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://47.98.132.55:86/imgList?id=%@",self.model.itemId]]]];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        //开了支持滑动返回
        _wkWebView.allowsBackForwardNavigationGestures = YES;
//        [self.view addSubview:self.webView];
    }
    return _wkWebView;
}
- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
        _cycleScrollView.delegate = self;
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView.currentPageDotColor = [UIColor redColor];
        _cycleScrollView.pageDotColor =  kColor(149, 149, 149);
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
        _cycleScrollView.imageURLStringsGroup = self.imagePaths;
    }
    return _cycleScrollView;
}
- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setImage:[UIImage imageNamed:@"返回按钮"] forState:0];
        _leftBtn.layer.cornerRadius = 12.5;
        _leftBtn.layer.masksToBounds = YES;
        _leftBtn.backgroundColor = kColor(195, 195, 195);
        
        [_leftBtn addTarget:self action:@selector(homeBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setImage:[UIImage imageNamed:@"分享按钮"] forState:0];
        _rightBtn.layer.cornerRadius = 12.5;
        _rightBtn.layer.masksToBounds = YES;
        _rightBtn.backgroundColor = kColor(195, 195, 195);
        [_rightBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
- (UIButton *)HomeBtn {
    if (!_HomeBtn) {
        _HomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _HomeBtn.backgroundColor = [UIColor whiteColor];
        _HomeBtn.titleLabel.font = KPFFont(14);
        [_HomeBtn setTitle:@"首页" forState:UIControlStateNormal];
        [_HomeBtn setTitleColor:kColor(51, 51, 51) forState:UIControlStateNormal];
        [_HomeBtn setImage:[UIImage imageNamed:@"首页未选中"] forState:UIControlStateNormal];
        //        _HomeBtn.backgroundColor = [UIColor redColor];
        _HomeBtn.titleLabel.font = KPFFont(10);
        [_HomeBtn addTarget:self action:@selector(homeBack) forControlEvents:UIControlEventTouchUpInside];
        //        _HomeBtn.titleEdgeInsets = UIEdgeInsetsMake(_HomeBtn.imageView.frame.size.height+15, -_HomeBtn.imageView.bounds.size.width, 0,0);
        //        // button图片的偏移量
        //       _HomeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, _HomeBtn.titleLabel.frame.size.width/2, _HomeBtn.titleLabel.frame.size.height+15, -_HomeBtn.titleLabel.frame.size.width/2);
        
        
        
        
    }
    return _HomeBtn;
}
- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.adjustsImageWhenHighlighted = NO;
        [_shareBtn setTitleColor:kColor(255, 255, 255) forState:UIControlStateNormal];
        _shareBtn.backgroundColor = [UIColor clearColor];
        _shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5.f, 0, 0);
        _shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5.f);
        NSMutableAttributedString *shareTitle = [[NSMutableAttributedString alloc]initWithString:@"不领券" attributes:@{NSFontAttributeName: KPFFont(14),NSForegroundColorAttributeName: kColor(255, 255, 255)}];
        [_shareBtn setAttributedTitle:shareTitle forState:UIControlStateNormal];
        
    }
    return _shareBtn;
}

- (UIButton *)buyBtn {
    if (!_buyBtn) {
        _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSMutableAttributedString *buyTitle = [[NSMutableAttributedString alloc]initWithString:@"用券购买" attributes:@{NSFontAttributeName: KPFFont(14),NSForegroundColorAttributeName: [UIColor whiteColor]}];
        [_buyBtn setAttributedTitle:buyTitle forState:UIControlStateNormal];
        
    }
    return _buyBtn;
}

- (NSMutableArray<NSNumber *> *)cellHeights {
    if (!_cellHeights) {
        _cellHeights = [NSMutableArray array];
    }
    return _cellHeights;
}

- (NSMutableArray<NSString *> *)bottomImagePaths {
    if (!_bottomImagePaths) {
        _bottomImagePaths = [NSMutableArray array];
    }
    return _bottomImagePaths;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.clipsToBounds = NO;
        
        //        _tableView.rowHeight = UITableViewAutomaticDimension;
        //        // 设置预估行高 --> 先让 tableView 能滚动，在滚动的时候再去计算显示的 cell 的真正的行高，并且调整 tabelView 的滚动范围
        _tableView.estimatedRowHeight = 0.1;
        
        
        //        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UITableViewHeaderFooterView *backView = [[UITableViewHeaderFooterView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
        backView.contentView.clipsToBounds = NO;
        [backView.contentView addSubview:self.cycleScrollView];
        _tableView.tableHeaderView = backView;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NJHomeDetailTableViewCell classForCoder]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:homeDetailCell];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NJHomeShopDetailsCell classForCoder]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:shopDetailsCell];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NJRecommendLanguageCell classForCoder]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:recommendLanguageCell];
        // 适配iphone X
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight - 49.f + 50.f, 0);
    }
    return _tableView;
}

- (UITableViewHeaderFooterView *)tableViewFooter {
    if (!_tableViewFooter) {
        _tableViewFooter = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"footer"];
        _tableViewFooter.contentView.backgroundColor = [UIColor whiteColor];
        _tableViewFooter.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth + 12.f);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 12.f, kScreenWidth, kScreenWidth);
        button.tag = 19940909;
        button.adjustsImageWhenHighlighted = NO;
        //        [button sd_setImageWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2863468059,3619543577&fm=27&gp=0.jpg"] forState:UIControlStateNormal placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //            CGFloat height = kScreenWidth * image.size.height / image.size.width;
        //            button.height = height;
        //            _tableViewFooter.height = height + 24.f;
        //        }];
        [_tableViewFooter.contentView addSubview:button];
    }
    return _tableViewFooter;
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {

        return 3;
    }else if (section == 1){
        
        return 0;
    }
    if (self.bottomImagePaths && (NSInteger)self.bottomImagePaths.count > 0) {
        return self.bottomImagePaths.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NJHomeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeDetailCell forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            @weakify(self)
            cell.addToCartsBlock = ^{
                @strongify(self)
                [self enterBtnAction];
            };
            cell.model = self.model;
//            [cell.quanBtn addTarget:self action:@selector(enterBtnAction) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else if (indexPath.row == 1) {
            NJRecommendLanguageCell * cell = [tableView dequeueReusableCellWithIdentifier:recommendLanguageCell forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.recommendString = self.model.introduce;
            return cell;
        }else if (indexPath.row == 2) {
            NJHomeShopDetailsCell * cell = [tableView dequeueReusableCellWithIdentifier:shopDetailsCell forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.shop = self.model.shop;
//            [cell addStrePinJiaDic:self.model.storeEvaluate];
            
            //            if (!self.model.storeEvaluate) {
            //                self.tableView.rowHeight = 0.01;
            //                }
            return cell;
        }
        
    }else if (indexPath.section == 1){
        /*
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
            UILabel *lab = [UILabel new];
            [cell addSubview:lab];
            lab.text = @"猜你喜欢";
            lab.textColor =kColor(255, 34, 98);
            lab.font = KPFMFont(16);
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                //                make.bottom.equalTo(cell);
                make.left.equalTo(cell.mas_left).mas_offset(10);
                make.top.equalTo(cell.mas_top).mas_offset(15);
                make.height.mas_equalTo(22);
            }];
//            [cell addSubview:self.collectionView];
            [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(cell);
                make.top.equalTo(cell.mas_top).mas_offset(47);
            }];
            
//            [self setupRefreshHeaderFoorer];
//            [self loadLikeData];
            //            [self.collectionView.sideRefreshHeader beginLoading];
            
        }
        return cell;
         */
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"systemCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"systemCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        FLAnimatedImageView *imageViewGif = [[FLAnimatedImageView alloc]initWithImage:nil];
        imageViewGif.contentMode = UIViewContentModeScaleAspectFill;
        imageViewGif.clipsToBounds = YES;
        cell.contentView.clipsToBounds = YES;
        imageViewGif.tag = 199409091;
        imageViewGif.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:imageViewGif];
        [imageViewGif mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:nil];
        imageView.tag = 199409092;
        imageView.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }
    FLAnimatedImageView *imageViewGif = [cell.contentView viewWithTag:199409091];
    UIImageView *imageView = [cell.contentView viewWithTag:199409092];
    imageViewGif.animatedImage = nil;
    //    imageViewGif.contentMode = UIViewContentModeScaleAspectFill;
    //    imageViewGif.clipsToBounds = YES;
    //    imageView.contentMode = UIViewContentModeScaleAspectFill;
    //    imageView.clipsToBounds = YES;
    imageView.image = nil;
    if ([[self.bottomImagePaths[indexPath.row] componentsSeparatedByString:@"."].lastObject containsString:@"gif"]) {
        [cell.contentView bringSubviewToFront:imageViewGif];
        NSURL *url = [NSURL URLWithString:self.bottomImagePaths[indexPath.row]];
        [[SDWebImageManager sharedManager] loadImageWithURL:url options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.cellHeights[indexPath.row].integerValue > 0) {
                    return;
                }
                imageViewGif.animatedImage = animatedImage;
                CGFloat height = kScreenWidth * animatedImage.size.height / animatedImage.size.width;
                if (animatedImage.size.height >= 5*animatedImage.size.width) {
                    height = 1.5;
                }
                if (height <= 0) {
                    height = 1.5;
                }
                self.cellHeights[indexPath.row] = [NSNumber numberWithFloat:height];
                [UIView performWithoutAnimation:^{
                    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                }];
            });
        }];
    } else {
        [cell.contentView bringSubviewToFront:imageView];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.bottomImagePaths[indexPath.row]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (image) {
                if (self.cellHeights[indexPath.row].integerValue > 0) {
                    return;
                }
                CGFloat height = kScreenWidth * image.size.height / image.size.width;
                
//                NSLog(@"height = %f",height);
//                if (image.size.height >= 5*image.size.width) {
//                    height = 1.5;
//                }
//                if (height <= 0) {
//                    height = 1.5;
//                }
                self.cellHeights[indexPath.row] = [NSNumber numberWithFloat:height];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIView performWithoutAnimation:^{
                        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }];
                });
            }
        }];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
       
        if (indexPath.row == 0) {
            return 240;
            return [NJHomeDetailTableViewCell cellHeight];
        }else if(indexPath.row == 1){
            
            return 0;
//            CGFloat height = [Utils getTextHeightWithFontSize:15*RATIO string:self.model.introduce width:kScreenWidth-30*RATIO];
//            return height + 70*RATIO;
        }else if(indexPath.row == 2){
            return 110;
            
        }
        
    }else if (indexPath.section == 1){
        return 211;
    }
    NSNumber *height = self.cellHeights[indexPath.row];
    
//    NSLog(@"height %@",height);
    return height.floatValue;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 10;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *sectionFooter = [tableView footerViewForSection:0];
    if (!sectionFooter) {
        sectionFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10.f)];
        sectionFooter.backgroundColor = kColor(249, 249, 249);
    }
    return sectionFooter;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
 
    if (section == 2) {
        return 50;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
 
    if (section == 2) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
//        view.backgroundColor = kColor(249, 249, 249);
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 20)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = @"图文详情";
        [view addSubview:lab];
        return view;
    }
    return nil;
   
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    NSLog(@"111");
//    NSLog(@"%f",self.tableView.contentOffset.y);
    if (self.tableView.contentOffset.y > 100) {
        
        self.topView.hidden = YES;
    }else{
       self.topView.hidden = NO;
    }
    
}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    // 点击轮播图片回调
    // 当前图片索引
    if (!self.cycleScrollView.imageURLStringsGroup || (NSInteger)self.cycleScrollView.imageURLStringsGroup.count <= 0) {
        return;
    }
    NSInteger currentIndex = (NSInteger)index % self.cycleScrollView.imageURLStringsGroup.count;
    NSArray<NSString *> *imageFlags = @[@"png",@"jpg",@"bmp",@"tiff",@"gif"];
    NSString *urlStr = self.imagePaths[currentIndex];
    if ([NSString isNULLString:urlStr]) {
        return;
    }
    if ([imageFlags containsObject:[urlStr componentsSeparatedByString:@"."].lastObject.lowercaseString]) {
        // FIXME: 图片预览插件
        YRPreviewImageView *preView = [[YRPreviewImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        NSMutableArray *images = [NSMutableArray arrayWithArray:self.imagePaths];
        NSMutableArray *rects = [NSMutableArray array];
        NSMutableArray *thums = [NSMutableArray array];
        [images enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSString classForCoder]]) {
                if (![imageFlags containsObject:[obj componentsSeparatedByString:@"."].lastObject.lowercaseString]) {
                    [images removeObject:obj];
                } else {
                    [rects addObject:[NSValue valueWithCGRect:[self.tableView convertRect:self.cycleScrollView.bounds toView:self.view]]];
                    [thums addObject:[UIImage new]];
                }
            } else {
                [images removeObject:obj];
            }
        }];
        preView.images = images;
        preView.thumbnails = thums;
        preView.currentIndex = [images indexOfObject:urlStr];
        [preView show:YES to:kAppDelegate.window.rootViewController withRects:rects];
    } else if ([@"mp4" isEqualToString:[urlStr componentsSeparatedByString:@"."].lastObject.lowercaseString]) {
        // 视频播放
//        if (self.playerView.state == ZFPlayerStatePlaying || self.playerView.state == ZFPlayerStateBuffering) {
//            cycleScrollView.autoScroll = YES;
//            [self.playerView resetPlayer];
//            cycleScrollView.showPageControl = YES;
//            return;
//        }
//        [self.playerView resetPlayer];
//        cycleScrollView.autoScroll = NO;
//        ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
//        playerModel.scrollView = cycleScrollView.mainView;
//        playerModel.fatherViewTag = index;
//        playerModel.videoURL = [NSURL URLWithString:urlStr];
//        playerModel.indexPath = [NSIndexPath indexPathForItem:index inSection:0];
//        [self.playerView playerControlView:nil playerModel:playerModel];
//        [self.playerView autoPlayTheVideo];
//        self.playerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5f];
//        cycleScrollView.showPageControl = NO;
    }
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
//    if (self.playerView.state != ZFPlayerStatePlaying && self.playerView.state != ZFPlayerStateBuffering && !self.cycleScrollView.autoScroll) {
//        self.cycleScrollView.autoScroll = YES;
//        //        [self.playerView resetPlayer];
//        cycleScrollView.showPageControl = YES;
//    }
}

-(void)getImgData{
 
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    [parameters setObject:@"1" forKey:@"type"];
//    [parameters setObject:self.model.itemId forKey:@"id"];
    
    
    
    
    
    NSString *strUrl =[NSString stringWithFormat:@"{'id':'%@','type':'0'}",self.model.itemId];
    
    NSDictionary *parameter=@{@"data": strUrl};
    
    [[YKYNetWorking sharedYKYNetWorking] getWithURLString:[NSString stringWithFormat:@"https://h5api.m.taobao.com/h5/mtop.taobao.detail.getdesc/6.0/"] parameters:parameter success:^(NSDictionary * _Nonnull dictionary) {
//        NSLog(@"%@",dictionary[@"data"][@"wdescContent"][@"pages"]);
        
        NSArray *array = dictionary[@"data"][@"wdescContent"][@"pages"];
        for (NSString *string in array) {
            
            if (![string containsString:@"img"]) {
                return ;
            }
          NSArray *arr =  [string componentsSeparatedByString:@"//"];
            
            NSString *str = arr[1];
            str = [str substringToIndex:str.length -6];
            
            [self.bottomImagePaths addObject:[NSString stringWithFormat:@"http://%@",str]];
            
            [self.cellHeights addObject:@(0)];
        }
        
        [self.tableView reloadData];
        
        
    } failure:^(NSError * _Nullable error) {
        NSLog(@"error = %@",error);
    }];
}

-(void)homeBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    /*返回首页
     //
     NJAppDelegate *appDelegate = (NJAppDelegate *)[[UIApplication sharedApplication] delegate];
     GeeBaseTabBarViewController *tabViewController = (GeeBaseTabBarViewController *) appDelegate.window.rootViewController;
     [tabViewController setSelectedIndex:0];
     [self.navigationController popToRootViewControllerAnimated:YES];
     */
}

-(void)shareAction{
    
    
    
    __weak typeof(self) weakSelf = self;
    self.shareview.titleStr = @"测试";
    self.shareview.urlStr = @"www.baidu.com";
    [UIView animateWithDuration:0.5 animations:^{
        [weakSelf.view addSubview:self.shareview];
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)cancelPress
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        [weakSelf.shareview removeFromSuperview];
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}
-(void)enterBtnAction{
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:self.model.itemId forKey:@"itemId"];
    [parameters setObject:@"70000100c1444973e29993acf813ae5802f8b9c3f41e4fba870f2cd3ebad215ec48e0b31860238823" forKey:@"session"];
    [parameters setObject:@"105373350195" forKey:@"adzoneid"];
    [parameters setObject:@"2107908724" forKey:@"relationId"];
    [parameters setObject:@"386900424" forKey:@"siteId"];
    
    [[YKYNetWorking sharedYKYNetWorking] sendNetworkRequestURL:KAPIMobileHomeGetPrivilegeItemId param:parameters superView:self.view methodType:Get andBlock:^(id  _Nullable data, NSError * _Nullable error) {
        
//        NSLog(@"data = %@",data[@"data"][@"couponClickUrl"]);
        
        
        YKYWebViewViewController *VC = [[YKYWebViewViewController alloc]init];
        VC.urlString = @"https://uland.taobao.com/coupon/edetail?e=xuFRJCJAy00GQASttHIRqeNch%2BV9%2Ba%2FYRWLuGffBcetYTf%2B2Fz1JZw2AsxfxASdxeV4r6XCD0NDUFqdrXVEk2Nh9MuaGC%2B1pYyxqWCHQeiF4uQ43PWdAW%2Bdth9k8bqqSHKTgBzHkoM7XTQC0vfau6E%2F9Zk7cDx8UPY2GSU4OeGcupqlwXfJ%2B9KkQmKa%2B1uiF&traceId=0b01307115565324154741340e809c&union_lens=lensId:0b0840e9_0bde_16a688fcc33_6063&xId=gK8f70GlLEpkDfh7L0HUCrZfsu7th0EQNmYEHZVM15qVkopoimDQFeZ5Z44HUsxE2oDvXP9PgNDf5DRqsfhFip&relationId=2107908724u";
//        [self.navigationController pushViewController:VC animated:YES]; 
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"taobao://uland.taobao.com/coupon/edetail?e=xuFRJCJAy00GQASttHIRqeNch%2BV9%2Ba%2FYRWLuGffBcetYTf%2B2Fz1JZw2AsxfxASdxeV4r6XCD0NDUFqdrXVEk2Nh9MuaGC%2B1pYyxqWCHQeiF4uQ43PWdAW%2Bdth9k8bqqSHKTgBzHkoM7XTQC0vfau6E%2F9Zk7cDx8UPY2GSU4OeGcupqlwXfJ%2B9KkQmKa%2B1uiF&traceId=0b01307115565324154741340e809c&union_lens=lensId:0b0840e9_0bde_16a688fcc33_6063&xId=gK8f70GlLEpkDfh7L0HUCrZfsu7th0EQNmYEHZVM15qVkopoimDQFeZ5Z44HUsxE2oDvXP9PgNDf5DRqsfhFip&relationId=2107908724u"]];
        if (!error) {
            if ([NSString isNULLString:data[@"data"]]) {
                [MBProgressHUD showMessage:data[@"msg"] toView:self.view];
                
            }else{
               
            }
            
        }
        
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
