//
//  PlistDataManager.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/11.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityDataModel.h"
#import "CategoryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlistDataManager : NSObject

+ (void)getCityData:(void(^)(NSArray<CityDataModel *> *cityData,NSError *error))completionHandler;
//分类数据
+ (void)getCategoryData:(void(^)(NSArray<CategoryModel *> *categoryData,NSError *error))completionHandler;

@end

NS_ASSUME_NONNULL_END
