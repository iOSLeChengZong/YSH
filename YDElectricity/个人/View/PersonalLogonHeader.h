//
//  PersonalLogonHeader.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/30.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,PersonalLogonHeaderClick) {
    PersonalLogonHeaderClickMessage,//系统消息
    PersonalLogonHeaderClickEditor,//编辑资料
    PersonalLogonHeaderClickLogin,//去登陆
    PersonalLogonHeaderClickOrder,//我的订单
    
};

NS_ASSUME_NONNULL_BEGIN

@interface PersonalLogonHeader : UICollectionReusableView

@property(nonatomic,strong)NSString *nickName;
@property(nonatomic,strong)NSString *ranckName;
@property(nonatomic,strong)NSURL *imageUrl;



@property(nonatomic,copy) void(^personalClickHander)(PersonalLogonHeaderClick);
-(void)addClickHandler:(void(^)(PersonalLogonHeaderClick click))handler;

@end

NS_ASSUME_NONNULL_END
