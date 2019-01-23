//
//  UserMessageViewModel.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/10.
//  Copyright © 2019 yuandian. All rights reserved.
//


#import "UserMessageViewModel.h"

@implementation UserMessageViewModel

-(NSInteger)itemCount{
    if (self.messages.count == 0) {
        return 0;
    }
    return self.messages.count;
}

-(NSString *)itemTitleAtIndextPath:(NSIndexPath *)indexPath{
    return self.messages[indexPath.row].title;
}

-(NSString *)itemTimeAtIndexPath:(NSIndexPath *)indexPath{
    return self.messages[indexPath.row].addTime;
}

-(NSString *)itemMessageAtIndexPath:(NSIndexPath *)indexPath{
    return self.messages[indexPath.row].content;
}




-(NSMutableArray<UserSystemMessage *> *)messages{
    if (!_messages) {
        _messages = [NSMutableArray new];
    }
    return _messages;
}


-(void)getSystemUserMessageRequestMode:(RequestMode)mode pageSize:(NSInteger)size CompletionHandler:(void (^)(NSError * _Nonnull))completionHandler{
    NSInteger tempNum = 1;
    if (mode == RequestModeMore) {
        tempNum = ++_pageNum;
    }
    [YDNetManager getSystemUserMessageWithPath:kUserMessageURL pageNum:tempNum pageSize:size completionHandler:^(UserMessageModel * _Nonnull model, NSError * _Nonnull error) {
        if (!error) {
            
            _pageNum = tempNum;
            
            if (model == RequestModeRefresh) {
                [self.messages removeAllObjects];
            }
            self.totalPage = model.totalPages;
            if (model.messageList.count == 0) {
                NSLog(@"消息数据为0");
                return;
            }
            [self.messages addObjectsFromArray:model.messageList];
            !completionHandler ?: completionHandler(error);
            
        }else{
            !completionHandler ?: completionHandler(error);
        }
    }];
}

@end
