//
//  UserTeamMemberViewModel.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/21.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDNetManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserTeamMemberViewModel : NSObject
//1.根据UI
/** 累计团队贡献奖 */
-(NSString *)totalContribute;
/** 累计奖金 */
-(NSString *)totalBonus;
/** 累计培训津贴 */
-(NSString *)totalTrain;
/** 消费者人数 */
-(NSString *)totalCustomerNum;
/** 创业者人数 */
-(NSString *)businessNum;
/** 总经理人数 */
-(NSString *)managerNum;
/** 合伙人数 */
-(NSString *)shipNum;
/** 我的团队人数 */
-(NSString *)myTeamNum;
//2.根据接口
//+(id)getTemaMemberCompletionHandler:(void(^)(UserTeamMemberModel *model,NSError *error))completionHandler;
@property(nonatomic,strong)UserTeamMemberInfo *info;
-(void)getTeamMemberCompletionHandler:(void(^)(NSError *error))completionHandler;

@end

NS_ASSUME_NONNULL_END
