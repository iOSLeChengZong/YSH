//
//  CityDataViewModel.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/11.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CityDataViewModel : NSObject


//根据 model 来确定属性方法
@property(nonatomic,strong)NSArray<CityDataModel *> *cityData;
-(void)getCityDataCompletionHandler:(void(^)(NSError *error))completionHandler;
@end

NS_ASSUME_NONNULL_END
