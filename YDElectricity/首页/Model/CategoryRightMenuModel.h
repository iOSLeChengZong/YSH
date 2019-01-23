//
//  CategoryRightMenuModel.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/18.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CategoryRightMenuRowModel;

@interface CategoryRightMenuModel : NSObject<YYModel>
@property(nonatomic,strong)NSArray<CategoryRightMenuRowModel *> *categoryModels;

@end


@interface CategoryRightMenuRowModel : NSObject<YYModel>
//is_last -> isLast
@property(nonatomic,strong) NSString *is_last;
@property(nonatomic,strong) NSString *level;
//parent_id -> paretnID;
@property(nonatomic,strong) NSString *parent_id;
@property(nonatomic,strong) NSString *name;
//id -> ID
@property(nonatomic,strong) NSString *ID;
//商品图片
@property(nonatomic,strong) NSString *img;


@end

NS_ASSUME_NONNULL_END
