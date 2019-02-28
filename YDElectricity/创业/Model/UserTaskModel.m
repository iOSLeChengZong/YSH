
#import "UserTaskModel.h"

@implementation UserTaskModel
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"tasks":[UserTaskModelTask class]};
}

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"tasks":@"rows"};
}


@end

@implementation UserTaskModelTask

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id",@"taskName":@"task_name",
             @"taskType":@"task_type",@"taskDescription":@"task_description"
             };
}

@end



