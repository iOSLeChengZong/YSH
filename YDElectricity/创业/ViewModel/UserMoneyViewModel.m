//
//  UserMoneyViewModel.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/22.
//  Copyright © 2019 yuandian. All rights reserved.
//



#import "UserMoneyViewModel.h"

@implementation UserMoneyViewModel

-(NSString *)userBalance{
    return [NSString stringWithFormat:@"￥%.1f",self.moneyInfo.balance];
}

-(NSString *)userFreezeFunds{
    return [NSString stringWithFormat:@"￥%.1f",self.moneyInfo.freezeFunds];
}

-(NSString *)userGrandTotalIncome{
    return [NSString stringWithFormat:@"￥%.1f",self.moneyInfo.grandTotalIncome];
}
-(NSString *)userWaitSettle{
    return [NSString stringWithFormat:@"￥%.1f",self.moneyInfo.waitSettle];
}

-(void)getUserMoneyInfoCompletionHandler:(void (^)(NSError * _Nonnull))completionHandler{
    
    [YDNetManager getUserMoneyInfoCompletionHandler:^(UserMoneyModel * _Nonnull model, NSError * _Nonnull error) {
        if (!error) {
            !completionHandler ?: completionHandler(error);
        }else{
            self.moneyInfo = model.moneyInfo;
            !completionHandler ?: completionHandler(error);
        }
    }];
}
@end
