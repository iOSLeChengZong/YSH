//
//  CityDataModel.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/11.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class CityDataCityListModel,CityDataCityListAreaListModel;

/** 省或直辖市 */
@interface CityDataModel : NSObject<YYModel>
// citylist -> cityList
@property(nonatomic,strong) NSArray<CityDataCityListModel *> *cityList;
// id -> ID
@property(nonatomic,copy) NSString *ID;
@property(nonatomic,copy) NSString *provinceName;
@end

/** 城市 */
@interface CityDataCityListModel : NSObject<YYModel>
//arealist -> areaList
@property(nonatomic,strong)NSArray<CityDataCityListAreaListModel *> *areaList;
@property(nonatomic,copy) NSString *cityName;
//id -> ID
@property(nonatomic,copy) NSString *ID;

@end


/** 地区 */
@interface CityDataCityListAreaListModel : NSObject<YYModel>
@property(nonatomic,copy) NSString *areaName;
//id -> ID
@property(nonatomic,copy) NSString *ID;

@end

NS_ASSUME_NONNULL_END
