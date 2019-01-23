//
//  UserTeamMemberModel.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/21.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class UserTeamMemberInfo;
@interface UserTeamMemberModel : NSObject<YYModel>
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString * message;
//rows -> memberInfo
@property (nonatomic, strong) UserTeamMemberInfo * memberInfo;
@end

@interface UserTeamMemberInfo : NSObject<YYModel>
/** 累计贡献额 */
@property (nonatomic, assign) CGFloat grandTotalIncomeCount;
/** 消费者人数 */
@property (nonatomic, assign) NSInteger consumerCount;
/** 创业者人数 */
@property (nonatomic, assign) NSInteger pioneerCount;
/** 合伙人数 */
@property (nonatomic, assign) NSInteger partnerCount;
/** 经理人数 */
@property (nonatomic, assign) NSInteger managerCount;
//我的团队总人数
@property (nonatomic, assign) NSInteger userTotalCount;
@end

NS_ASSUME_NONNULL_END
