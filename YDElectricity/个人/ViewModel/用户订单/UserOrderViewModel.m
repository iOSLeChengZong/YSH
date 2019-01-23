//
//  UserOrderViewModel.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/18.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "UserOrderViewModel.h"
#import "UserIdendityModel.h"

 
// /** 订单数量 */
//-(NSString *)goodsNum;
///** 商品imageURL */
//-(NSURL *)goodsImageURLAtIndexpath:(NSIndexPath *)indexpath;
///** 商品平台图标 */
//-(NSString *)goodsPlatformImage;
///** 商品标题 */
//-(NSString *)goodsTitle;
///** 订单号 */
//-(NSString *)orderNum;
///** 下单时间 */
//-(NSString *)orderTime;
///** 订单状态 */
//-(NSString *)orderState;
///** 金额 */
//-(NSString *)goodsPrice;
///** 预估奖励 */
//-(NSString *)estimateAward;



@implementation UserOrderViewModel
-(NSInteger)goodsNum{
    return self.orderList.count;
}

-(NSURL *)goodsImageURLAtIndexpath:(NSIndexPath *)indexpath{
    NSString *urlStr = self.orderList[indexpath.row].goodsInfo.pictUrl;
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@"\\/" withString:@"//"];
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@"////" withString:@"//"];

    return [NSURL URLWithString:urlStr];
}
-(NSString *)goodsPlatformImage{
    return @"淘宝";
}

-(NSString *)goodsTitleAtIndexpath:(NSIndexPath *)indexpath{
    return self.orderList[indexpath.row].goodsInfo.title;
}

-(NSString *)orderNumAtIndexpath:(NSIndexPath *)indexpath{
    return self.orderList[indexpath.row].orderId;
}

-(NSString *)orderTimeAtIndexpath:(NSIndexPath *)indexpath{
    return self.orderList[indexpath.row].addTime;
}

-(NSString *)orderStateAtIndexpath:(NSIndexPath *)indexpath{
    
    switch (self.orderList[indexpath.row].state) {
        case 3:
            return @"已结算";
            break;
            
        case 12:
            return @"已付款";
            break;
            
        case 13:
            return @"已失效";
            break;
        case 14:
            return @"已成功";
            break;
            
        default:
            return @"未知";
            break;
    }
}

-(NSString *)goodsPriceAtIndexpath:(NSIndexPath *)indexpath{
    return [NSString stringWithFormat:@"￥%.1f",self.orderList[indexpath.row].alipayTotalPrice];
}

-(NSString *)estimateAwardAtIndexpath:(NSIndexPath *)indexpath{
    return [NSString stringWithFormat:@"￥%.1f",self.orderList[indexpath.row].totalCommissionFee];
}

-(NSMutableArray *)orderList{
    if (!_orderList) {
        _orderList = [NSMutableArray new];
    }
    
    return _orderList;
}


-(void)getUserOrderListWithRequestMode:(OrderRequestMode)mode pageSize:(NSInteger)size orderMode:(OrderType)type completionHandler:(void (^)(NSError * _Nonnull error))completionHandler{
    NSInteger tempNum = 1;
    if (mode == OrderRequestModeMore) {
        tempNum = ++_pageNum;
    }

    
    
    NSString *str = nil;
    if (type == OrderTypeALL) {
        str = @"";
    }else{
        str = [NSString stringWithFormat:@"%ld",type];
    }
    [YDNetManager getUserOrderlistPageNum:tempNum pageSize:size userPid:[UserIdendityModel sharedUserIdendityModel].info.pid orderType:str CompletionHandler:^(UserOrderModel * _Nonnull model, NSError * _Nonnull error) {
        if ((!error)) {
            _pageNum = tempNum;
            if (mode == OrderRequestModeRefresh) {
                [self.orderList removeAllObjects];
            }
            self.totalPage = model.totalPages;
            [self.orderList addObjectsFromArray:model.orderList];
            
            completionHandler(error);
        }
    }];
}


    

@end
