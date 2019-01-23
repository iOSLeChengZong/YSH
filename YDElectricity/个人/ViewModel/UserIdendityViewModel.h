//
//  UserIdendityViewModel.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/17.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDNetManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserIdendityViewModel : NSObject
//根据UI
/** 用户昵称 */
-(NSString *)userNickName;
/** 用户等级 */
-(NSString *)userRankName;
/** 用户pid */
-(NSString *)userPid;
/** 用户头像 */
-(NSURL *)userHeadImageURL;

//根据接口
@property(strong,nonatomic)UserIdendityInfoInfo *info;
-(void)getUserIdendityCompletionHandler:(void(^)(NSError *error))completionHandler;
@end

NS_ASSUME_NONNULL_END
