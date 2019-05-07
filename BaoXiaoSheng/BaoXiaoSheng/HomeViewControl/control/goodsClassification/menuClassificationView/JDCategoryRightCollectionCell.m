//
//  JDCategoryRightCollectionCell.m
//  分类列表联动
//
//  Created by yifo on 2018/8/3.
//  Copyright © 2018年 yanhaiqiang. All rights reserved.
//

#import "JDCategoryRightCollectionCell.h"

@interface JDCategoryRightCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *goodImageView;
@property (nonatomic, retain) UILabel *goodNameLabel;

@property (nonatomic, retain) UILabel *priceLabel;

@property (nonatomic, retain) UILabel *buyNumberLabel;
@end

@implementation JDCategoryRightCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 3;
        self.backgroundColor = [UIColor clearColor];
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    self.goodImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, self.width-25, self.width-25)];
    self.goodImageView.centerX = self.width/2;
    [self.contentView addSubview:self.goodImageView];
    self.goodImageView.backgroundColor = [UIColor clearColor];
    
    self.goodNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.goodImageView.frame) + 5, self.width-10, 20)];
    self.goodNameLabel.textAlignment = NSTextAlignmentCenter;
    self.goodNameLabel.textColor =kColor(83, 83, 83);
    self.goodNameLabel.text = @"";
    self.goodNameLabel.font = [UIFont systemFontOfSize:12*RATIO];
    [self.contentView addSubview:self.goodNameLabel];
    
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.goodImageView.frame) + 20, self.width/2, 20)];
    //    self.goodNameLabel.textAlignment = NSTextAlignmentCenter;
    self.priceLabel.textColor =[UIColor colorWithHexString:@"#DF0000"];
    self.priceLabel.font = [UIFont systemFontOfSize:10*RATIO];
    self.priceLabel.text = @"";
    [self.contentView addSubview:self.priceLabel];
    
    self.buyNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2, CGRectGetMaxY(self.goodImageView.frame) + 20, self.width/2, 20)];
    //    self.goodNameLabel.textAlignment = NSTextAlignmentCenter;
    self.buyNumberLabel.textColor =[UIColor colorWithHexString:@"#B0B0B0"];
    self.buyNumberLabel.font = [UIFont systemFontOfSize:10*RATIO];
    self.buyNumberLabel.text = @"";
    [self.contentView addSubview:self.buyNumberLabel];
}



@end

@interface JDCategoryRightHeaderView : UICollectionReusableView
@property (nonatomic, retain) UILabel *titleLabel;
@end

@implementation JDCategoryRightHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, self.width-30, 97)];
//    [self addSubview:imageView];
//    imageView.image = [UIImage imageNamed:@"banner.jpg"];
//
//    self.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15*RATIO, 0, self.width-10, 30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = titleLabel;
//    titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.textColor =kColor(50, 50, 50);
    titleLabel.font = KPFMFont(14);
//    titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
    [self addSubview:titleLabel];
    
}

@end

@interface JDCategoryRightCollectionCell ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UIButton *allBtn;

@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, strong) JDCategoryRightHeaderView *headerView;

@end

@implementation JDCategoryRightCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
       
        [self creatSubViews];
    }
    return self;
}
- (void)creatSubViews {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 0;
    CGFloat width = kScreenWidth - 100;
    flowLayout.itemSize = CGSizeMake((width-30)/2, width/2);
    flowLayout.headerReferenceSize = CGSizeMake(width, 30);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, width, kScreenHeight - SafeAreaTopHeight) collectionViewLayout:flowLayout];
    self.collectionView = collectionView;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [collectionView registerClass:NSClassFromString(@"JDCategoryRightCell") forCellWithReuseIdentifier:@"JDCategoryRightCell"];
    [collectionView registerClass:NSClassFromString(@"JDCategoryRightHeaderView")  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"JDCategoryRightHeaderView"];
    [self addSubview:collectionView];
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    
    NSLog(@"section%@",self.mutArray);
    return self.mutArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    NSLog(@"row%ld",[self.mutArray[section][@"info"] count]);
    return [self.mutArray[section][@"info"] count];
    
}
#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
  
    return UIEdgeInsetsMake(0, 10*RATIO,10*RATIO, 10*RATIO);//（上、左、下、右）
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JDCategoryRightCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JDCategoryRightCell" forIndexPath:indexPath];
    
    cell.goodNameLabel.text = [NSString stringWithFormat:@"%@", self.mutArray[indexPath.section][@"info"][indexPath.row][@"sonName"]];
    
//    cell.priceLabel.text = [NSString stringWithFormat:@"¥%@", self.mutArray[indexPath.section][@"data"][indexPath.row][@"goodsPrice"]];
    
//    NSString *string = self.mutArray[indexPath.section][@"shopInfo"][indexPath.row][@"goodsImg"];
//    pulicMath *math = [[pulicMath alloc]init];
//    if (![math isBlankString:string]) {
//
        [cell.goodImageView sd_setImageWithURL:[NSURL URLWithString:self.mutArray[indexPath.section][@"info"][indexPath.row][@"imgurl"]] placeholderImage:[UIImage imageNamed:@"head"] options:SDWebImageRetryFailed];
//    }
    
    
    
//     cell.buyNumberLabel.text = [NSString stringWithFormat:@"%@人付款", self.mutArray[indexPath.section][@"shopInfo"][indexPath.row][@"buyerNum"]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    return 0;
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        JDCategoryRightHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"JDCategoryRightHeaderView" forIndexPath:indexPath];
        self.headerView = headerView;
         self.headerView.titleLabel.text = self.mutArray[indexPath.section][@"nextName"];
        return headerView;
    } else {
        return 0;
    }
}
#pragma mark  点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.CellSelectedBlock) {
        self.CellSelectedBlock(indexPath);
    }
//    NSLog(@"%ld---------------------%ld",indexPath.section,indexPath.row);
}
- (void)setSectionTitle:(NSString *)sectionTitle {
    self.titleStr = sectionTitle;
    [self.collectionView reloadData];
}

- (void)setCount:(NSInteger)count {
    _count = count;
    [self.collectionView reloadData];
}

@end
