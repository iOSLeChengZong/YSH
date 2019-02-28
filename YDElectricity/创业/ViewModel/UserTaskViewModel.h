//
//  UserTaskViewModel.h
//  YDElectricity
//
//  Created by 元典 on 2019/2/28.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDNetManager.h"


NS_ASSUME_NONNULL_BEGIN
//定义枚举区分 新手任务 | 日常任务
typedef NS_ENUM(NSInteger,USERTASKTYPE) {
    USERTASKTYPENEWPLAYERTASK,
    USERTASKTYPEDAILYTASK,
};

@interface UserTaskViewModel : NSObject
//根据UI
///** 总行数 */
//@property (nonatomic,assign) NSInteger taskItems;

/** 任务名字 */
-(NSString *)itemForTaskNameAtIndexPath:(NSIndexPath *)indexPath userTaskType:(USERTASKTYPE)taskType;
/** 任务金币奖励 */
-(NSString *)itemForGoldAtIndexPath:(NSIndexPath *)indexPath userTaskType:(USERTASKTYPE)taskType;
/** 任务成长值奖励 */
-(NSString *)itemForGrowthAtIndexPath:(NSIndexPath *)indexPath userTaskType:(USERTASKTYPE)taskType;
/**  任务完成状态 */
-(NSString *)itemForTastkCompletionStateAtIndexPath:(NSIndexPath *)indexPath userTaskType:(USERTASKTYPE)taskType;
/** 获取任务个数 */
-(NSInteger)getTaskNum:(USERTASKTYPE)type;
//根据接口
@property (nonatomic,strong) NSMutableArray<UserTaskModelTask *> *NUserTasks;
@property (nonatomic,strong) NSMutableArray<UserTaskModelTask *> *DUserTasks;


-(void)getUserTaskCompletionHandler:(void(^)(NSError *error))comletionHandler;

@end

NS_ASSUME_NONNULL_END
