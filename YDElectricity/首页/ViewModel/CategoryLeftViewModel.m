//
//  CategoryLeftViewModel.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/18.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "CategoryLeftViewModel.h"

@implementation CategoryLeftViewModel
- (NSInteger)rowNum{
    return self.categoryLeftMenuModels.count;
}

-(NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.categoryLeftMenuModels[indexPath.row].name;
}

-(void)getCategoryLeftMenuModelCompletionHandler:(void (^)(NSError * _Nonnull))completionHandler{
    [YDNetManager getCategortyLeftDataWithPath:kCategoryModelURL completionHandler:^(CategoryLeftMenuModel * _Nonnull model, NSError * _Nonnull error) {
        self.categoryLeftMenuModels = model.categoryModels;
    }];
}

@end
