//
//  CategoryRightMenuModel.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/18.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "CategoryRightMenuModel.h"

@implementation CategoryRightMenuModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"categoryModels":@"rows"};
}

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"categoryModels":[CategoryRightMenuRowModel class]};
}


@end

@implementation CategoryRightMenuRowModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"isLast":@"is_last",
             @"paretnID":@"parent_id",
             @"ID":@"id"
             };
}

@end
