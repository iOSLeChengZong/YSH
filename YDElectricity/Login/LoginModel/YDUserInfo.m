//
//  YDUserInfo.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/8.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "YDUserInfo.h"
#import "YDNetManager.h"

@implementation YDUserInfo
YDSingletonM(YDUserInfo)

-(void)requestRegisterCompletionHandler:(void (^)(VerifyRegisterModel * _Nonnull,NSError * _Nonnull))completionHandler{
    
    [YDNetManager requestRegisterWithPath:kUserRegisterURL wxOpenID:self.userWxOpenID phoneNumber:self.phoneNumber vefifyCode:self.userVerifyCode tutorInviteCode:self.tutorInviteCode completionHandler:^(VerifyRegisterModel * _Nonnull model, NSError * _Nonnull error) {
        if (!error) {
            !completionHandler ?: completionHandler(model,error);
        }
    }];
}

-(void)requestLoginCompletionHandler:(void (^)(VerifyRegisterModel * _Nonnull, NSError * _Nonnull))completionHandler{
    
    [YDNetManager requestLoginWithPath:kUserLoginURL wxOpenID:self.userWxOpenID phoneNumber:self.phoneNumber completionHandler:^(VerifyRegisterModel * _Nonnull model, NSError * _Nonnull error) {
        if (!error) {
            !completionHandler ?: completionHandler(model,error);
        }
    }];
}


//本地头像
-(UIImage *)getUserHeaderImage{
    //从沙盒拿
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    if ([fileManager fileExistsAtPath:fullPath]) {
        UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
        return savedImage;
    }
    return nil;
}



@end
