//
//  AddressDataModel.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/16.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressDataModel : NSObject<NSCoding>
@property (nonatomic,copy) NSString* name;//姓名
@property (nonatomic,copy) NSString* telphone;//电话
@property (nonatomic,copy) NSString* postCode;//邮政编码
@property (nonatomic,copy) NSString* detailAddr;//地区
@property (nonatomic,copy) NSString* areaStr;//详细地址
@property (nonatomic,copy) NSString* defaultStr;
@end

NS_ASSUME_NONNULL_END
