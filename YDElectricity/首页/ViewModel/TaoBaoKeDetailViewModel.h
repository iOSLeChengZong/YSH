//
//  TaoBaoKeDetailViewModel.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/5.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaoBaoKeDetailViewModel : NSObject
//根据UI

@property(nonatomic,strong)PageList *list;
@property(nonatomic,strong)GoodsSpikeList *spikeList;
@property(nonatomic,assign)BOOL isSpike;

/** 头部商品图URLS */
@property(nonatomic,strong)NSArray *imageURLS;
/** 商品来源图标 */
@property(nonatomic,strong)NSString *imageName;

/** 商品标题 */
@property(nonatomic,strong)NSString *title;
/** 券后价 */
@property(nonatomic,strong)NSString *discountPrice;
/** 原价 */
@property(nonatomic,strong)NSString *originalPrice;
/** 月销 */
@property(nonatomic,strong)NSString *monthSaleNum;
/** 优惠券 */
@property(nonatomic,strong)NSString *couponPrice;
/** 券后价 */
@property(nonatomic,strong)NSString *aftercouponPrice;
/** 使用期限 */
@property(nonatomic,strong)NSString *serviceLife;
/** 商品品牌图名称 或url */
@property(nonatomic,strong)NSString *shopImageName;
/** 商店名称 */
@property(nonatomic,strong)NSString *shopName;
/** 体验来源图片或名字 */
@property(nonatomic,strong)NSString *experienceName;
/** 宝贝描述评分 */
@property(nonatomic,strong)NSString *babyDetailScore;
/** 卖家服务评分 */
@property(nonatomic,strong)NSString *sellerScore;
/** 物流服务评分 */
@property(nonatomic,strong)NSString *logisticsScore;
/** 预估收益 */
@property(nonatomic,strong)NSString *estimateProfit;


/** 分享界面商品主图 */
@property(nonatomic,strong)NSURL *mainImageUrl;
/** 商品二维码信息/下单链接 */
@property(nonatomic,strong)NSString *buyURL;




-(instancetype)initWithPageList:(PageList *)list;
-(instancetype)initWithSpikeList:(GoodsSpikeList *)spikeList;








@end

NS_ASSUME_NONNULL_END
