//
//  VerifyRegisterModel.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/8.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "VerifyRegisterModel.h"

@implementation VerifyRegisterModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"verifyCode":@"rows",
             @"rows1":@"rows"
             };
}

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"rows1":[User class]};
}
@end

@implementation User



@end



@implementation UserInfo
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}


@end
