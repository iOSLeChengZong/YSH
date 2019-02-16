//
//  UserIdendityViewModel.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/17.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "UserIdendityViewModel.h"

@implementation UserIdendityViewModel
//头像地址
-(NSURL *)userHeadImageURL{
    NSString *str = self.info.headImgUrl;
    
    if ([str containsString:@"http"]) {
        return [NSURL URLWithString:str];
    }else{
        return [NSURL URLWithString:[kBaseURL1 stringByAppendingString:str]];
    }
}

//用户昵称
-(NSString *)userNickName
{
    return self.info.nickName;
}

//用户生日

//用户性别

//用户地区

//用户详细地址

//用户身份
-(NSString *)userRankName{
    switch (self.info.gradeId) {
        case 1:
            return @"消费者";
            break;
            
        default:
            return @"无";
            break;
    }
}

-(NSString *)userPid{
    return self.info.pid;
}



-(void)getUserIdendityCompletionHandler:(void (^)(NSError * _Nonnull))completionHandler{
    [YDNetManager postUserIdendityCompletionHandler:^(UserIdendityModel * _Nonnull model, NSError * _Nonnull error) {
        if (!error) {
            self.info = model.info;
            !completionHandler ?: completionHandler(error);
        }else{
            !completionHandler ?: completionHandler(error);
        }
        
    }];
}
@end
