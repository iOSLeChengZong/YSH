//
//  VefifyRegisterViewModel.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/8.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "VefifyRegisterViewModel.h"

@implementation VefifyRegisterViewModel
YDSingletonM(VefifyRegisterViewModel)

-(NSString *)codeState{
    return self.registerModel.code;
}

-(NSString *)wxOpenID{
    return self.registerModel.rows1.userInfo.wxOpenId;
}

-(NSString *)phoneNum{
    return self.registerModel.rows1.userInfo.phone;
}

-(NSString *)verifyCode{
    return self.registerModel.verifyCode;
}

-(NSString *)userID{
    return self.registerModel.rows1.userInfo.ID;
}

-(NSString *)tokenID{
    return self.registerModel.rows1.token;
}

//验证用户
-(void)getUserRegisterStateWithParameter:(NSString *)wxOpenID completionHandler:(void (^)(NSError * _Nonnull))completionHandler{
    [YDNetManager verifyUserRegisterWithPath:kVerifyUserRegisterURL parameter:wxOpenID completionHandler:^(VerifyRegisterModel * _Nonnull model, NSError * _Nonnull error) {
        if (!error) {
            self.registerModel = model;
        }
        !completionHandler ?: completionHandler(error);
    }];
}


//获取验证码
-(void)getVefifyCodeWithParameter:(NSString *)phoneNum completionHandler:(void (^)(NSError * _Nonnull))completionHandler{
    
    [YDNetManager getVefifyCodeWithPath:kVerifyCodeURL parameter:phoneNum completionHandler:^(VerifyRegisterModel * _Nonnull model, NSError * _Nonnull error) {
        if (!error) {
            self.registerModel = model;
            
        }
        !completionHandler ?: completionHandler(error);
    }];
    
}

//请求登陆
-(void)requestLoginWithParameter:(NSString *)wxOpenID phoneNum:(NSString *)phoneNum completionHandler:(void (^)(NSError * _Nonnull))completionHandler{
    [YDNetManager requestLoginWithPath:kUserLoginURL wxOpenID:wxOpenID phoneNumber:phoneNum completionHandler:^(VerifyRegisterModel * _Nonnull model, NSError * _Nonnull error) {
        if (!error) {
            self.registerModel = model;
        }
        !completionHandler ?: completionHandler(error);
        
    }];
}

//请求注册
-(void)requestRegisterWithInviteCode:(NSString *)code CompletionHandler:(void (^)(NSError * _Nonnull))completionHandler{

    NSString *wxid = [[NSUserDefaults standardUserDefaults] stringForKey:kUserWxOpenID];
    NSString *phoneNum = [[NSUserDefaults standardUserDefaults] stringForKey:kUserPhoneNum];//[YDUserInfo sharedYDUserInfo].phoneNumber;
  
    [YDNetManager requestRegisterWithPath:kUserRegisterURL wxOpenID:wxid phoneNumber:phoneNum vefifyCode:[self verifyCode] tutorInviteCode:code completionHandler:^(VerifyRegisterModel * _Nonnull model, NSError * _Nonnull error) {
        if (!error) {
            self.registerModel = model;
        }
        !completionHandler ?: completionHandler(error);
    }];
}

@end
