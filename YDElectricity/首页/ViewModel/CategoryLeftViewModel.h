//
//  CategoryLeftViewModel.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/18.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDNetManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoryLeftViewModel : NSObject
//根据UI
@property(nonatomic,assign)NSInteger rowNum;
-(NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath;

//根据接口
@property(nonatomic,strong)NSArray<CategoryLeftMenuRowModel *> *categoryLeftMenuModels;
-(void)getCategoryLeftMenuModelCompletionHandler:(void(^)(NSError *error))completionHandler;

@end

NS_ASSUME_NONNULL_END
