//
//  NJTextView.h
//  Beesgarden
//
//  Created by 张阳 on 2018/4/19.
//  Copyright © 2018年 ningjukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeeTextView : UITextView
/**
 *  占位文字
 */
@property (nonatomic, copy) NSString *placeholder;
/**
 *  占位文字颜色
 */
@property (nonatomic, strong) UIColor *placeholderColor;

/**
 是否需要垂直居中
 */
@property (nonatomic,assign) BOOL isCenter;

@end
