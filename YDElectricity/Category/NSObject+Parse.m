//
//  NSObject+Parse.m
//  YDElectricity
//
//  Created by 元典 on 2018/11/27.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "NSObject+Parse.h"
#import "YYModel.h"

@implementation NSObject (Parse)
+(id)parse:(id)responseObj{
    
    //字典类型
    if ([responseObj isKindOfClass:[NSDictionary class]]) {
        return [self yy_modelWithJSON:responseObj];
    }
    
    //数组类型
    if ([responseObj isKindOfClass:[NSArray class]]) {
        return [NSArray yy_modelArrayWithClass:[self class] json:responseObj];
    }
    //即不是字典也不是数组
    return responseObj;
}

+(id)parseJSONStringToArrayOrDictionaryString:(id)theData{
    
    
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:[self toJSONData:theData]
                                                    options:NSJSONReadingAllowFragments
                                                      error:nil];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        NSLog(@"%@解析错误",[self class]);
        return nil;
    }
}

- (NSData *)toJSONData:(id)theData{
    NSData *stringData = [theData dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:stringData options:0 error:nil];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
    
    
}




@end
