//
//  InviteRecordViewModel.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/21.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDNetManager.h"

NS_ASSUME_NONNULL_BEGIN
//请求更多还是请求刷新
typedef NS_ENUM(NSInteger,InviteReRecordRequestMode) {
    InviteReRecordRequestModeRefresh,
    InviteReRecordRequestModeMore,
};

@interface InviteRecordViewModel : NSObject
//1.根据UI
/** 用户头像 */
-(NSURL *)headURLAtIndexpath:(NSIndexPath *)indexPath;
/** 用户名 */
-(NSString *)userNameAtIndexpath:(NSIndexPath *)indexPath;
/** 邀请时间 */
-(NSString *)inviteTimeAtindexPath:(NSIndexPath *)indexPath;

/** 团队人数 */
-(NSString *)teamPeopleNumAtIndexPath:(NSIndexPath *)indexPath;

/** 贡献额 */
-(NSString *)contributeNumAtIndexPath:(NSIndexPath *)indexPath;

/** 等级 */
-(NSString *)rankAtIndexPath:(NSIndexPath *)indexPath;

//2.根据接口
@property(nonatomic,assign)NSInteger totalPage;
@property(nonatomic,assign)NSInteger pageNum;
@property(nonatomic,strong)NSMutableArray<InviteRecordInfo *> *recordList;
-(void)getUserInviteRecordWithPageSize:(NSInteger)size orderType:(NSString *)type addTime:(NSString *)time requestMode:(InviteReRecordRequestMode)mode completionHandler:(void(^)(NSError *error))completionHandler;
@end

NS_ASSUME_NONNULL_END
