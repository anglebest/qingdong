//
//  YKYbarView.h
//  ShengYa
//
//  Created by 王开政 on 2019/4/12.
//  Copyright © 2019年 Wkz. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YKYScrollBarDelegate<NSObject>

- (void)didSelect:(NSInteger)idx;

@end
@interface YKYbarView : UIScrollView


@property (nonatomic, strong) UIColor *generalColor;

@property (nonatomic, strong) UIColor *selectedColor;

@property (nonatomic, assign) BOOL becomeBigger;

@property (nonatomic, copy) NSArray<NSString *> *titles;

@property (nonatomic, copy) NSArray<NSString *> *descs;

@property (nonatomic, assign) NSInteger selectedIdx;

@property (nonatomic, weak) id<YKYScrollBarDelegate> njDelegate;
@end
