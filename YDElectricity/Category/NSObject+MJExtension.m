//
//  NSObject+MJExtension.m
//  YDElectricity
//
//  Created by 元典 on 2018/11/27.
//  Copyright © 2018年 yuandian. All rights reserved.
//

#import "NSObject+MJExtension.h"

@implementation NSObject (MJExtension)
+(id)parse:(id)responseObj
{
    //JSON是数组类
    if ([responseObj isKindOfClass:[NSArray class]]) {
        return [self mj_objectArrayWithKeyValuesArray:responseObj];
    }
    
    //JSON是字典类型
    if ([responseObj isKindOfClass:[NSDictionary class]]) {
        return [self mj_objectWithKeyValues:responseObj];
    }
    //JSON是其它类型
    return responseObj;
}



+(NSDictionary *)mj_objectClassInArray
{
   return [self objectClassInArray];
}

+(NSDictionary *)objectClassInArray
{
    return nil;
}

+ (NSString *)replacedKeyFromPropertyName:(NSString *)propertyName{
    return propertyName;
}

@end
