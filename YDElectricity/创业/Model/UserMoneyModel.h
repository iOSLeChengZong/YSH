//
//  UserMoneyModel.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/22.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class UserMoneyMoneyInfo;
@interface UserMoneyModel : NSObject<YYModel>
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString * message;
//rows -moneyInfo
@property (nonatomic, strong) UserMoneyMoneyInfo * moneyInfo;

@end


@interface UserMoneyMoneyInfo : NSObject<YYModel>

/** 账户余额 */
@property (nonatomic, assign) CGFloat balance;
/** 冻结奖金 */
@property (nonatomic, assign) CGFloat freezeFunds;
/** 累计总收入 */
@property (nonatomic, assign) CGFloat grandTotalIncome;
/** 上个月结算 */
@property (nonatomic, assign) CGFloat lastMonthSettle;
/** 本月结算 */
@property (nonatomic, assign) CGFloat thisMonthWaitSettle;
/** 待确认资金 */
@property (nonatomic, strong) NSObject * waitConfirm;
/** 待结算资金 */
@property (nonatomic, assign) CGFloat waitSettle;
@end

NS_ASSUME_NONNULL_END
