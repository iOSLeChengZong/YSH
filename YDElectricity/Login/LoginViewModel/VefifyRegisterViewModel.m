//
//  VefifyRegisterViewModel.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/8.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "VefifyRegisterViewModel.h"

@implementation VefifyRegisterViewModel

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



-(void)getUserRegisterStateWithParameter:(NSString *)wxOpenID completionHandler:(void (^)(NSError * _Nonnull))completionHandler{
    [YDNetManager verifyUserRegisterWithPath:kVerifyUserRegisterURL parameter:wxOpenID completionHandler:^(VerifyRegisterModel * _Nonnull model, NSError * _Nonnull error) {
        if (!error) {
            self.registerModel = model;
            !completionHandler ?: completionHandler(error);
        }
    }];
}

-(void)getVefifyCodeWithParameter:(NSString *)phoneNum completionHandler:(void (^)(NSError * _Nonnull))completionHandler{
    
    [YDNetManager getVefifyCodeWithPath:kVerifyCodeURL parameter:phoneNum completionHandler:^(VerifyRegisterModel * _Nonnull model, NSError * _Nonnull error) {
        if (!error) {
            self.registerModel = model;
            !completionHandler ?: completionHandler(error);
        }
    }];
    
}

-(void)requestLoginWithParameter:(NSString *)wxOpenID phoneNum:(NSString *)phoneNum completionHandler:(void (^)(NSError * _Nonnull))completionHandler{
    [YDNetManager requestLoginWithPath:kUserLoginURL wxOpenID:wxOpenID phoneNumber:phoneNum completionHandler:^(VerifyRegisterModel * _Nonnull model, NSError * _Nonnull error) {
        if (!error) {
            self.registerModel = model;
            !completionHandler ?: completionHandler(error);
        }
        
    }];
}

@end
