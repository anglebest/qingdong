//
//  YKYUserInforModel.m
//  ShengYa
//
//  Created by 王开政 on 2019/4/12.
//  Copyright © 2019年 Wkz. All rights reserved.
//

#import "YKYUserInforModel.h"
@interface YKYUserInforModel () {
    NSString *_rolecode;
}

@end
@implementation YKYUserInforModel
@dynamic rolecode;


- (void)setRolecode:(NSString *)rolecode{
    
    if ([@[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7"] containsObject:rolecode] || !rolecode) {
        _rolecode = rolecode;
    } else {
        if ([@"admin" isEqualToString:rolecode.lowercaseString]) {
            _rolecode = @"1";
        } else if ([@"shopkeeper" isEqualToString:rolecode.lowercaseString]) {
            _rolecode = @"2";
        } else if ([@"manager" isEqualToString:rolecode.lowercaseString]) {
            _rolecode = @"3";
        } else if ([@"buyer" isEqualToString:rolecode.lowercaseString]) {
            _rolecode = @"4";
        } else if ([@"console" isEqualToString:rolecode.lowercaseString]) {
            _rolecode = @"5";
        } else if ([@"seller" isEqualToString:rolecode.lowercaseString]) {
            _rolecode = @"6";
        } else if ([@"agent" isEqualToString:rolecode.lowercaseString]) {
            _rolecode = @"7";
        } else {
            _rolecode = @"0";
        }
    }
}

- (NSString *)rolecode {
    if (!_rolecode) {
        _rolecode = @"4";
    }
    return _rolecode;
}

@end
