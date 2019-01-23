//
//  MJStudent.m
//  YDElectricity
//
//  Created by 元典 on 2018/11/27.
//  Copyright © 2018年 yuandian. All rights reserved.
//

#import "MJStudent.h"

@implementation MJStudent
//MJCooding协议,将发发名换成key,去字典中取值
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id",
             @"desc" : @"desciption",
             @"oldName" : @"name.oldName",
             @"nowName" : @"name.newName",
             @"nameChangedTime" : @"name.info[1].nameChangedTime",
             @"bag" : @"other.bag"
             };
}

@end
