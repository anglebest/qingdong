//
//  Header.h
//  ShengYa
//
//  Created by 王开政 on 2019/4/11.
//  Copyright © 2019年 Wkz. All rights reserved.
//

#ifndef Header_h
#define Header_h

// 全局宏声明
#define kStateBarHeight ([UIApplication sharedApplication].statusBarFrame.size.height)
#define kTabBarHeight (kAppDelegate.tabBarController.tabBar.frame.size.height)

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define kCOLOR_RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]


#define kColor(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]




// 应用内尺寸比例
#define RATIO ([NSString stringWithFormat:@"%.1f",[UIScreen mainScreen].bounds.size.width/375.f].floatValue)

//屏幕的适配
#define kWidth(x) ((x)*(kScreenWidth)/375.0)
#define kHeight(y) ((y)*(kScreenHeight)/667.0)

//iphone x
#define SafeAreaBottomHeight (kScreenHeight >= 812 ? 49+34 : 49)
#define SafeAreaTopHeight (kScreenHeight >= 812 ? 88 : 64)

//代理
#define kAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)


//弱引用

#define KNJWeakself __weak typeof(self) weakSelf = self


#define KFont(x) [UIFont systemFontOfSize:x]

#define KPFFont(x) [UIFont fontWithName:@"PingFangSC-Regular" size:x* RATIO]

#define KPFMFont(x) [UIFont fontWithName:@"PingFangSC-Medium" size:x* RATIO]

#define KDIBFont(x) [UIFont fontWithName:@"DINAlternate-Bold" size:x* RATIO]

#define KSHFont(x) [UIFont fontWithName:@"SourceHanSansCN-Regular" size:x* RATIO]


#define KmainIP @"http://47.98.132.55:8892"



//首页获取商品分类
#define KAPIMobileHomeGetClassify @"mobile/home/getClassify"

//根据首页类目查询商品列表
#define KAPIMobileHomeGetClassifyItemList @"mobile/home/getClassifyItemList"


//查询粘贴板的商品
#define KAPIMobileHomegetPopup @"mobile/home/getPopup"


//根据关键词返回商品列表信息.只有点击分类用到
#define KAPIMobileHomeSearchKey @"mobile/home/SearchKey"

//Eco-商品标题-超级搜索 其他用超级搜
#define KAPIMobileHomeSearchSuperTitle @"mobile/home/SearchSuperTitle"

//简介：目前一页返回全部昨天热搜词
#define KAPIMobileHomeGetHotKey @"mobile/home/getHotKey"

//获取超级分类
#define KAPIMobileHomeGetSuperClassify @"mobile/home/getSuperClassify"

//根据商品ID进行高佣转链
#define KAPIMobileHomeGetPrivilegeItemId @"mobile/home/getPrivilegeItemId"

//淘宝-猜你喜欢
#define KAPIMobileHomeGetSimilarInfo2 @"mobile/home/getSimilarInfo2"




#endif /* Header_h */
