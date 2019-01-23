//
//  CategoryLeftMenuModel.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/18.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class CategoryLeftMenuRowModel,CategoryRightMenuModel;

@interface CategoryLeftMenuModel : NSObject<YYModel>
@property(nonatomic,strong)NSArray<CategoryLeftMenuRowModel *> *categoryModels;

@end


@interface CategoryLeftMenuRowModel : NSObject<YYModel>
//is_last -> isLast
@property(nonatomic,strong) NSString *is_last;
@property(nonatomic,strong) NSString *level;
//parent_id -> paretnID;
@property(nonatomic,strong) NSString *parent_id;
@property(nonatomic,strong) NSString *name;
//id -> ID
@property(nonatomic,strong) NSString *ID;


@end


NS_ASSUME_NONNULL_END
//[{"is_last":1,"level":1,"parent_id":null,"name":"男装","id":20},{"is_last":1,"level":1,"parent_id":null,"name":"女装","id":22}]
