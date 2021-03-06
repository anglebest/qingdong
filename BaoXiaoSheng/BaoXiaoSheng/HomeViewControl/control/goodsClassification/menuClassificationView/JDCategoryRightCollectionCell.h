//
//  JDCategoryRightCollectionCell.h
//  分类列表联动
//
//  Created by yifo on 2018/8/3.
//  Copyright © 2018年 yanhaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDCategoryRightCollectionCell : UICollectionViewCell
@property (nonatomic, copy  ) void(^CellSelectedBlock)(NSIndexPath *indexPath);
@property (nonatomic, strong) NSString *sectionTitle;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSMutableArray *mutArray;

@property (nonatomic, strong) UICollectionView *collectionView;
@end
