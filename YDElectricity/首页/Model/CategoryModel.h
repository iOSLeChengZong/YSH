//
//  CategoryModel.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/14.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class CategoryTopMenuModel,CategoryTopMenuTypeMenuModel;

@interface CategoryModel : NSObject<YYModel>
//Id -> ID
@property(nonatomic,assign) int ID;
@property(nonatomic,copy)NSString *menuName;
@property(nonatomic,copy)NSArray<CategoryTopMenuModel *> *topMenu;

@end



@interface CategoryTopMenuModel : NSObject<YYModel>
//Id -> ID
@property(nonatomic,assign) int ID;
@property(nonatomic,copy) NSString *topName;
@property(nonatomic,copy) NSArray<CategoryTopMenuTypeMenuModel *> *typeMenu;


@end


@interface CategoryTopMenuTypeMenuModel : NSObject<YYModel>
//Id -> ID
@property(nonatomic,assign) int ID;
@property(nonatomic,copy) NSString *typeName;
//图片名称
@property(nonatomic,copy) NSString *typeImg;


@end

NS_ASSUME_NONNULL_END
