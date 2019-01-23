//
//  CategoryViewModel.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/14.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "CategoryViewModel.h"

@implementation CategoryViewModel



//左侧tableView
-(NSInteger)rowNumber{
    return self.leftRowModels.count;
}

-(NSString *)tableViewFroTitleForRowForTableViewAtIndexPath:(NSIndexPath *)indexPath{
    return self.leftRowModels[indexPath.row].name;
}

//右侧collectionView
-(NSInteger)collectionViewForSectionNumber:(NSInteger)tableVIndex{
    return 1;//
}

-(NSInteger)collectionViewForRowNumberForSection:(NSInteger)section /*tableViewIndex:(NSInteger)index*/{
    return self.rightRowModels.count;
}



-(NSString *)collectionViewForTitleForSection:(NSInteger)section /*tableViewIndex:(NSInteger)index*/{
    return  @" ";
}


-(NSString *)collectionViewForTitleForRowAtIndexPath:(NSIndexPath *)indexPath/* section:(NSInteger)section tableViewIndex:(NSInteger)index*/{
    return self.rightRowModels[indexPath.row].name;
}

-(NSURL *)collectionViewForImageNameForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"imageUrl:%@",[kBaseURL stringByAppendingString:self.rightRowModels[indexPath.row].img]);
    return [NSURL URLWithString:[kBaseURL2 stringByAppendingString:self.rightRowModels[indexPath.row].img]];

}


//-(void)getCategoryDataCompletionHandler:(void (^)(NSError * _Nonnull))completionHandler{
//    [PlistDataManager getCategoryData:^(NSArray<CategoryModel *> *categoryData, NSError * _Nonnull error) {
//        self.categoryModels = categoryData;
//        completionHandler(error);
//    }];
//}

-(void)getCategoryLeftData:(void (^)(NSError * _Nonnull))completionHandler{
    [YDNetManager getCategortyLeftDataWithPath:kCategoryModelURL completionHandler:^(CategoryLeftMenuModel * _Nonnull model, NSError * _Nonnull error) {
        if (!error) {
            self.leftRowModels = model.categoryModels;
            completionHandler(error);
        }
    }];
}

-(void)getCategoryRithDataWithParameter:(NSString *)ID completionHandler:(void (^)(NSError * _Nonnull))completionHandler{

    [YDNetManager getCategoryRightDataWithPath:kCategoryModelURL parameter:ID completionHandler:^(CategoryRightMenuModel * _Nonnull model, NSError * _Nonnull error) {
        if (!error) {
            self.rightRowModels = model.categoryModels;
            completionHandler(error);
        }
    }];
    
}



@end

