//
//  MJBag.h
//  YDElectricity
//
//  Created by 元典 on 2018/11/27.
//  Copyright © 2018年 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



@interface MJBag : NSObject<MJCoding>
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) double price;


@end

NS_ASSUME_NONNULL_END
