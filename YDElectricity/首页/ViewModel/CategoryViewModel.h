//
//  CategoryViewModel.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/14.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlistDataManager.h"
#import "YDNetManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoryViewModel : NSObject
//1.根据UI
//左侧tableView
@property(nonatomic,assign) NSInteger rowNumber;

-(NSString *)tableViewFroTitleForRowForTableViewAtIndexPath:(NSIndexPath *)indexPath;


//2.根据接口


@property(nonatomic,strong)NSArray<CategoryLeftMenuRowModel *> *leftRowModels;
-(void)getCategoryLeftData:(void(^)(NSError *error))completionHandler;



//右侧collectionVeiw
/** index 根据左侧talbeViewIndexPath.row来定 */
/** 分区数 */
-(NSInteger)collectionViewForSectionNumber:(NSInteger)tableVIndex;
/** 每个分区有多少个 */
-(NSInteger)collectionViewForRowNumberForSection:(NSInteger)section;// tableViewIndex:(NSInteger)index;
/** 分区的名字 */
-(NSString *)collectionViewForTitleForSection:(NSInteger)section /*tableViewIndex:(NSInteger)index*/;
/** item的title */
-(NSString *)collectionViewForTitleForRowAtIndexPath:(NSIndexPath *)indexPath;// section:(NSInteger)section tableViewIndex:(NSInteger)index;
/** 每个item图片名字 */
-(NSURL *)collectionViewForImageNameForRowAtIndexPath:(NSIndexPath *)indexPath;// section:(NSInteger)section tableViewIndex:(NSInteger)index;


//根据接口
//模型层所有数据
@property(nonatomic,copy)NSArray<CategoryRightMenuRowModel *> *rightRowModels;

- (void)getCategoryRithDataWithParameter:(NSString *)ID completionHandler:(void(^)(NSError *error))completionHandler;



@end

NS_ASSUME_NONNULL_END

/*
 + (id)getCategortyLeftDataWithPath:(NSString *)path completionHandler:(void(^)(CategoryLeftMenuModel *model,NSError *error))completionHandler;
 + (id)getCategoryRightDataWithPath:(NSString *)path parameter:(NSString *)parameter completionHandler:(void(^)(CategoryRightMenuModel *model,NSError *error))completionHandler;
 */
