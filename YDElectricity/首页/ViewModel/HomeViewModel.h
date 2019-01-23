//
//  HomeViewModel.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/19.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDNetManager.h"
#import "TaoBaoKeDetailViewModel.h"

NS_ASSUME_NONNULL_BEGIN

//请求更多还是请求刷新
typedef NS_ENUM(NSInteger,HomeRequestMode) {
    HomeRequestModeRefresh,
    HomeRequestModeMore,
};

//热销爆款还是人气推荐
typedef NS_ENUM(NSInteger,HotOrRecomend) {
    HotOrRecomendR,
    HotOrRecomendH,
    
};

//区分请求栏目商品列表,分类商品列表
typedef NS_ENUM(NSInteger,GoodListState) {
    GoodListStateColumn,//栏目
    GoodListStateCategory,//分类
};



@interface HomeViewModel : NSObject
//首页头部
//1.根据UI
/** 轮播图URL */
-(NSArray *)advertiseURLS;
/** 栏目item数量 */
@property(nonatomic,assign)NSInteger culomnitemNum;
/** 栏目标题 */
-(NSString *)culomnCellTitleForItem:(NSIndexPath *)indexPath;
/** 栏目图片名字 */
-(NSString *)culomnCellImageNameForItem:(NSIndexPath *)indexPath;
/** 栏目ID */
-(NSString *)culomnGoodID:(NSIndexPath *)indexPath;
/** 秒杀商品 URL */
-(NSURL *)secondSkillGoodURL;



//2.根据接口
/** 头部广告URL */
@property(nonatomic,strong)NSMutableArray<AdvertisementList *> *advertiseMuArr;
@property(nonatomic,strong)NSMutableArray<CategoryClassList *> *categoryMuArr;
@property(nonatomic,strong)NSMutableArray<GoodsSpikeList *> *goodSpikeMuArr;
-(void)getHomeHeaderModelDataCompletionHandler:(void(^)(NSError *error))completionHandler;


//首页商品 / 商品详情
//1.根据UI
/** 商品item 数量*/
@property(nonatomic,assign)NSInteger goodCollectionVItemNum;
/** 商品图片 */
-(NSURL *)goodCollectionVItemImageURLAtIndexPath:(NSIndexPath *)indexPath;
/** 商品来源网站 */
-(NSString *)goodCollectionVItemSourseAtIndexPath:(NSIndexPath *)indexPath;
/** 商品名称 */
-(NSString *)goodCollectionVItemMainTitleAtIndexPath:(NSIndexPath *)indexPath;
/** 商品优惠信息 */
-(NSString *)goodCollectionVItemSecondTitleAtIndexPath:(NSIndexPath *)indexPath;
/** 原价 */
-(NSString *)goodCollectionVItemSoursePriceAtIndexPath:(NSIndexPath *)indexPath;
/** 商品券 */
-(NSString *)goodCollectionVitemTicketPriceAtIndexPath:(NSIndexPath *)indexPath;
/** 商品月销 */
-(NSString *)goodCollectionVItemMonthSaleNumAtIndexPath:(NSIndexPath *)indexPath;
/** 券后价 */
-(NSString *)goodCollectionVItemAfterSalePriceAtIndexPath:(NSIndexPath *)indexPath;
/** 收益 */
-(NSString *)goodCollectionVItemProfitAtIndexPath:(NSIndexPath *)indexPath;




//2.根据接口
@property(nonatomic,assign)NSInteger totalPage;
@property(nonatomic,assign)NSInteger pageNum;

//普通商品
@property(nonatomic,strong)NSMutableArray<PageList *> *pageList;
//秒杀商品

-(void)getHomeGoodModelDataRequestMode:(HomeRequestMode)requestMode pageSize:(NSInteger)pageSize state:(HotOrRecomend)hotOrRecomend CompletionHandler:(void(^)(NSError *error))completionHandler;

//分类商品
-(void)getCommodityModelDataRequestMode:(HomeRequestMode)requestMode requestWord:(NSString *)requestW requestPram:(NSString *)pram goodListState:(GoodListState)state classID:(NSString *)ID pageSize:(NSInteger)pageSize CompletionHandler:(void(^)(NSError *error))completionHandler;
@property(nonatomic,strong)NSArray *requestModeSet;








@end

NS_ASSUME_NONNULL_END
