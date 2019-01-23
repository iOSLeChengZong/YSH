//
//  UserTeamMemberViewModel.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/21.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "UserTeamMemberViewModel.h"

@implementation UserTeamMemberViewModel


-(NSString *)totalContribute{
    return [NSString stringWithFormat:@"%.1lf",self.info.grandTotalIncomeCount];
}

-(NSString *)totalBonus{
    return [NSString stringWithFormat:@"￥%.1lf",666.0];
}

-(NSString *)totalTrain{
    return [NSString stringWithFormat:@"￥%.1lf",777.0];
}
-(NSString *)totalCustomerNum{
    return [NSString stringWithFormat:@"%.1ld",self.info.consumerCount];
}

-(NSString *)businessNum{
    return [NSString stringWithFormat:@"%ld",self.info.pioneerCount];
}

-(NSString *)shipNum{
    return [NSString stringWithFormat:@"%ld",self.info.partnerCount];
}

-(NSString *)managerNum{
    return [NSString stringWithFormat:@"%ld",self.info.managerCount];
}

-(NSString *)myTeamNum{
    return [NSString stringWithFormat:@"%ld",self.info.userTotalCount];
}


-(void)getTeamMemberCompletionHandler:(void (^)(NSError * _Nonnull error))completionHandler{
    [YDNetManager getTemaMemberCompletionHandler:^(UserTeamMemberModel * _Nonnull model, NSError * _Nonnull error) {
        if (!error) {
            self.info = model.memberInfo;
            !completionHandler ?: completionHandler(error);
        }else{
            NSLog(@"团队成员请求有误");
            !completionHandler ?: completionHandler(error);
        }
    }];
}
@end
