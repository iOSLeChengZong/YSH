//
//  YDUserInfo.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/8.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VerifyRegisterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YDUserInfo : NSObject
YDSingletonH(YDUserInfo)
/** 微信昵称 **/
@property (nonatomic, copy)NSString *userName;
/** 密码 **/
@property (nonatomic, copy)NSString *userPasswd;
/** 注册的wxOpenID */
@property (nonatomic, copy)NSString *userWxOpenID;
/** 微信密钥 */
@property (nonatomic,copy)NSString *wxSecrect;
/**手机号吗*/
@property (nonatomic,copy)NSString *phoneNumber;
/** 手机验证码 */
@property (nonatomic, copy)NSString *userVerifyCode;

/** 导师邀请码 */
@property(nonatomic,copy)NSString *tutorInviteCode;
/** token*/
@property(nonatomic,copy)NSString *userToken;
@property(nonatomic,copy)NSString *userID;

/** 区分登录 还是注册 */
@property (nonatomic, assign,getter=isLogin) BOOL login;
/** 提供一个获取当前用户jidStr */
@property (nonatomic, copy, readonly) NSString* jidStr;
/** 标记是微信登陆 */
@property (nonatomic, assign) BOOL wxLogin;

-(void)requestRegisterCompletionHandler:(void(^)(VerifyRegisterModel *model,NSError *error))completionHandler;
-(void)requestLoginCompletionHandler:(void(^)(VerifyRegisterModel *model,NSError *error))completionHandler;

@end

NS_ASSUME_NONNULL_END
