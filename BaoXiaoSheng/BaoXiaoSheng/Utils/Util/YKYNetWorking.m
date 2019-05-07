//
//  YKYNetWorking.m
//  ShengYa
//
//  Created by 王开政 on 2019/4/12.
//  Copyright © 2019年 Wkz. All rights reserved.
//

#import "YKYNetWorking.h"
#import "YKYUserInfor.h"

#import "NSString+CommonYR.h"


@interface YKYNetWorking ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end
@implementation YKYNetWorking

singleton_m(YKYNetWorking);


#pragma mark -- GET请求 --
- (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(NSDictionary * dictionary))success
                 failure:(void (^)(NSError * error))failure {
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30;
//    NSLog(@"URLString = %@?%@",URLString,parameters);
    
    //    [manager.requestSerializer setValue:@"1.o" forHTTPHeaderField:@"_version"];
    //    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"_platform"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            
//            NSLog(@"responseObject = %@",responseObject);
            
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
}
#pragma mark -- POST请求 --
- (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(NSDictionary * dictionary))success
                  failure:(void (^)(NSError * error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30;
    //    [manager.requestSerializer setValue:@"1.o" forHTTPHeaderField:@"_version"];
    //    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"_platform"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
}
//static id _instance = nil;
//+ (instancetype)shared
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _instance = [[self alloc] init];
//    });
//    return _instance;
//}


- (AFHTTPSessionManager *)manager {
  
    
    _manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:KmainIP]];
    
   
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    _manager.requestSerializer.timeoutInterval = 30;
    // AFN默认不开启管道，这里手动开启
//    _manager.requestSerializer.HTTPShouldUsePipelining = YES;
//    [_manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
//    [_manager.requestSerializer setValue:@"www.beesgarden.cn" forHTTPHeaderField:@"Referer"];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    // 设置缓存策略，本地缓存无效时从服务器请求
    _manager.requestSerializer.cachePolicy = NSURLRequestReloadRevalidatingCacheData;
    [_manager.requestSerializer setHTTPShouldHandleCookies:YES];
//    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:@{@"say": @"juoliii"}];
//    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];

    return _manager;
}
-(void)sendNetworkRequestURL:(NSString *)url param:(NSDictionary *)params superView:(UIView *)superView methodType:(NetworkMethod)type andBlock:(AFNSuccessBlock)block{
    
    
    [self NJ_requestJsonDataWithPath:url withParams:params withMethodType:type autoShowError:YES autoShowIndicator:NO superView:superView andBlock:^(id data, NSError *error) {
        block(data, error);
    }];
    
    
}

#pragma mark - 基础请求函数

/**
 发起http请求
 
 @param aPath 请求url地址
 @param params 参数
 @param method 请求类型
 @param autoShowError 是否自动提示错误
 @param autoShowIndicator 是否自动展示加载框
 @param superView 提示框的父视图
 @param block 请求回调
 */
- (NSURLSessionDataTask *)NJ_requestJsonDataWithPath:(NSString *)aPath
                                          withParams:(id)params
                                      withMethodType:(NetworkMethod)method
                                       autoShowError:(BOOL)autoShowError
                                   autoShowIndicator:(BOOL)autoShowIndicator
                                           superView:(UIView *)superView
                                            andBlock:(void (^)(id _Nullable, NSError *_Nullable))block {
    if (!aPath || aPath.length <= 0) {
        return nil;
    }
    
    
    AFNetworkReachabilityManager *Rmanager = [AFNetworkReachabilityManager sharedManager];
    [Rmanager startMonitoring];
    
    [Rmanager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                //未知网络
                NSLog(@"未知网络");
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                //无法联网
                NSLog(@"无法联网");
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                //手机自带网络
                NSLog(@"当前使用的是2g/3g/4g网络");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                //WIFI
                NSLog(@"当前在WIFI网络下");
            }
                
        }
    }];
    //判断是否打开网络
    if (self.manager.reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable || self.manager.reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        [MBProgressHUD hideHUDForView:superView animated:NO];
        if (autoShowError) [MBProgressHUD showError:@"网络错误" toView:superView complication:nil];
        block(nil,[[NSError alloc]initWithDomain:KmainIP code:1004 userInfo:nil]);
        return nil;
    }
    //对params做处理
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:params];
    
    [dic setValue:[YKYUserInfor shared].token.length == 0? @"" : [YKYUserInfor shared].token forKey:@"auth_token"];
    
    
    NSString * timestamp = [NSString stringWithFormat:@"%lld",(long long)([NSDate new].timeIntervalSince1970*1000)];
    
    NSString * methodString = @"";
    if (method == Get) {
        methodString = @"GET";
    }else if (method == Post) {
        methodString = @"POST";
    }else if (method == Put) {
        methodString = @"PUT";
    }else if (method == Delete) {
        methodString = @"DELETE";
    }
    NSString * jsonString = [NSString stringWithFormat:@"%@&%@&%@",methodString,aPath,timestamp];
    
    NSString *sign = jsonString.md5Str;
    
    NSString * query = [NSString stringWithFormat:@"timestamp=%@&app_key=%@&app_sign=%@&auth_token=%@",timestamp,@"20180508",sign,[YKYUserInfor shared].token.length == 0? @"" : [YKYUserInfor shared].token];
    
//    NSLog(@"%@", self.manager.requestSerializer.HTTPRequestHeaders);
//    
//    NSLog(@"HTTPBody : %@", dic);
    
    if ([methodString isEqualToString:@"POST"] || [methodString isEqualToString:@"PUT"]) {
        if ([aPath rangeOfString:@"?"].location == NSNotFound) {
            aPath = [NSString stringWithFormat:@"%@?%@",aPath,query];
        } else {
            aPath = [NSString stringWithFormat:@"%@&%@",aPath,query];
        }
    }
    
    if (autoShowIndicator) {
        [MBProgressHUD showIndicatorWithView:superView];
    }
    NSLog(@"===。aPath%@",aPath);
    //发起请求
    switch (method) {
        case Get:{
            return [self.manager GET:aPath.stringByURLEncode parameters:dic progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//                NSLog(@"\n===========response===========\n%@%@==\n%@", self.manager.baseURL.absoluteString,aPath, responseObject);
                if (autoShowIndicator) {
                    [MBProgressHUD hideHUDForView:superView animated:NO];
                }
                id error = [self Response:responseObject autoShowError:autoShowError superView:superView];
                if (error) {
                    block([self checkNull:responseObject],error);
                }else {
                    block([self checkNull:responseObject], nil);
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"\n===========response===========\n%@%@:\n%@", self.manager.baseURL.absoluteString,aPath, error);
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *description = nil;
                    if (error.code == -1001) {
                        description = @"网络超时";
                    } else if (error.code == -1004){
                        description = @"服务器连接失败";
                    } else {
                        description = [error.userInfo objectForKey:@"NSLocalizedDescription"];
                    }
                    // 取消请求时不显示错误信息
                    if (error.code != -999) {
                        autoShowError?([MBProgressHUD hideHUDForView:superView animated:NO]):NO;
                        autoShowError?[MBProgressHUD showError:description toView:superView complication:nil]:nil;
                    }
                });
                block(nil, error);
            }];
            break;}
        case Post:{
            
            return [self.manager POST:aPath parameters:dic progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//                NSLog(@"\n===========response===========\n%@%@:\n%@", self.manager.baseURL.absoluteString,aPath, responseObject);
                if (autoShowIndicator) {
                    [MBProgressHUD hideHUDForView:superView animated:NO];
                }
                id error = [self Response:responseObject autoShowError:autoShowError superView:superView];
                
                if (error) {
                    block(nil, error);
                }else{
                    block([self checkNull:responseObject], nil);
                }
                
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"\n===========response===========\n%@%@:\n%@", self.manager.baseURL.absoluteString,aPath, error);
                NSString *description = nil;
                if (error.code == -1001) {
                    description = @"网络超时";
                } else if (error.code == -1004){
                    description = @"服务器连接失败";
                } else {
                    description = [error.userInfo objectForKey:@"NSLocalizedDescription"];
                }
                // 取消请求时不显示错误信息
                if (error.code != -999) {
                    autoShowError?[MBProgressHUD hideHUDForView:superView animated:NO]:NO;
                    autoShowError?[MBProgressHUD showError:description toView:superView complication:nil]:nil;
                }
                block(nil, error);
            }];
            break;}
        case Put:{
            return [self.manager PUT:aPath parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"\n===========response===========\n%@%@:\n%@", self.manager.baseURL.absoluteString,aPath, responseObject);
                if (autoShowIndicator) {
                    [MBProgressHUD hideHUDForView:superView animated:NO];
                }
                id error = [self Response:responseObject autoShowError:autoShowError superView:superView];
                if (error) {
                    block(nil, error);
                }else{
                    block([self checkNull:responseObject], nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"\n===========response===========\n%@%@:\n%@", self.manager.baseURL.absoluteString,aPath, error);
                NSString *description = nil;
                if (error.code == -1001) {
                    description = @"网络超时";
                } else if (error.code == -1004){
                    description = @"服务器连接失败";
                } else {
                    description = [error.userInfo objectForKey:@"NSLocalizedDescription"];
                }
                // 取消请求时不显示错误信息
                if (error.code != -999) {
                    autoShowError?[MBProgressHUD hideHUDForView:superView animated:NO]:NO;
                    autoShowError?[MBProgressHUD showError:description toView:superView complication:nil]:nil;
                }
                block(nil, error);
            }];
            break;}
        default:
            break;
    }
    return nil;
}

/**
 此处根据返回码做一些业务逻辑判断
 
 @param responseJSON 返回的json
 @param autoShowError 是否自动提示错误
 @param superView 展示提示框的父视图
 @return 错误,若数据无误，返回为空
 */
- (NSError *)Response:(id)responseJSON autoShowError:(BOOL)autoShowError superView:(UIView *)superView {
    NSError *error = nil;
//    NSNumber *resultCode = [responseJSON valueForKeyPath:@"flag"];
    NSNumber *status = [responseJSON valueForKeyPath:@"status"];
    if (status.integerValue != 200) {
        
        if ([NSString isNULLString:responseJSON[@"msg"]]) {
            [MBProgressHUD showMessage:responseJSON[@"msg"] toView:superView];
        }
//        if ([offLine isKindOfClass:[NSNumber classForCoder]] && offLine.integerValue == 1004) {
//            error = [NSError errorWithDomain:kDomain code:600 userInfo:@{NSLocalizedDescriptionKey:@"登录过期"}];
//        } else {
//            // 登录过期或未登录
//            error = [NSError errorWithDomain:kDomain code:600 userInfo:@{NSLocalizedDescriptionKey:[NJUserInfoManager shared].token?@"登录过期":@"您还未登录，请去登录"}];
//        }
//        [MBProgressHUD hideHUDForView:superView];
//        [[YKYUserInfor shared] setLoginState:UserOffLineByLogout];
//        [[YKYUserInfor shared] clearUserInfo];
        
//        UIViewController *controller = [superView CustomViewController];
//        if ([controller isKindOfClass:[NJBaseViewController class]]) {
//            [(NJBaseViewController *)controller loginViewController];
//        }else if ([controller isKindOfClass:[GeeHiddenViewController class]]){
//            [(GeeHiddenViewController *)controller loginViewController];
//        } else if ([controller isKindOfClass:[GeeBaseNavigationViewController class]]) {
//            [(GeeBaseNavigationViewController *)controller loginViewController];
//        }
    } else {
        
    }
    return error;
}
/**
 递归转换空数据
 
 @param data 数据
 */
- (id)checkNull:(id)data {
    if ([data isKindOfClass:[NSArray classForCoder]]) {
        NSMutableArray *array = [NSMutableArray array];
        for (id subData in (NSArray *)data) {
            [array addObject:[self checkNull:subData]];
        }
        data = array;
    } else if ([data isKindOfClass:[NSDictionary classForCoder]]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:data];
        NSArray *keys = ((NSDictionary *)dic).allKeys;
        for (id key in keys) {
            [dic setValue:[self checkNull:data[key]] forKey:key];
        }
        data = dic;
    } else if ([data isKindOfClass:[NSString classForCoder]]) {
        if ([NSString isNULLString:data]) {
            data = @"";
        }
        //            else if ([data isAmountNumber]) {
        //            data = [data accuracyString];
        //        }
    } else if ([data isKindOfClass:[NSNumber classForCoder]]) {
        NSString *doubleString = [NSString stringWithFormat:@"%lf", ((NSNumber *)data).doubleValue];
        NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
        data = decNumber;
    } else {
        data = @"";
    }
    return data;
}

/**
 转换字典(value)或数组集合中的数值类型为字符串
 
 @param dic 入参
 @return 返回值
 */
- (id)convertToStringStringDic:(id)dic {
    if ([dic isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        [mutDic enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSNumber class]]) {
                [dic setValue:[NSString stringWithFormat:@"%@", obj] forKey:key];
            } else if ([obj isKindOfClass:[NSDictionary class]]) {
                [mutDic setValue:[self convertToStringStringDic:[NSMutableDictionary dictionaryWithDictionary:obj]] forKey:key];
            } else if ([obj isKindOfClass:[NSArray class]]) {
                [mutDic setValue:[self convertToStringStringDic:[NSMutableArray arrayWithArray:obj]] forKey:key];
            }
        }];
    } else if ([dic isKindOfClass:[NSDictionary class]]) {
        NSMutableArray *mutArray = [NSMutableArray arrayWithArray:dic];
        [mutArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSNumber class]]) {
                [mutArray replaceObjectAtIndex:idx withObject:[NSString stringWithFormat:@"%@", obj]];
            } else if ([obj isKindOfClass:[NSDictionary class]]) {
                [mutArray replaceObjectAtIndex:idx withObject:[self convertToStringStringDic:[NSMutableArray arrayWithArray:obj]]];
            } else if ([obj isKindOfClass:[NSDictionary class]]) {
                [mutArray replaceObjectAtIndex:idx withObject:[self convertToStringStringDic:[NSMutableDictionary dictionaryWithDictionary:obj]]];
            }
        }];
    }
    return dic;
}
@end
