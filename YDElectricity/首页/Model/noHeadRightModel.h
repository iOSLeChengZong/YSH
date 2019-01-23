//
//  noHeadRightModel.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/7.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface noHeadRightModel : NSObject
//实体leftTageModel中的主键值
@property(assign,nonatomic)long tagID;

@property(assign,nonatomic)long roomID;
@property(copy,nonatomic)NSString *roomName;
@property(copy,nonatomic)NSString *roomImageUrl;
@end

NS_ASSUME_NONNULL_END
