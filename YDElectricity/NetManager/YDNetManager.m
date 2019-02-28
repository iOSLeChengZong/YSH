//
//  YDNetManager.m
//  YDElectricity
//
//  Created by 元典 on 2018/11/26.
//  Copyright © 2018年 yuandian. All rights reserved.
//

#import "YDNetManager.h"

@implementation YDNetManager
+(id)search:(NSString *)words completionHandler:(void (^)(id _Nonnull, NSError * _Nonnull))completionHandler{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:@"" forKey:@""];
    //防止words为空
    [params setObject:words ?: @"" forKey:@"p[key]"];
    return [self POST:@"" parameters:params progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        !completionHandler ?: completionHandler(responseObj,error);
    }];

}

+(id)getTestDataWithPath:(NSString *)path page:(NSInteger)page goodsStatus:(NSInteger)status completionHandler:(void (^)(id _Nonnull, NSError * _Nonnull))completionHandler{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInteger:status] forKey:@"goodsStatus"];
    return [self GET:path parameters:params progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            NSLog(@"model:%@",responseObj);
        }else{
            NSLog(@"?????????");
        }
    }];
}


+(id)getHomeHeaderDataWithPath:(NSString *)path completionHandler:(void (^)(HomeHeaderModel * _Nonnull, NSError * _Nonnull))completionHandler{
    return [self POST:path parameters:nil progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            !completionHandler ?: completionHandler([HomeHeaderModel parse:responseObj],error);
        }
    }];
}



+(id)getHomeGoodListDataWithPath:(NSString *)path pageNum:(NSInteger)page goodNum:(NSInteger)goodNum state:(NSInteger)state completionHandler:(void (^)(HomeGoodModel * _Nonnull, NSError * _Nonnull))completionHandler{
    
    NSMutableDictionary *parmas = [NSMutableDictionary new];
    [parmas setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"pageNo"];
    [parmas setObject:[NSString stringWithFormat:@"%ld",goodNum] forKey:@"pageSize"];
    [parmas setObject:[NSString stringWithFormat:@"%ld",state] forKey:@"state"];
    
    return [self POST:path parameters:parmas progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            !completionHandler ?: completionHandler([HomeGoodModel parse:responseObj],error);
        }
    }];
}


//分类
+(id)getCategortyLeftDataWithPath:(NSString *)path completionHandler:(void (^)(CategoryLeftMenuModel * _Nonnull, NSError * _Nonnull))completionHandler{
    return [self POST:path parameters:nil progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            !completionHandler ?: completionHandler([CategoryLeftMenuModel parse:responseObj],error);
        }
    }];
}

+(id)getCategoryRightDataWithPath:(NSString *)path parameter:(NSString *)parameter completionHandler:(void (^)(CategoryRightMenuModel * _Nonnull, NSError * _Nonnull))completionHandler{
    NSMutableDictionary *paramsDic = [NSMutableDictionary new];
    [paramsDic setObject:parameter forKey:@"parentId"];
    
    return [self POST:path parameters:paramsDic progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            NSLog(@"RightresponsObj:%@",responseObj);
            !completionHandler ?: completionHandler([CategoryRightMenuModel parse:responseObj],error);
        }
    }];
}


//分类 -> 商品详情
+(id)getCategoryCommodityListDataWithPath:(NSString *)path requestWord:(NSString *)requestW requestPram:(NSString *)pra classIDWord:(NSString *)classIDW classID:(NSString *)ID pageNum:(NSInteger)page goodNum:(NSInteger)goodNum completionHandler:(void (^)(HomeGoodModel * _Nonnull, NSError * _Nonnull))completionHandler{
    NSMutableDictionary *parmas = [NSMutableDictionary new];
    [parmas setObject:ID forKey:classIDW];//类型 goodsClassId
    [parmas setObject:pra forKey:requestW];
    [parmas setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"pageNo"];//页码
    [parmas setObject:[NSString stringWithFormat:@"%ld",goodNum] forKey:@"pageSize"];//数量
    return [self POST:path parameters:parmas progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            !completionHandler ?: completionHandler([HomeGoodModel parse:responseObj],error);
        }
    }];
}



//test
+(id)getShopInfoWithPath:(NSString *)path param:(NSString *)params completionHandler:(void (^)(id _Nonnull, NSError * _Nonnull))completionHandler{
    NSMutableDictionary *pa = [NSMutableDictionary new];
    [pa setObject:params forKey:@"data"];
    
    return [self GETAllPath:path parameters:pa progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            NSLog(@"model:%@",responseObj);
            if (responseObj != nil) {
                completionHandler(responseObj,error);
            }else{
                NSLog(@"数据为空!!!!!!!!!!!!!!");
            }
            
        }else{
            NSLog(@"?????????");
        }
    }];
}



+(id)verifyUserRegisterWithPath:(NSString *)path parameter:(NSString *)openID completionHandler:(void (^)(VerifyRegisterModel* _Nonnull, NSError * _Nonnull))completionHandler{
    NSMutableDictionary *pa = [NSMutableDictionary new];
    [pa setObject:openID forKey:@"wxOpenId"];
    return [self POST:path parameters:pa progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            !completionHandler ?: completionHandler([VerifyRegisterModel parse:responseObj],error);
        }else{
            NSLog(@"0000000");
        }
    }];
    
}


+(id)getVefifyCodeWithPath:(NSString *)path parameter:(NSString *)phoneNumber completionHandler:(void (^)(VerifyRegisterModel * _Nonnull, NSError * _Nonnull))completionHandler{
    NSMutableDictionary *pa = [NSMutableDictionary new];
    [pa setObject:phoneNumber forKey:@"phone"];
    return [self POST:path parameters:pa progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            !completionHandler ?: completionHandler([VerifyRegisterModel parse:responseObj],error);
        }
    }];
}


//请求注册
+(id)requestRegisterWithPath:(NSString *)path wxOpenID:(NSString *)openID phoneNumber:(NSString *)phoneNum vefifyCode:(NSString *)vefifyCode tutorInviteCode:(NSString *)inviteCode completionHandler:(void (^)(VerifyRegisterModel * _Nonnull, NSError * _Nonnull))completionHandler{
    NSMutableDictionary *pa = [NSMutableDictionary new];
    //昵称
    [pa setObject:[YDUserInfo sharedYDUserInfo].userName forKey:@"nickName"];
    [pa setObject:openID forKey:@"wxOpenId"];
    [pa setObject:phoneNum forKey:@"phone"];
    [pa setObject:vefifyCode forKey:@"inviteCode"];
    [pa setObject:inviteCode forKey:@"tutorInviteCode"];//导师邀请码
    
    return [self POST:kUserRegisterURL parameters:pa progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            !completionHandler ?: completionHandler([VerifyRegisterModel parse:responseObj],error);
        }
    }];
}

//请求登陆
+(id)requestLoginWithPath:(NSString *)path wxOpenID:(NSString *)openID phoneNumber:(NSString *)phoneNum completionHandler:(void (^)(VerifyRegisterModel * _Nonnull, NSError * _Nonnull))completionHandler{
   
    NSMutableDictionary *pa = [NSMutableDictionary new];
    [pa setObject:openID forKey:@"wxOpenId"];
    if (phoneNum != nil) {
        [pa setObject:phoneNum forKey:@"phone"];
    }
    
    return [self POST:path parameters:pa progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            !completionHandler ?: completionHandler([VerifyRegisterModel parse:responseObj],error);
        }
    }];
}

//上传图片
+ (void)uploadHeaderImageWithUploadParam:(NSArray <UploadParam *> *)uploadParams completionHandler:(void (^)(VerifyRegisterModel * _Nonnull, NSError * _Nonnull))completionHandler{
    NSMutableDictionary *pa = [NSMutableDictionary new];
    [pa setObject:[[NSUserDefaults standardUserDefaults] stringForKey:kUserID] forKey:@"id"];
    if ([[NSUserDefaults standardUserDefaults] stringForKey:kUserID] == nil) {
        NSLog(@"用户iD为空");
        return;
    }
    [self uploadImageWithURLString:kUpdateUserHeadURL parameters:pa uploadParam:uploadParams progress:^(NSProgress * _Nonnull UploadProgress) {
        
    } completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            !completionHandler ?: completionHandler([VerifyRegisterModel parse:responseObj],error);
        }else{
            !completionHandler ?: completionHandler(nil,error);
        }
    }];
}

+(id)uploadUserInfoPrameter:(id)parameter completionHandler:(void (^)(VerifyRegisterModel * _Nonnull, NSError * _Nonnull))completionHandler{
    //将id 转为decitonary;
    NSDictionary *paraDic = (NSDictionary *)parameter;
//    NSMutableDictionary *pa = [NSMutableDictionary new];
//    [pa setObject:[paraDic objectForKey:@"id"] forKey:@"id"];
//    [pa setObject: [paraDic objectForKey:@"nickName"] forKey:@"nickName"];
//    [pa setObject:[paraDic objectForKey:@"birthDay"] forKey:@"birthDay"];
//    [pa setObject:[paraDic objectForKey:@"sex"] forKey:@"sex"];
//    [pa setObject:[paraDic objectForKey:@"area"] forKey:@"area"];
//    [pa setObject:[paraDic objectForKey:@"shipAddressId"] forKey:@"shipAddressId"];
    
    return [self POST:kUpdateUserInfoURL parameters:paraDic progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            !completionHandler ?: completionHandler([VerifyRegisterModel parse:responseObj],error);
        }
        else{
            !completionHandler ?: completionHandler(nil,error);
        }
    }];

    
}


//获取系统消息
+(id)getSystemUserMessageWithPath:(NSString *)path pageNum:(NSInteger)page pageSize:(NSInteger)size userID:(NSString *)userID completionHandler:(void (^)(UserMessageModel * _Nonnull, NSError * _Nonnull))completionHandler{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"pageNo"];
    [param setObject:[NSString stringWithFormat:@"%ld",size] forKey:@"pageSize"];
    [param setObject:userID/*@"1"*/ forKey:@"userId"];
    
    return [self POST:path parameters:param progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            !completionHandler ?: completionHandler([UserMessageModel parse:responseObj],error);
        }else{
            !completionHandler ?: completionHandler(nil,error);
        }
    }];
}


+(id)getSecondSkillGoodListWithTimeInterverl:(NSString *)time pageNum:(NSInteger)page pageSize:(NSInteger)size completionHandler:(void (^)(SecondSkillColumnModel * _Nonnull, NSError * _Nonnull))completionHandler{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:time forKey:@"dateInterval"];
    [param setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"pageNo"];
    [param setObject:[NSString stringWithFormat:@"%ld",size] forKey:@"pageSize"];

    return [self GET:kSecondSkillGoodURL parameters:param progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            !completionHandler ?: completionHandler([SecondSkillColumnModel parse:responseObj],error);
        }else{
            !completionHandler ?: completionHandler(nil,error);
        }
    }];
    
    
    //http://94.191.42.70:8090/index/selectGoodsSpikeList?dateInterval=00&pageNo=1&pageSize=20
}

+(void)postUserLogCompletionHandler:(void (^)(NSError * _Nonnull))completionHandler{
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:kUserID];
    if (!userID) {
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:userID forKey:@"userId"];
    
    [self POST:kUserLogLog parameters:param progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            completionHandler(error);
        }else
            completionHandler(error);
    }];
}



+(void)postUserIdendityCompletionHandler:(void (^)(UserIdendityModel * _Nonnull, NSError * _Nonnull))comletionHandler{
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:kUserID];
    if (!userID) {
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:userID forKey:@"userId"];
    [self POST:kUserIdendity parameters:param progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            !comletionHandler ?: comletionHandler([UserIdendityModel parse:responseObj],error);
        }else{
            !comletionHandler ?: comletionHandler(nil,error);
        }
    }];
}


//查询订单
+(id)getUserOrderlistPageNum:(NSInteger)page pageSize:(NSInteger)size userPid:(NSString *)pid orderType:(NSString *)type CompletionHandler:(void (^)(UserOrderModel * _Nonnull, NSError * _Nonnull))completionHandler{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"pageNo"];
    [param setObject:[NSString stringWithFormat:@"%ld",size] forKey:@"pageSize"];
    [param setObject:pid forKey:@"tk3rdPubId"];
    [param setObject:type forKey:@"state"];
    

    return [self GET:kUserOrderURL parameters:param progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            !completionHandler ?: completionHandler([UserOrderModel parse:responseObj],error);
        }else{
            !completionHandler ?: completionHandler(nil,error);
        }
    }];
}

//意见反馈
+(void)postUserIdearReponseWithIdearType:(NSString *)iType idearContent:(NSString *)icontent contactMethod:(NSString *)cmethod idearImages:(NSArray<UploadParam *> *)iImages progress:(void (^)(NSProgress * _Nonnull))progress CompletionHandler:(void (^)(VerifyRegisterModel * _Nonnull, NSError * _Nonnull))completionHandler{
    NSString *userID = [[NSUserDefaults standardUserDefaults] stringForKey:kUserID];
    if (userID == nil) {
        NSLog(@"用户iD为空");
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:userID forKey:@"userId"];
    [param setObject:iType forKey:@"type"];
    [param setObject:icontent forKey:@"content"];
    [param setObject:cmethod forKey:@"inputInfo"];
    
    [self uploadImageWithURLString:kIdearResponseURL parameters:param uploadParam:iImages progress:^(NSProgress * _Nonnull UploadProgress) {
        
        !progress ?: progress(UploadProgress);
    } completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        
        if (!error) {
            !completionHandler ?: completionHandler([VerifyRegisterModel parse:responseObj],error);
        }else{
            !completionHandler ?: completionHandler(nil,error);
        }
    }];
}

//用户资金
+(id)getUserMoneyInfoCompletionHandler:(void (^)(UserMoneyModel * _Nonnull, NSError * _Nonnull))completionHandler{
    NSString *userID = [[NSUserDefaults standardUserDefaults] stringForKey:kUserID];
    if (userID == nil) {
        NSLog(@"用户iD为空");
        return nil;
    }
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:userID forKey:@"userId"];
    return [self GET:kUserMoneyURL parameters:param progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            !completionHandler ?: completionHandler([UserMoneyModel parse:responseObj],error);
        }else{
            !completionHandler ?: completionHandler(nil,error);
        }
    }];
}

//团队成员
+(id)getTemaMemberCompletionHandler:(void (^)(UserTeamMemberModel * _Nonnull, NSError * _Nonnull))completionHandler{
    NSString *userID = [[NSUserDefaults standardUserDefaults] stringForKey:kUserID];
    if (userID == nil) {
        NSLog(@"用户iD为空");
        return nil;
    }
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:userID forKey:@"userId"];
    return [self GET:kUserTeamMemberURL parameters:param progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            !completionHandler ?: completionHandler([UserTeamMemberModel parse:responseObj],error);
        }else{
            !completionHandler ?: completionHandler(nil,error);
        }
    }];
    
}

//查看邀请记录 用户id
+(id)getUserInviteRecordWithPageNumber:(NSInteger)page pageSize:(NSInteger)size orderType:(NSString *)type addTime:(NSString *)time completionHandler:(void (^)(InviteRecordModel * _Nonnull, NSError * _Nonnull))completionHandler{
    NSString *userID = [[NSUserDefaults standardUserDefaults] stringForKey:kUserID];
    if (userID == nil) {
        NSLog(@"用户iD为空");
        return nil;
    }
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:userID forKey:@"userId"];
    [param setObject:time forKey:@"addTime"];
    [param setObject:type forKey:@"orderBy"];
    [param setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"pageNo"];
    [param setObject:[NSString stringWithFormat:@"%ld",size] forKey:@"pageSize"];
    
    
    return [self GET:kUserInviteRecordURL parameters:param progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            !completionHandler ?: completionHandler([InviteRecordModel parse:responseObj],error);
        }else{
            !completionHandler ?: completionHandler(nil,error);
        }
    }];
}


//任务中心
+(id)getUserTasksCompleitonHandler:(void (^)(UserTaskModel * _Nonnull, NSError * _Nonnull))completionHandler{
    return [self GET:kUserTaskListURL parameters:nil progress:nil completionHandler:^(id  _Nonnull responseObj, NSError * _Nonnull error) {
        if (!error) {
            !completionHandler ?: completionHandler([UserTaskModel parse:responseObj],error);
        }else{
            !completionHandler ?: completionHandler(nil,error);
        }
    }];
}

@end
