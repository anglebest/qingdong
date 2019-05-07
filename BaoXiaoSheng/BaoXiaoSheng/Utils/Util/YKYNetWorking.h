//
//  YKYNetWorking.h
//  ShengYa
//
//  Created by 王开政 on 2019/4/12.
//  Copyright © 2019年 Wkz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

#import "Singleton.h"

typedef void(^AFNSuccessBlock)(id _Nullable data,NSError * _Nullable error);

typedef enum {
    Get = 0,
    Post,
    Put,
    Delete
} NetworkMethod;

@interface YKYNetWorking : NSObject

singleton_h(YKYNetWorking);
- (void)getWithURLString:(NSString *_Nullable)URLString
              parameters:(id)parameters
                 success:(void (^_Nullable)(NSDictionary * _Nonnull dictionary))success
                 failure:(void (^_Nullable)(NSError * _Nullable error))failure ;

- (void)postWithURLString:(NSString *_Nullable)URLString
               parameters:(id _Nullable )parameters
                  success:(void (^_Nullable)(NSDictionary * _Nullable dictionary))success
                  failure:(void (^_Nullable)(NSError * _Nullable error))failure;
/**
@param params 参数
@param superView 提示框的父视图
@param block 请求回调
*/
- (void)sendNetworkRequestURL:(NSString *_Nullable)url param:(NSDictionary *_Nullable)params
                 superView:(UIView *_Nullable)superView methodType:(NetworkMethod)type
              andBlock:(AFNSuccessBlock _Nullable )block;






@end
