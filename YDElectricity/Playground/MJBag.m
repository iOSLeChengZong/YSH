//
//  MJBag.m
//  YDElectricity
//
//  Created by 元典 on 2018/11/27.
//  Copyright © 2018年 yuandian. All rights reserved.
//

#import "MJBag.h"

@implementation MJBag
// NSCoding实现
//MJExtensionCodingImplementation

+ (NSArray *)mj_ignoredCodingPropertyNames
{
    return @[@"name"];
}



@end
