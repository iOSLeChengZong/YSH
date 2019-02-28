//
//  VerifyRegisterModel.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/8.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class User,UserInfo;

@interface VerifyRegisterModel : NSObject<YYModel>
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *message;
@property(nonatomic,strong)NSString *verifyCode;
@property(nonatomic,strong)User *rows1;

@end

@interface User : NSObject<YYModel>

@property (nonatomic, strong) NSString * token;
@property (nonatomic, strong) UserInfo * userInfo;

@end

@interface UserInfo : NSObject<YYModel>
@property (nonatomic, strong) NSString * addTime;
@property (nonatomic, strong) NSObject * area;
@property (nonatomic, strong) NSObject * birthDay;
@property (nonatomic, assign) NSInteger gold;
@property (nonatomic, assign) NSInteger gradeId;
@property (nonatomic, assign) NSInteger growth;
@property (nonatomic, strong) NSString * headImgUrl;
/** id -> ID */
@property (nonatomic, strong) NSString * ID;
/** 邀请码 */
@property (nonatomic, strong) NSString * inviteCode;
@property (nonatomic, strong) NSString * lastLoginTime;
@property (nonatomic, strong) NSString * nickName;
@property (nonatomic, strong) NSString * phone;
@property (nonatomic, strong) NSObject * phoneImei;
@property (nonatomic, strong) NSString * pid;
@property (nonatomic, strong) NSObject * qqOpenId;
@property (nonatomic, strong) NSObject * remark;
@property (nonatomic, strong) NSObject * sex;
@property (nonatomic, strong) NSObject * shipAddressId;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) NSInteger tutorId;
@property (nonatomic, strong) NSObject * tutorType;
@property (nonatomic, strong) NSString * wxOpenId;

@end

NS_ASSUME_NONNULL_END
