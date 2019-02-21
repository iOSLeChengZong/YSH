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
    
    //从本地加载头像
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
        case 2:
            return @"创业者";
            break;
        case 3:
            return @"总经理";
            break;
        case 4:
            return @"合伙人";
            break;
            
        default:
            return @"无";
            break;
    }
}


-(NSString *)userGrowth{
    return [NSString stringWithFormat:@"%ld",self.info.growth];
}

//用户成长值比例
-(CGFloat)userGrowthScale{

    switch (self.info.gradeId) {
        case 1:
            return self.info.growth / 999;//0~999
            break;
        case 2:
            return self.info.growth / 4999;//1000~4999
            break;
        case 3:
            return self.info.growth / 14999;//5000~14999
            break;
        case 4:
            return self.info.growth / 15000;//15000~
            break;
            
        default:
            return 0;
            break;
    }
    
}

//跟下一个成长值还差
-(NSString *)lessThanNextRank{
    //获取下一个成长值
    NSInteger nextR = [self nextRank];
    //下一个成长值送去当前成长值
    return [NSString stringWithFormat:@"%ld",(nextR - self.info.growth)];
    
}

-(NSInteger)nextRank{
    switch (self.info.gradeId) {
        case 1:
            return 1000;
            break;
        case 2:
            return 5000;
            break;
        case 3:
            return 15000;
            break;
        case 4:
            return 15000;
            break;
            
        default:
            return 0;
            break;
    }
}


-(NSString *)userPid{
    return self.info.pid;
}

-(UIImage *)getCustomerImage{

    if (self.info.gradeId >= 1) {
        return [UIImage imageNamed:@"y_b_consumers1"];
    }else{
        return [UIImage imageNamed:@"y_b_consumers0"];
    }
}

-(UIColor *)getCustomerNameColor{

    if (self.info.gradeId >= 1) {
        return kFONTSlectRGB;
    }else{
        return [UIColor lightGrayColor];
    }
}

-(CGFloat)toBusinessScale{
    return self.info.growth / ([self nextRank]);
}

-(UIImage *)getBusinessImage{
    if (self.info.gradeId >= 2) {
        return [UIImage imageNamed:@"y_b_entrepreneurs0"];
    }else{
        return [UIImage imageNamed:@"y_b_entrepreneurs2"];
    }
}

-(UIColor *)getBusinessNameColor{
    if (self.info.gradeId >= 2) {
        return kFONTSlectRGB;
    }else{
        return [UIColor lightGrayColor];
    }
}

-(CGFloat)toManagerScale{
    return self.info.growth / ([self nextRank]);
}

-(UIImage *)getManagerImage{
    if (self.info.gradeId >= 3) {
        return [UIImage imageNamed:@"y_b_manager1"];
    }else{
        return [UIImage imageNamed:@"y_b_manager2"];
    }
}
-(UIColor *)getManagerNameColor{
    if (self.info.gradeId >= 3) {
        return kFONTSlectRGB;
    }else{
        return [UIColor lightGrayColor];
    }
}

-(CGFloat)toPartnerScale{
    return self.info.growth / ([self nextRank]);
}

-(UIImage *)getPartnerImage{
    if (self.info.gradeId >= 4) {
        return [UIImage imageNamed:@"y_b_partner1"];
    }else{
        return [UIImage imageNamed:@"y_b_partner0"];
    }
}

-(UIColor *)getPartnerNameColor{
    if (self.info.gradeId >= 4) {
        return kFONTSlectRGB;
    }else{
        return [UIColor lightGrayColor];
    }
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
