//
//  PlistDataManager.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/11.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "PlistDataManager.h"

@implementation PlistDataManager
+(NSArray *)getArrFromPlist:(NSString *)plistName
{
    return [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"]];
}

+(void)getCityData:(void (^)(NSArray<CityDataModel *> *, NSError * _Nonnull))completionHandler{
    //异步操作
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *tmpArr = [CityDataModel parse:[self getArrFromPlist:@"citydata"]];
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            !completionHandler ?: completionHandler(tmpArr,nil);
        });
    });
}

+(void)getCategoryData:(void (^)(NSArray<CategoryModel *> * _Nonnull, NSError * _Nonnull))completionHandler{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *tmpArr = [CategoryModel parse:[self getArrFromPlist:@"Category"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            !completionHandler ?: completionHandler(tmpArr,nil);
        });
    });
}
@end
