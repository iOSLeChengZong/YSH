//
//  YDNetManager.h
//  YDElectricity
//
//  Created by 元典 on 2018/11/26.
//  Copyright © 2018年 yuandian. All rights reserved.
//

//此类与NSObject+AFNetworking交互,获得请求数据,JSON转模型,并给viewModel提供对外接口

#import <Foundation/Foundation.h>
#import "HomeHeaderModel.h"
#import "HomeGoodModel.h"
#import "CategoryLeftMenuModel.h"
#import "CategoryRightMenuModel.h"
#import "VerifyRegisterModel.h"
#import "UserMessageModel.h"
#import "SecondSkillColumnModel.h"
#import "UserIdendityModel.h"
#import "UserOrderModel.h"
#import "UserTeamMemberModel.h"
#import "InviteRecordModel.h"
#import "UserMoneyModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface YDNetManager : NSObject

//第一次数据测试
+ (id)getTestDataWithPath:(NSString *)path page:(NSInteger)page  goodsStatus:(NSInteger)status completionHandler:(void(^)(id model ,NSError *error))completionHandler;

//搜索功能
+ (id)search:(NSString *)words completionHandler:(void(^)(id model,NSError *error))completionHandler;

//首页数据分为两次请求
//1.请求头部数据
+ (id)getHomeHeaderDataWithPath:(NSString *)path completionHandler:(void(^)(HomeHeaderModel *model,NSError *error))completionHandler;

//2.
/**
 请求首页商品数据

 @param path 请求路径
 @param page 请求页数
 @param goodNum 请求数量
 @param state 是热销,还是人气
 @param completionHandler 回调
 @return 模型数据
 */
+ (id)getHomeGoodListDataWithPath:(NSString *)path pageNum:(NSInteger)page goodNum:(NSInteger)goodNum state:(NSInteger)state completionHandler:(void(^)(HomeGoodModel *model,NSError *error))completionHandler;


//获取分类数据
+ (id)getCategortyLeftDataWithPath:(NSString *)path completionHandler:(void(^)(CategoryLeftMenuModel *model,NSError *error))completionHandler;
+ (id)getCategoryRightDataWithPath:(NSString *)path parameter:(NSString *)parameter completionHandler:(void(^)(CategoryRightMenuModel *model,NSError *error))completionHandler;

/** 分类获取商品列表 */
+ (id)getCategoryCommodityListDataWithPath:(NSString *)path requestWord:(NSString *)requestW requestPram:(NSString *)pra classIDWord:(NSString *)classIDW classID:(NSString *)ID pageNum:(NSInteger)page goodNum:(NSInteger)goodNum completionHandler:(void(^)(HomeGoodModel *model,NSError *error))completionHandler;


/** 获取首页栏目商品列表  9.9元特区等*/



//test
+ (id)getShopInfoWithPath:(NSString *)path param:(NSString *)params completionHandler:(void(^)(id model,NSError *error))completionHandler;



//验证用户是否注册
+ (id)verifyUserRegisterWithPath:(NSString *)path parameter:(NSString *)openID completionHandler:(void(^)(VerifyRegisterModel *model,NSError *error))completionHandler;

/** 获取手机验证码 */
+ (id)getVefifyCodeWithPath:(NSString *)path parameter:(NSString *)phoneNumber completionHandler:(void(^)(VerifyRegisterModel *model,NSError *error))completionHandler;

/** 用户注册 */
+ (id)requestRegisterWithPath:(NSString *)path wxOpenID:(NSString *)openID phoneNumber:(NSString *)phoneNum vefifyCode:(NSString *)vefifyCode tutorInviteCode:(NSString *)inviteCode completionHandler:(void(^)(VerifyRegisterModel *model,NSError *error))completionHandler;

/** 用户登陆 */
+(id)requestLoginWithPath:(NSString *)path wxOpenID:(NSString *)openID phoneNumber:(NSString *)phoneNum completionHandler:(void(^)(VerifyRegisterModel *model,NSError *error))completionHandler;

/** 上传图片 */
+ (void)uploadHeaderImageWithUploadParam:(NSArray <UploadParam *> *)uploadParams completionHandler:(void(^)(VerifyRegisterModel *model,NSError *error))completionHandler;

/** 更改用户资料 */
+(id)uploadUserInfoPrameter:(id)parameter completionHandler:(void(^)(VerifyRegisterModel *model ,NSError *error))completionHandler;

/*获取用户资料*/

/** 获取系统消息 */
+(id)getSystemUserMessageWithPath:(NSString *)path pageNum:(NSInteger)page pageSize:(NSInteger)size userID:(NSString *)userID completionHandler:(void(^)(UserMessageModel *model,NSError *error))completionHandler;


/** 秒杀商品 */
+(id)getSecondSkillGoodListWithTimeInterverl:(NSString *)time pageNum:(NSInteger)page pageSize:(NSInteger)size completionHandler:(void(^)(SecondSkillColumnModel *model,NSError *error))completionHandler;

/** 记录用户登陆情况 */
+(void)postUserLogCompletionHandler:(void(^)(NSError *error))completionHandler;

/** 查询用户基本信息 */
+(void)postUserIdendityCompletionHandler:(void(^)(UserIdendityModel *model,NSError *error))comletionHandler;

/** 查询订单 */
+(id)getUserOrderlistPageNum:(NSInteger)page pageSize:(NSInteger)size userPid:(NSString *)pid orderType:(NSString *)type CompletionHandler:(void(^)(UserOrderModel *model,NSError *error))completionHandler;

/** 意见反馈 */
+(void)postUserIdearReponseWithIdearType:(NSString *)iType idearContent:(NSString *)icontent contactMethod:(NSString *)cmethod idearImages:(NSArray<UploadParam *> *)iImages progress:(void(^)(NSProgress * progress))progress CompletionHandler:(void(^)(VerifyRegisterModel *model,NSError *error))completionHandler;

/** 用户资金 */
+(id)getUserMoneyInfoCompletionHandler:(void(^)(UserMoneyModel *model,NSError *error))completionHandler;

/** 团队成员*/
+(id)getTemaMemberCompletionHandler:(void(^)(UserTeamMemberModel *model,NSError *error))completionHandler;

/** 邀请记录 */
+(id)getUserInviteRecordWithPageNumber:(NSInteger)page pageSize:(NSInteger)size orderType:(NSString *)type addTime:(NSString *)time completionHandler:(void(^)(InviteRecordModel *model,NSError *error))completionHandler;

@end



NS_ASSUME_NONNULL_END
