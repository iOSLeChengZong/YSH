#import <UIKit/UIKit.h>
@class UserTaskModelTask;

@interface UserTaskModel : NSObject<YYModel>

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString * message;

//rows -> tasks
@property (nonatomic, strong) NSArray<UserTaskModelTask *> *tasks;

@end

@interface UserTaskModelTask : NSObject<YYModel>
@property (nonatomic, strong) NSString *addTime;
//金币
@property (nonatomic, assign) NSInteger gold;
//成长值
@property (nonatomic, assign) NSInteger growth;
//id -> ID
@property (nonatomic, assign) NSInteger ID;
//任务描述  task_description ->taskDescription
@property (nonatomic, strong) NSString *taskDescription;
//任务名字  task_name -> taskName
@property (nonatomic, strong) NSString *taskName;
//任务状态  task_type -> taskType 
@property (nonatomic, assign) NSString *taskType;
@end
