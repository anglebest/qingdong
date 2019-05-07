//
//  YKYWebViewViewController.h
//  ShengYa
//
//  Created by apple on 2019/4/25.
//  Copyright © 2019 Wkz. All rights reserved.
//

#import "YKYBaseViewController.h"
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface YKYWebViewViewController : YKYBaseViewController
@property (nonatomic,strong)WKWebView * wkWebView;

@property (nonatomic,strong)NSString * titleString;

@property (nonatomic,strong)NSString * urlString;
@end

NS_ASSUME_NONNULL_END
