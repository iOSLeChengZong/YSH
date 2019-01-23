//
//  MJStudent.h
//  YDElectricity
//
//  Created by 元典 on 2018/11/27.
//  Copyright © 2018年 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MJBag;
@interface MJStudent : NSObject<MJCoding>
@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *otherName;
@property (copy, nonatomic) NSString *nowName;
@property (copy, nonatomic) NSString *oldName;
@property (copy, nonatomic) NSString *nameChangedTime;
@property (copy, nonatomic) NSString *desc;
@property (strong, nonatomic) MJBag *bag;
@property (strong, nonatomic) NSArray *books;
@end

NS_ASSUME_NONNULL_END
