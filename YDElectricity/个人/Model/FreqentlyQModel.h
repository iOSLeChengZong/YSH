//
//  FreqentlyQModel.h
//  YDElectricity
//
//  Created by 元典 on 2019/2/16.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FreqentlyQModel : NSObject
//name
@property(nonatomic,strong) NSString *name;
//内容
@property(nonatomic,strong) NSString *content;
//是否打开
@property(assign,nonatomic) BOOL isOpen;


@end

NS_ASSUME_NONNULL_END
