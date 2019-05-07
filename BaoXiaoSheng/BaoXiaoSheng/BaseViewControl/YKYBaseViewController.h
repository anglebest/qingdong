//
//  YKYBaseViewController.h
//  ShengYa
//
//  Created by 王开政 on 2019/4/11.
//  Copyright © 2019年 Wkz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKYBaseViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>


/**
 页数
 */
@property (nonatomic, assign) NSInteger pageNumer;


@property (nonatomic, assign) NSInteger min_id;

/**
 每页数量
 */
@property (nonatomic, assign) NSInteger pageSize;
@end
