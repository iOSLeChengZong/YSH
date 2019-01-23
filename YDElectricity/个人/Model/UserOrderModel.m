//
//  UserOrderModel.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/18.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "UserOrderModel.h"

@implementation UserOrderModel

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"orderList":@"pageList"};
}
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"orderList":[UserOrderModelOrderInfo class]};
}
@end

@implementation UserOrderModelOrderInfo
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"goodsInfo":[UserOrderModelOrderInfoGoodInfo class]};
}

@end

@implementation UserOrderModelOrderInfoGoodInfo



@end
