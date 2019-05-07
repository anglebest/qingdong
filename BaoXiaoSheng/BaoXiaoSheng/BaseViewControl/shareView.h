//
//  shareView.h
//  充电桩
//
//  Created by 王开政 on 2018/2/1.
//  Copyright © 2018年 李超杰. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^cancleSharePressBlock) ();
@interface shareView : UIView

@property(nonatomic, copy) cancleSharePressBlock cancleSharePress;


@property (nonatomic, retain) NSString *shareType;//分享类型； 1-资讯 ，2-购买，3，邀请  用于告诉后台


@property (nonatomic, retain) NSString *descriptionStr;
@property (nonatomic, retain) NSString *urlStr;
@property (nonatomic, retain) NSString *titleStr;
@property (nonatomic, retain) NSString *imageUrlStr;


@property(nonatomic,strong)UIButton *shareBut;
@property(nonatomic,strong)UIButton *cancelBut;

@property (nonatomic,retain) UIView *shareView;

@property(nonatomic,strong)UIButton *shareQRBut;
@property(nonatomic,strong)UIButton *shareQQBut;
@property(nonatomic,strong)UIButton *shareWXBut;
@property(nonatomic,strong)UIButton *shareWBBut;
@property(nonatomic,strong)UIButton *shareFriendsBut;

@property (nonatomic, retain) UILabel *shareQRLabel;
@property (nonatomic, retain) UILabel *shareTitleLabel;
@property (nonatomic, retain) UILabel *shareQQLabel;
@property (nonatomic, retain) UILabel *shareFriendsLabel;
@property (nonatomic, retain) UILabel *shareWXLabel;
@property (nonatomic, retain) UILabel *shareWBLabel;
@property (nonatomic, retain) UIView *coverView;


-(id)initFrame:(CGRect)frame;

-(void)shareQQPress;
-(void)shareFriendsPress;

-(void)shareWBPress;

-(void)shareWXPress;
@end
