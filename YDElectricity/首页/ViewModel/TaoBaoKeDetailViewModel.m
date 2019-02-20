//
//  TaoBaoKeDetailViewModel.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/5.
//  Copyright © 2019 yuandian. All rights reserved.
//


 
// /** 头部商品图URLS */
//@property(nonatomic,strong)NSArray *imageURLS;
///** 商品标题 */
//@property(nonatomic,strong)NSString *title;
///** 券后价 */
//@property(nonatomic,strong)NSString *discountPrice;
///** 原价 */
//@property(nonatomic,strong)NSString *originalPrice;
///** 月销 */
//@property(nonatomic,strong)NSString *monthSaleNum;
///** 优惠券 */
//@property(nonatomic,strong)NSString *couponPrice;
///** 使用期限 */
//@property(nonatomic,strong)NSString *serviceLife;
///** 商品品牌图名称 或url */
//@property(nonatomic,strong)NSString *shopImageName;
///** 商店名称 */
//@property(nonatomic,strong)NSString *shopName;
///** 体验来源图片或名字 */
//@property(nonatomic,strong)NSString *experienceName;
///** 宝贝描述评分 */
//@property(nonatomic,strong)NSString *babyDetailScore;
///** 卖家服务评分 */
//@property(nonatomic,strong)NSString *sellerScore;
///** 物流服务评分 */
//@property(nonatomic,strong)NSString *logisticsScore;



#import "TaoBaoKeDetailViewModel.h"

@implementation TaoBaoKeDetailViewModel

-(instancetype)initWithPageList:(PageList *)list{
    self = [super init];
    if (self) {
        self.list = list;
    }
    return self;
}

-(instancetype)initWithSpikeList:(GoodsSpikeList *)spikeList{
    self = [super init];
    if (self) {
        self.spikeList = spikeList;
    }
    return self;
}

-(NSArray *)imageURLS{
    if (_isSpike) {
        return @[self.spikeList.picUrl];
    }else{
       return (NSArray *)[TaoBaoKeDetailViewModel parseJSONStringToArrayOrDictionaryString:self.list.smallImages][@"string"];
    }
   
   
}

-(NSString *)imageName{
    return @"y_h_taobao";
}

-(NSString *)title{
    if (_isSpike) {
        return self.spikeList.title;
    }else{
        return self.list.title;
    }
    
}

//折扣价
- (NSString *)discountPrice{
    if (_isSpike) {
        return [NSString stringWithFormat:@"￥%.1f",self.spikeList.zkFinalPrice];
    }else{
       return [NSString stringWithFormat:@"￥%.1f",self.list.zkFinalPrice];
    }
    
}

-(NSString *)originalPrice{
    if (_isSpike) {
        return [NSString stringWithFormat:@"%.0f",self.spikeList.reservePrice];
    }else{
        return [NSString stringWithFormat:@"%.0f",self.list.reservePrice];
    }
    
}

-(NSString *)monthSaleNum{
    if (_isSpike) {
        return @"￥0.0";
    }else{
       return [NSString stringWithFormat:@"%ld",(long)self.list.volume];
    }
    
}


//优惠券
-(NSString *)couponPrice{
    if (_isSpike) {
        return @"￥0.0";
    }else{
        return [NSString stringWithFormat:@"￥%.1f",self.list.couponPrice];
    }
}


//券后价
-(NSString *)aftercouponPrice{
    if (_isSpike) {
        return [NSString stringWithFormat:@"￥%.0f",self.spikeList.zkFinalPrice];
    }else{
        return [NSString stringWithFormat:@"￥%.0f",(self.list.zkFinalPrice - self.list.couponPrice)];
    }
}

-(NSString *)serviceLife{
    
    if (_isSpike) {
        return [[[self.spikeList.startTime componentsSeparatedByString:@" "].firstObject stringByAppendingString:@"-"] stringByAppendingString:[self.spikeList.endTime componentsSeparatedByString:@" "].firstObject];
    }else{
     return [[[self.list.couponStartTime componentsSeparatedByString:@" "].firstObject stringByAppendingString:@"-"] stringByAppendingString:[self.list.couponEndTime componentsSeparatedByString:@" "].firstObject];
    }
    
}


-(NSString *)shopImageName{
    return @"";
}

-(NSString *)shopName{
    if (_isSpike) {
        return @" ";
    }else{
        return self.list.shopTitle;
    }
    
}

-(NSString *)experienceName{
    return @"";
}

-(NSString *)babyDetailScore{
    return @"";
}

-(NSString *)sellerScore{
    return @"";
}

-(NSString *)logisticsScore{
    return @"";
}

//预估收益
-(NSString *)estimateProfit{
    if (_isSpike) {
        return @"￥0.0";
    }
    return [NSString stringWithFormat:@"￥%.1f",self.list.commission];
}

-(NSURL *)mainImageUrl{
    NSLog(@"商品主图:%@",self.list.pictUrl);
    if (_isSpike) {
        return [NSURL URLWithString:self.spikeList.picUrl];
    }else{
       return [NSURL URLWithString:self.list.pictUrl];
    }
    
}


-(NSString *)buyURL{
    if (_isSpike) {
        return self.spikeList.clickUrl;
    }else{
       return self.list.itemUrl;
    }
    
}

@end
