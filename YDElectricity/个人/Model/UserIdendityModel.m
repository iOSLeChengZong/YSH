//
//  UserIdendityInfo.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/17.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "UserIdendityModel.h"

@implementation UserIdendityModel
//YDSingletonM(UserIdendityModel)

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"info":[UserIdendityInfoInfo class]};
}

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"info":@"rows"};
}

@end

@implementation UserIdendityInfoInfo

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"id":@"idField"};
}


@end
