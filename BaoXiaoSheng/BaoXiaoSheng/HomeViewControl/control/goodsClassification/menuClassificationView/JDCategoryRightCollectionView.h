//
//  JDCategoryRightCollectionView.h
//  分类列表联动
//
//  Created by yifo on 2018/8/3.
//  Copyright © 2018年 yanhaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDCategoryRightCollectionView : UICollectionView

@property (nonatomic, copy  ) void(^CellSelectedBlock)(NSIndexPath *indexPath);
@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) NSMutableArray *mutArray;
//回到顶部
-(void)scrollToTop;
@end
