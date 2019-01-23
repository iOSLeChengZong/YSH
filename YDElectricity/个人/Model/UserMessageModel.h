//
//  UserMessageModel.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/10.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class UserSystemMessage;
@interface UserMessageModel : NSObject<YYModel>
@property (nonatomic, strong) NSArray<UserSystemMessage *> * messageList;
@property (nonatomic, assign) NSInteger pageNo;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, assign) NSInteger totalPages;


@end

@interface UserSystemMessage : NSObject<YYModel>
@property (nonatomic, strong) NSString * addTime;
@property (nonatomic, strong) NSString * content;
//id -> ID
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) NSInteger userId;


@end

NS_ASSUME_NONNULL_END
