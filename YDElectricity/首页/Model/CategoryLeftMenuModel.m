//
//  CategoryLeftMenuModel.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/18.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "CategoryLeftMenuModel.h"

@implementation CategoryLeftMenuModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"categoryModels":@"rows"};
}

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"categoryModels":[CategoryLeftMenuRowModel class]};
}


@end

@implementation CategoryLeftMenuRowModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"isLast":@"is_last",
             @"paretnID":@"parent_id",
             @"ID":@"id"
             };
}

@end

