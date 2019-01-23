//
//  UserMoneyModel.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/22.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "UserMoneyModel.h"

@implementation UserMoneyModel
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"moneInfo":[UserMoneyMoneyInfo class]};
}

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"moneyInfo":@"rows"};
}

@end

@implementation UserMoneyMoneyInfo

@end
