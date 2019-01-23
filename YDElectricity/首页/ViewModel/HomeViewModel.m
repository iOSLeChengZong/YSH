//
//  HomeViewModel.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/19.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "HomeViewModel.h"

@interface HomeViewModel()
//栏目图片
@property(nonatomic,strong)NSArray *culomImageNames;
@property(nonatomic,strong)NSMutableDictionary *pageDic;
@end

@implementation HomeViewModel


#pragma mark -- 懒加载

-(NSMutableArray<AdvertisementList *> *)advertiseMuArr{
    if (!_advertiseMuArr) {
        _advertiseMuArr = [NSMutableArray new];
    }

    return _advertiseMuArr;
}

-(NSMutableArray<CategoryClassList *> *)categoryMuArr{
    if (!_categoryMuArr) {
        _categoryMuArr = [NSMutableArray new];
    }
    return _categoryMuArr;
}

-(NSMutableArray<GoodsSpikeList *> *)goodSpikeMuArr{
    if ((!_goodSpikeMuArr)) {
        _goodSpikeMuArr = [NSMutableArray new];
    }
    return _goodSpikeMuArr;
}


-(void)clearHeaderData{
    [self.advertiseMuArr removeAllObjects];
    [self.categoryMuArr removeAllObjects];
    [self.goodSpikeMuArr removeAllObjects];
}

-(void)addHeaderData:(HomeHeaderModel *)headModel{
    [self.advertiseMuArr addObjectsFromArray:headModel.rows.advertisementList];
    [self.categoryMuArr addObjectsFromArray:headModel.rows.categoryClassList];
    [self.goodSpikeMuArr addObjectsFromArray:headModel.rows.goodsSpikeList];
}


//轮播图URLS
-(NSArray *)advertiseURLS{

    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < _advertiseMuArr.count; ++i) {
        
        [array addObject:[kBaseURL stringByAppendingString:_advertiseMuArr[i].imgUrl]];
        NSLog(@"adverURL:%@",array[i]);
    }
    return array;
}

//栏目图片
-(NSArray *)culomTitleArr{
    if (!_culomImageNames) {
        _culomImageNames = @[@"",@"",@"",@"",@""];
    }
    return _culomImageNames;
}



-(NSMutableArray<PageList *> *)pageList{
    if (!_pageList) {
        _pageList =[NSMutableArray array];
    }
    return _pageList;
}




-(NSInteger)culomnitemNum{
    return _categoryMuArr.count;
}

-(NSString *)culomnCellTitleForItem:(NSIndexPath *)indexPath{
    if (_categoryMuArr.count > 0) {
        return _categoryMuArr[indexPath.row].name;
    }
    return nil;
    
}


-(NSString *)culomnCellImageNameForItem:(NSIndexPath *)indexPath{
    if (_culomImageNames.count > 0) {
        return _culomImageNames[indexPath.row];
    }
    return nil;
}

-(NSString *)culomnGoodID:(NSIndexPath *)indexPath{
    
    return _categoryMuArr[indexPath.row].ID;//[NSString stringWithFormat:@"%ld",_categoryMuArr[indexPath.row].ID];
}

-(NSURL *)secondSkillGoodURL{
    if (_goodSpikeMuArr.count > 0) {
        NSLog(@"skillSecond:%@",_goodSpikeMuArr[0].pageImgUrl);
        
        return [NSURL URLWithString:[kBaseURL1 stringByAppendingString:_goodSpikeMuArr[0].pageImgUrl]];;
    }
    return nil;
}


// 首页下方商品
-(NSInteger)goodCollectionVItemNum{
    return _pageList.count;
}

/** 主图 */
-(NSURL *)goodCollectionVItemImageURLAtIndexPath:(NSIndexPath *)indexPath{
    return [NSURL URLWithString:_pageList[indexPath.row].pictUrl];//无需拼接;
    
}

-(NSString *)goodCollectionVItemSourseAtIndexPath:(NSIndexPath *)indexPath{
    return @"淘宝";
}

//商品名称
-(NSString *)goodCollectionVItemMainTitleAtIndexPath:(NSIndexPath *)indexPath{
    return _pageList[indexPath.row].shortTitle;
    
}

//优惠信息
-(NSString *)goodCollectionVItemSecondTitleAtIndexPath:(NSIndexPath *)indexPath{
    
    return _pageList[indexPath.row].couponInfo;
}


//原价
-(NSString *)goodCollectionVItemSoursePriceAtIndexPath:(NSIndexPath *)indexPath{
    return [NSString stringWithFormat:@"￥%.1f",_pageList[indexPath.row].reservePrice];
    
}


//券
-(NSString *)goodCollectionVitemTicketPriceAtIndexPath:(NSIndexPath *)indexPath{
    return [NSString stringWithFormat:@"￥%.1f",_pageList[indexPath.row].couponPrice];
}

//月销售
-(NSString *)goodCollectionVItemMonthSaleNumAtIndexPath:(NSIndexPath *)indexPath{
    return [NSString stringWithFormat:@"%ld",(long)_pageList[indexPath.row].volume];
    
}

//券后价
-(NSString *)goodCollectionVItemAfterSalePriceAtIndexPath:(NSIndexPath *)indexPath{

    return [NSString stringWithFormat:@"￥%.1f",_pageList[indexPath.row].zkFinalPrice];
    
}


//收益
-(NSString *)goodCollectionVItemProfitAtIndexPath:(NSIndexPath *)indexPath{
    return [NSString stringWithFormat:@"￥%.1f",_pageList[indexPath.row].commission];
    
}

-(void)getHomeHeaderModelDataCompletionHandler:(void (^)(NSError * _Nonnull))completionHandler{
    [YDNetManager getHomeHeaderDataWithPath:kHomeHederDataURL completionHandler:^(HomeHeaderModel * _Nonnull model, NSError * _Nonnull error) {
        if (!error) {
            [self clearHeaderData];
            [self addHeaderData:model];
            completionHandler(error);
        }
    }];
}


//首页商品
-(void)getHomeGoodModelDataRequestMode:(HomeRequestMode)requestMode pageSize:(NSInteger)pageSize state:(HotOrRecomend)hotOrRecomend CompletionHandler:(void (^)(NSError * _Nonnull))completionHandler{
    
    NSInteger tempNum = 1;
    if (requestMode == HomeRequestModeMore) {
        tempNum = ++_pageNum;
    }
    
    [YDNetManager getHomeGoodListDataWithPath:kHomeGoodListDataURL pageNum:tempNum goodNum:pageSize state:hotOrRecomend completionHandler:^(HomeGoodModel * _Nonnull model, NSError * _Nonnull error) {
        if ((!error)) {
            _pageNum = tempNum;
            if (requestMode == HomeRequestModeRefresh) {
                [self.pageList removeAllObjects];
            }
            self.totalPage = model.totalPages;
            [self.pageList addObjectsFromArray:model.pageList];
            completionHandler(error);
        }
    }];
}


//分类商品
-(void)getCommodityModelDataRequestMode:(HomeRequestMode)requestMode requestWord:(NSString *)requestW requestPram:(NSString *)pram goodListState:(GoodListState )state classID:(NSString *)ID pageSize:(NSInteger)pageSize CompletionHandler:(void (^)(NSError * _Nonnull))completionHandler{
    NSInteger tempNum = 1;
    if (requestMode == HomeRequestModeMore) {
        tempNum = ++_pageNum;
    }
    
    NSString *classIDWord = @"";
    if (state == GoodListStateColumn) {
        classIDWord = @"categoryClassId";
    }else{
        classIDWord = @"goodsClassId";
    }
    
    
    [YDNetManager getCategoryCommodityListDataWithPath:kCommodityDetailURL requestWord:requestW requestPram:pram classIDWord:classIDWord classID:ID pageNum:tempNum goodNum:pageSize completionHandler:^(HomeGoodModel * _Nonnull model, NSError * _Nonnull error) {
        if ((!error)) {
            _pageNum = tempNum;
            if (requestMode == HomeRequestModeRefresh) {
                [self.pageList removeAllObjects];
            }
            self.totalPage = model.totalPages;
            [self.pageList addObjectsFromArray:model.pageList];
            completionHandler(error);
        }
    }];
}





@end
