//
//  SDUpdate.m
//  SDUpdate
//
//  Created by 宋东昊 on 2017/2/15.
//  Copyright © 2017年 songdh. All rights reserved.
//

#import "SDUpdate.h"
#import <StoreKit/StoreKit.h>
#import "AFHTTPSessionManager.h"

@implementation SDAppstoreInfo
- (instancetype)initWithDictionary:(NSDictionary*)dictionary
{
    if (self = [super init]) {
        if (!dictionary || dictionary.count <= 0) {
            return nil;
        }
        _version = dictionary[@"ios"];
        
        _releaseNotes = dictionary[@"iosDesc"];
    }
    return self;
}
@end


@interface SDUpdate ()<SKStoreProductViewControllerDelegate>

@end

@implementation SDUpdate

+(SDUpdate*)shareInstance
{
    static dispatch_once_t once;
    static id __singleton__;
    dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } );
    return __singleton__;
}


-(instancetype)init
{
    if (self = [super init]) {
        _remindDay = 3;
    }
    return self;
}

-(void)begin
{
    __weak __typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSAssert(weakSelf.appleID.length > 0, @"you must give \'appleID\' a value");
        NSAssert(weakSelf.curAppVersion.length > 0, @"you must give \'curAppVersion\' a value");
        
        SDAppstoreInfo *updateInfo = [weakSelf updateInfo];
        
        [weakSelf updateAppWithInfo:updateInfo];
    });
}


/**
 * 从appstore获取app的信息
 */
-(SDAppstoreInfo*)updateInfo
{
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.beesgarden.cn/upgrade/upload.json"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    if (!data) {
        return nil;
    }
    NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *appInfos = responseObject[@"detail"];
    if (!appInfos) {
        return nil;
    }
    
    SDAppstoreInfo *appstoreInfo = [[SDAppstoreInfo alloc]initWithDictionary:appInfos];
    return appstoreInfo;
}

/**
 * 根据app信息判断当前版本是否需要升级，以及升级逻辑
 */
- (void)updateAppWithInfo:(SDAppstoreInfo *)updateInfo
{
    if (!updateInfo) {
        return;
    }
    
    BOOL isUpdate = NO;
    if ([self.curAppVersion compare:updateInfo.version options:NSNumericSearch] == NSOrderedAscending) {
        isUpdate = YES;
    }

    if (isUpdate) {
        //需要升级
        if ([sdUD boolForKey:@"ignoreVersion"]) {
            //忽略此版本，不需要
            NSLog(@"用户忽略此版本");
            return;
        }
        NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
        NSTimeInterval savedInterval = [sdUD doubleForKey:@"newVersionTime"];
        
        NSString *title = [NSString stringWithFormat:@"有新版本%@",updateInfo.version];
        
        //选择稍后，默认为3天后提示>
        if (timeInterval - savedInterval > self.remindDay*24*60*60) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:updateInfo.releaseNotes preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"稍后提醒我" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    //稍后提醒 记录下当前时间
                    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
                    [sdUD setDouble:timeInterval forKey:@"newVersionTime"];
                    
                }];
                
                if (!self.isForcedUpdate) {
                    [alertController addAction:cancelAction];
                }
                
                UIAlertAction *updateAction = [UIAlertAction actionWithTitle:@"去升级" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //去升级
                    SKStoreProductViewController *storeViewController = [[SKStoreProductViewController alloc] init];
                    
                    [storeViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:self.appleID} completionBlock:nil];
                    storeViewController.delegate = self;
                    [self.controller presentViewController:storeViewController animated:YES completion:nil];
                    
                }];
                [alertController addAction:updateAction];
                
                UIAlertAction *laterAction = [UIAlertAction actionWithTitle:@"忽略此版本" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [sdUD setBool:YES forKey:@"ignoreVersion"];
                }];
                
                if (!self.isForcedUpdate) {
                    [alertController addAction:laterAction];
                }
                
                
                if (self.controller) {
                    [self.controller presentViewController:alertController animated:YES completion:nil];
                }else{
                    NSLog(@"Error:controller is nil, and the update alertController can not be shown!");
                }
            });
            
        }else{
            NSLog(@"稍后提醒，未到提醒时间");
        }
    }else {
        NSLog(@"当前版本已是最新，不需要升级");
        //重置升级标识
        [sdUD removeObjectForKey:@"ignoreVersion"];
        [sdUD removeObjectForKey:@"newVersionTime"];
        
    }
}

#pragma mark - SKStoreProductViewControllerDelegate
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    if (self.isForcedUpdate) {
        [self begin];
    }
    [viewController dismissViewControllerAnimated:YES completion:nil];
}
@end
