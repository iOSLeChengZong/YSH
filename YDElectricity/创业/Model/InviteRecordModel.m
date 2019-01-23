//
//  InviteRecordModel.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/21.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "InviteRecordModel.h"

@implementation InviteRecordModel
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"recordInfo":[InviteRecordInfo class]};
}

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"recordInfo":@"pageList"};
}
@end

@implementation InviteRecordInfo

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"grandTotalIncome":@"grand_total_income",
             @"addTime":@"add_time",
             @"headImgUrl":@"head_img_url",
             @"nickName":@"nick_name"
             };
}

@end
