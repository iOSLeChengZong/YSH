//
//  UserTeamMemberModel.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/21.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "UserTeamMemberModel.h"

@implementation UserTeamMemberModel
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"memberInfo":[UserTeamMemberInfo class]};
}

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"memberInfo":@"rows"};
}

@end

@implementation UserTeamMemberInfo



@end
