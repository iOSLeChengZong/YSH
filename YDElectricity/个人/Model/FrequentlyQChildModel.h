//

//

#import <Foundation/Foundation.h>

@interface FrequentlyQChildModel : NSObject

/**
 子模型名字
 */
@property (nonatomic, copy) NSString *name;

/**
 原始所在的组的编号
 */
@property (nonatomic, assign) NSInteger originalGroupNumber;

/**
 在原始所在的组中的下标
 */
@property (nonatomic, assign) NSInteger originalIndexAtGroup;

@end
