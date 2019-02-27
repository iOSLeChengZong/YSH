//
//  UserIdendityViewModel.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/17.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDNetManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserIdendityViewModel : NSObject
YDSingletonH(UserIdendityModel)
//根据UI
/** 用户昵称 */
-(NSString *)userNickName;
/** 用户等级 */
-(NSString *)userRankName;
/** 用户pid */
-(NSString *)userPid;
/** 用户头像 */
-(NSURL *)userHeadImageURL;
/** 用户生日 */
-(NSString *)userBirthday;
/** 用户性别 */
-(NSString *)userSex;
/** 用户地区 */
-(NSString *)userArea;
/** 用户详细地址 */
-(NSString *)userDetailAddress;
/** 用户成长值 */
-(NSString *)userGrowth;
/** 用户成长值比例 */
-(CGFloat)userGrowthScale;
/** 用户成长值距下一个还差 */
-(NSString *)lessThanNextRank;

/** 获取消费者图片*/
-(UIImage *)getCustomerImage;
/** 获取消费者名称颜色 */
-(UIColor *)getCustomerNameColor;
/** 到创业者比例 */
-(CGFloat)toBusinessScale;

/** 获取创业者图片 */
-(UIImage *)getBusinessImage;
/** 获取创业者名称颜色 */
-(UIColor *)getBusinessNameColor;
/** 到总经理比例 */
-(CGFloat)toManagerScale;

/** 获取总经理图片 */
-(UIImage *)getManagerImage;
/** 获取总经理名称颜色 */
-(UIColor *)getManagerNameColor;
/** 到合伙人比例 */
-(CGFloat)toPartnerScale;

/** 获取合伙人图片 */
-(UIImage *)getPartnerImage;
/** 获取合伙人名称颜色 */
-(UIColor *)getPartnerNameColor;

//根据接口
@property(strong,nonatomic)UserIdendityInfoInfo *info;
-(void)getUserIdendityCompletionHandler:(void(^)(NSError *error))completionHandler;
@end

NS_ASSUME_NONNULL_END
