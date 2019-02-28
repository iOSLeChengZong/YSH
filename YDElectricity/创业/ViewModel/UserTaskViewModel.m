//
//  UserTaskViewModel.m
//  YDElectricity
//
//  Created by 元典 on 2019/2/28.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "UserTaskViewModel.h"


@implementation UserTaskViewModel

-(NSString *)itemForTaskNameAtIndexPath:(NSIndexPath *)indexPath userTaskType:(USERTASKTYPE)taskType{
    if (taskType == USERTASKTYPENEWPLAYERTASK) {
        return self.NUserTasks[indexPath.row].taskName;
    }else{
        return self.DUserTasks[indexPath.row].taskName;
    }
    
}

-(NSString *)itemForGrowthAtIndexPath:(NSIndexPath *)indexPath userTaskType:(USERTASKTYPE)taskType{
    if (taskType == USERTASKTYPENEWPLAYERTASK) {
        return [NSString stringWithFormat:@"%ld",self.NUserTasks[indexPath.row].growth];
    }else{
        return [NSString stringWithFormat:@"%ld",self.DUserTasks[indexPath.row].growth];
    }
    
}

-(NSString *)itemForGoldAtIndexPath:(NSIndexPath *)indexPath userTaskType:(USERTASKTYPE)taskType{
    if (taskType == USERTASKTYPENEWPLAYERTASK) {
        return [NSString stringWithFormat:@"%ld",self.NUserTasks[indexPath.row].gold];
    }else{
        return [NSString stringWithFormat:@"%ld",self.DUserTasks[indexPath.row].gold];
    }
    
}

-(NSString *)itemForTastkCompletionStateAtIndexPath:(NSIndexPath *)indexPath userTaskType:(USERTASKTYPE)taskType{
    return @"";
}





-(NSInteger )getTaskNum:(USERTASKTYPE)type{
    if (type == USERTASKTYPENEWPLAYERTASK) {
        return self.NUserTasks.count;
    }else{
        return self.DUserTasks.count;
    }
}


-(void)getUserTask:(USERTASKTYPE)taskType{
    
}


-(void)getUserTaskCompletionHandler:(void (^)(NSError * _Nonnull))comletionHandler{
    
    if (self.NUserTasks.count > 0 || self.DUserTasks.count > 0) {
        comletionHandler(nil);
        return;
    }
    
    [YDNetManager getUserTasksCompleitonHandler:^(UserTaskModel * _Nonnull model, NSError * _Nonnull error) {
        if (!error) {
            for (UserTaskModelTask *task in model.tasks) {
                if ([task.taskType isEqualToString:@"1"]) {
                    [self.NUserTasks addObject:task];
                }else{
                    [self.DUserTasks addObject:task];
                }
            }
            comletionHandler(error);
        }
    }];
}

-(NSMutableArray<UserTaskModelTask *> *)NUserTasks{
    if (!_NUserTasks) {
        _NUserTasks = [NSMutableArray array];
    }
    return _NUserTasks;
}

-(NSMutableArray<UserTaskModelTask *> *)DUserTasks{
    if (!_DUserTasks) {
        _DUserTasks = [NSMutableArray array];
    }
    return _DUserTasks;
}

@end
