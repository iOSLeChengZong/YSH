//
//  CityDataViewModel.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/11.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "CityDataViewModel.h"
#import "PlistDataManager.h"


@implementation CityDataViewModel



-(void)getCityDataCompletionHandler:(void (^)(NSError * _Nonnull))completionHandler{
    [PlistDataManager getCityData:^(NSArray<CityDataModel *> *cityData, NSError * _Nonnull error) {
        self.cityData = cityData;
        completionHandler(error);
    }];
}

@end
