//
//  CategoryModel.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/14.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"Id"};
}

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"topMenu":[CategoryTopMenuModel class]};
}


@end

@implementation CategoryTopMenuModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"Id"};
}

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"typeMenu":[CategoryTopMenuTypeMenuModel class]};
}


@end

@implementation CategoryTopMenuTypeMenuModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"Id"};
}



@end
