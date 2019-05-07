//
//  YKYGoodsListViewController.h
//  ShengYa
//
//  Created by apple on 2019/4/17.
//  Copyright © 2019 Wkz. All rights reserved.
//

#import "YKYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YKYGoodsListViewController : YKYBaseViewController
@property (nonatomic, strong) NSString *tip;


@property (nonatomic, strong) NSString *type;//1是从分类传的用关键词搜，其他用超级搜。
@end

NS_ASSUME_NONNULL_END
