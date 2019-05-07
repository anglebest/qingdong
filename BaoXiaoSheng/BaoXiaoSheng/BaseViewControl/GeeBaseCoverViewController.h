//
//  NJBaseCoverViewController.h
//  Beesgarden
//
//  Created by 张阳 on 2018/4/19.
//  Copyright © 2018年 ningjukeji. All rights reserved.
//

#import <UIKit/UIKit.h>


//用于显示弹窗试图类型
typedef NS_ENUM(NSInteger,GlobalCoverVCType) {
    
    GlobalCoverVCTypeShopOwner,//是否立即成为店主
    GlobalCoverVCTypeInviteCode,//邀请码
    GlobalCoverVCTypeCustomerService,//客服设置
    GlobalCoverVCTypeSuperSearch,//超级搜索
    GlobalCoverVCTypeVIPSeePermissions,//VIP视频观看权限
    GlobalCoverVCTypeNectarShare//采蜜不支持直接查看的弹框
};

typedef NS_ENUM(NSInteger,CoverViewButtonType) {
    
    CoverViewButtonTypeMakeShopOwner,//成为店主
    CoverViewButtonTypeMakeInviteCode,//完成邀请
    CoverViewButtonTypeMakeSuccessAccount,//客服设置确定
    CoverViewButtonTypeMakeCancelAccount,//客服设置取消
    CoverViewButtonTypemakeSuperSearchTB,//超级搜淘宝
    CoverViewButtonTypemakeSuperSearchJD,//超级搜京东
    CoverViewButtonTypemakeSuperSearchMGJ,//超级搜蘑菇街
    CoverViewButtonTypemakeVIPSuccess,//vip视频权限
    CoverViewButtonTypemakeVIPCancel,//vip视频取消
    CoverViewButtonTypemakeNectarShare,//立即分享至微信
};

typedef void(^CoverViewButtonBlock)(CoverViewButtonType type,NSString *string);//点击一个选项的回调

@interface GeeBaseCoverViewController : UIViewController

@property (nonatomic ,strong) NSString *cString;

@property (nonatomic , copy) CoverViewButtonBlock coverButtonType;

@property (nonatomic , assign) GlobalCoverVCType GlobalCoverVCType;


@property (nonatomic,copy) void (^dismissCoverBtnBlock) (void);
@end
