//
//  UserMessageModel.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/10.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "UserMessageModel.h"

@implementation UserMessageModel

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"messageList":@"pageList"};
}

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"messageList":[UserSystemMessage class]};
}

@end


@implementation UserSystemMessage
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}


@end
