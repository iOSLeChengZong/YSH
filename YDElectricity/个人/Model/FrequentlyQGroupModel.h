


#import <Foundation/Foundation.h>

@class FrequentlyQChildModel;

@interface FrequentlyQGroupModel : NSObject

/**
 组模型名字
 */
@property (nonatomic, copy) NSString *name;

/**
 是否允许折叠
 */
@property (nonatomic, assign, getter=isFoldable) BOOL foldable;

/**
 是否开启
 */
@property (nonatomic, assign, getter=isOpen) BOOL open;

/**
 子模型数组
 */
@property (nonatomic, strong) NSMutableArray<FrequentlyQChildModel *> *childModels;

@end
