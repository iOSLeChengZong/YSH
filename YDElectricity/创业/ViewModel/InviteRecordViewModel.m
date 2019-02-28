//
//  InviteRecordViewModel.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/21.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "InviteRecordViewModel.h"

@implementation InviteRecordViewModel


-(NSURL *)headURLAtIndexpath:(NSIndexPath *)indexPath{
    NSString *str = self.recordList[indexPath.row].headImgUrl;
    NSLog(@"strtt:%@",str);
    return [NSURL URLWithString:self.recordList[indexPath.row].headImgUrl];
}

-(NSString *)userNameAtIndexpath:(NSIndexPath *)indexPath{
    return self.recordList[indexPath.row].nickName;
}

-(NSString *)inviteTimeAtindexPath:(NSIndexPath *)indexPath{
    return self.recordList[indexPath.row].addTime;
}

-(NSString *)teamPeopleNumAtIndexPath:(NSIndexPath *)indexPath{
    return [NSString stringWithFormat:@"%ld",self.recordList[indexPath.row].userCount];
}

-(NSString *)contributeNumAtIndexPath:(NSIndexPath *)indexPath{
    return [NSString stringWithFormat:@"%.1lf",self.recordList[indexPath.row].grandTotalIncome];
}

-(NSString *)rankAtIndexPath:(NSIndexPath *)indexPath{
    return @"";
}


-(NSMutableArray<InviteRecordInfo *> *)recordList{
    if (!_recordList) {
        _recordList = [NSMutableArray new];
    }
    return _recordList;
}

-(void)getUserInviteRecordWithPageSize:(NSInteger)size orderType:(NSString *)type addTime:(NSString *)time requestMode:(InviteReRecordRequestMode)mode completionHandler:(void (^)(NSError * _Nonnull))completionHandler{
    

    NSInteger tempNum = 1;
    if (mode == InviteReRecordRequestModeMore) {
        tempNum = ++_pageNum;
    }
    
    [YDNetManager getUserInviteRecordWithPageNumber:tempNum pageSize:size orderType:type addTime:time completionHandler:^(InviteRecordModel * _Nonnull model, NSError * _Nonnull error) {
        if ((!error)) {
            _pageNum = tempNum;
            if (mode == InviteReRecordRequestModeRefresh) {
                [self.recordList removeAllObjects];
            }
            self.totalPage = model.totalPages;
            [self.recordList addObjectsFromArray:model.recordInfo];
            !completionHandler ?: completionHandler(error);
        }else{
            !completionHandler ?: completionHandler(error);
        }
    }];
    
    

}
@end
