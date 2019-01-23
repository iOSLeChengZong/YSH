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
//根据UI
/** 返回状态码*/
@property(nonatomic,strong)NSString *codeState;
@property(nonatomic,strong)NSString *wxOpenID;
@property(nonatomic,strong)NSString *phoneNum;
@property(nonatomic,strong)NSString *verifyCode;

//根据接口
@property(nonatomic,strong)VerifyRegisterModel *registerModel;
//验证微信ID
-(void)getUserRegisterStateWithParameter:(NSString *)wxOpenID completionHandler:(void(^)(NSError *error))completionHandler;

//获取二维码
-(void)getVefifyCodeWithParameter:(NSString *)phoneNum completionHandler:(void(^)(NSError *error))completionHandler;

//请求登陆
-(void)requestLoginWithParameter:(NSString *)wxOpenID phoneNum:(NSString *)phoneNum completionHandler:(void(^)(NSError *error))completionHandler;

@end

NS_ASSUME_NONNULL_END
