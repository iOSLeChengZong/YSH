//
//  UserIdendityModel.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/17.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class UserIdendityInfoInfo;

@interface UserIdendityModel : NSObject<YYModel>
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString * message;
//rows -> info
@property (nonatomic, strong) UserIdendityInfoInfo * info;
@end

@interface UserIdendityInfoInfo : NSObject<YYModel>
@property (nonatomic, strong) NSString * addTime;
@property (nonatomic, strong) NSString * area;
@property (nonatomic, strong) NSString * birthDay;
@property (nonatomic, assign) NSInteger gold;
@property (nonatomic, assign) NSInteger gradeId;
//用户成长值
@property (nonatomic, assign) NSInteger growth;
@property (nonatomic, strong) NSString * headImgUrl;
//id -> idField
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSObject * inviteCode;
@property (nonatomic, strong) NSString * lastLoginTime;
//用户昵称
@property (nonatomic, strong) NSString * nickName;
@property (nonatomic, strong) NSString * phone;
@property (nonatomic, strong) NSObject * phoneImei;
//根据用户pid查询订单信息
@property (nonatomic, strong) NSString * pid;
@property (nonatomic, strong) NSObject * qqOpenId;
@property (nonatomic, strong) NSObject * remark;
@property (nonatomic, strong) NSString * sex;
@property (nonatomic, strong) NSObject * shipAddressId;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) NSInteger tutorId;
@property (nonatomic, strong) NSObject * tutorType;
@property (nonatomic, strong) NSString * wxOpenId;

@end

NS_ASSUME_NONNULL_END
