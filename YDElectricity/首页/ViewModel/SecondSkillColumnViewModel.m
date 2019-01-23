//
//  SecondSkillColumnViewModel.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/17.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "SecondSkillColumnViewModel.h"

@implementation SecondSkillColumnViewModel

-(NSInteger)itemNumber{
    return self.pageList.count;
}

-(NSURL *)goodImageURLAtIndexPath:(NSIndexPath *)indexPath{
    return [NSURL URLWithString:self.pageList[indexPath.row].picUrl];
}

- (NSString *)goodPlatformImageAtIndexPath:(NSIndexPath *)indexPath{
    return @"";
}

-(NSString *)goodNameAtIndexPath:(NSIndexPath *)indexPath{
    return self.pageList[indexPath.row].title;
}

-(NSString *)goodOriginalPriceAtIndexPath:(NSIndexPath *)indexPath{
    return [NSString stringWithFormat:@"￥%.1f",self.pageList[indexPath.row].reservePrice];
}

-(NSString *)goodCurrentPriceAtIndexPath:(NSIndexPath *)indexPath{
    return [NSString stringWithFormat:@"￥%.1f",self.pageList[indexPath.row].zkFinalPrice];
}

-(NSString *)goodTotalNumAtIndexPath:(NSIndexPath *)indexPath{
    return [NSString stringWithFormat:@"%ld",self.pageList[indexPath.row].totalAmount];
}

-(NSString *)goodCurrentNumAtIndexPath:(NSIndexPath *)indexPath{
    return [NSString stringWithFormat:@"%ld",self.pageList[indexPath.row].soldNum];
}

-(NSMutableArray<SecondSkillColumnPageList *> *)pageList{
    if (!_pageList) {
        _pageList = [NSMutableArray array];
    }
    return _pageList;
}


-(void)getSecondSkillListModelDataRequestMode:(SecondKillRequestMode)requestMode timeInterverl:(NSString *)time pageSize:(NSInteger)size completionHandler:(void (^)(NSError * _Nonnull))completionHandler{
    
    if (self.pageNum >= self.totalPage && self.totalPage >=1) {
        NSError *error = nil;
        !completionHandler ?: completionHandler(error);
        return;
    }
    
    NSInteger tempNum = 1;
    if (requestMode == SecondKillRequestModeMore) {
        tempNum = ++_pageNum;
    }
    [YDNetManager getSecondSkillGoodListWithTimeInterverl:time pageNum:tempNum pageSize:size completionHandler:^(SecondSkillColumnModel * _Nonnull model, NSError * _Nonnull error) {
        if (!error) {
            _pageNum = tempNum;
            if (requestMode == SecondKillRequestModeRefresh) {
                [self.pageList removeAllObjects];
            }
            self.totalPage = model.totalPages;
            [self.pageList addObjectsFromArray:model.pageList];
            !completionHandler ?: completionHandler(error);
        }
        
    }];
}
@end
