//
//  UserMoneyViewModel.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/22.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDNetManager.h"

NS_ASSUME_NONNULL_BEGIN


@interface UserMoneyViewModel : NSObject
//1.根据UI
/** 账户余额 */
-(NSString *)userBalance;
/** 冻结资金 */
-(NSString *)userFreezeFunds;
/** 累计总收入 */
-(NSString *)userGrandTotalIncome;
/** 待结算资金 */
-(NSString *)userWaitSettle;


//2.根据接口
//+(id)getUserMoneyInfoCompletionHandler:(void (^)(UserMoneyModel * _Nonnull, NSError * _Nonnull))completionHandler

@property(nonatomic,strong)UserMoneyMoneyInfo *moneyInfo;
-(void)getUserMoneyInfoCompletionHandler:(void(^)(NSError *error))completionHandler;

@end

NS_ASSUME_NONNULL_END
