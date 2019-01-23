//
//  CityDataModel.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/11.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "CityDataModel.h"
//CityDataCityListModel,CityDataCityListAreaListModel;
@implementation CityDataModel

//命名属性对照
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id",
             @"citylist":@"cityList"
             };
}

//命名类对照
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"cityList":[CityDataCityListModel class]};
}

@end

@implementation CityDataCityListModel

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"areaList":@"arealist",
             @"ID":@"id"
             };
}

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"areaList":[CityDataCityListAreaListModel class]};
}

@end

@implementation CityDataCityListAreaListModel

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}


@end
