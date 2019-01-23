//
//  UserOrderViewModel.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/18.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDNetManager.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger,OrderRequestMode) {
    OrderRequestModeRefresh,
    OrderRequestModeMore,
};

//定义一个订单状态枚举
typedef NS_ENUM(NSInteger,OrderType) {
    OrderTypeALL,
    OrderTypeBUYED = 12,
    OrderTypeCLOSE = 3,
    OrderTypeDISABLE = 13,
    
};

@interface UserOrderViewModel : NSObject
//1.根据UI
/** 订单数量 */
-(NSInteger)goodsNum;
/** 商品imageURL */
-(NSURL *)goodsImageURLAtIndexpath:(NSIndexPath *)indexpath;
/** 商品平台图标 */
-(NSString *)goodsPlatformImage;
/** 商品标题 */
-(NSString *)goodsTitleAtIndexpath:(NSIndexPath *)indexpath;
/** 订单号 */
-(NSString *)orderNumAtIndexpath:(NSIndexPath *)indexpath;
/** 下单时间 */
-(NSString *)orderTimeAtIndexpath:(NSIndexPath *)indexpath;
/** 订单状态 */
-(NSString *)orderStateAtIndexpath:(NSIndexPath *)indexpath;
/** 金额 */
-(NSString *)goodsPriceAtIndexpath:(NSIndexPath *)indexpath;
/** 预估奖励 */
-(NSString *)estimateAwardAtIndexpath:(NSIndexPath *)indexpath;


//2.根据接口
@property(nonatomic,assign)NSInteger pageNum;
@property(nonatomic,assign)NSInteger totalPage;
@property(nonatomic,strong)NSMutableArray<UserOrderModelOrderInfo *> *orderList;


-(void)getUserOrderListWithRequestMode:(OrderRequestMode)mode pageSize:(NSInteger)size orderMode:(OrderType)type completionHandler:(void(^)(NSError *error))completionHandler;

@end

NS_ASSUME_NONNULL_END
