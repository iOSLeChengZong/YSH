//
//  VefifyRegisterViewModel.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/8.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDNetManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface VefifyRegisterViewModel : NSObject
YDSingletonH(VefifyRegisterViewModel)

//根据UI
/** 返回状态码*/
@property(nonatomic,strong)NSString *codeState;
@property(nonatomic,strong)NSString *wxOpenID;
/** 手机号码 */
@property(nonatomic,strong)NSString *phoneNum;
/** 验证码 */
@property(nonatomic,strong)NSString *verifyCode;
/** 用户ID */
@property(nonatomic,strong)NSString *userID;
/** tokenID */
@property(nonatomic,strong)NSString *tokenID;
/** 邀请码 */
@property(nonatomic,strong)NSString *inviteCode;
/** 用户pid */
@property(nonatomic,strong)NSString *userPID;
/** 用户金币 */
@property(nonatomic,strong)NSString *userGold;
/** 用户成长值 */
@property(nonatomic,strong)NSString *userGrowth;

//根据接口
@property(nonatomic,strong)VerifyRegisterModel *registerModel;
//验证微信ID
-(void)getUserRegisterStateWithParameter:(NSString *)wxOpenID completionHandler:(void(^)(NSError *error))completionHandler;

//获取二维码
-(void)getVefifyCodeWithParameter:(NSString *)phoneNum completionHandler:(void(^)(NSError *error))completionHandler;

//请求登陆
-(void)requestLoginWithParameter:(NSString *)wxOpenID phoneNum:(NSString *)phoneNum completionHandler:(void(^)(NSError *error))completionHandler;


//请求注册
-(void)requestRegisterWithInviteCode:(NSString *)code wxOpenID:(NSString *)openID userPhoneNum:(NSString *)phoneNum CompletionHandler:(void (^)(NSError * error))completionHandler;
@end

NS_ASSUME_NONNULL_END
