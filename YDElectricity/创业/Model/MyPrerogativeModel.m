//
//  MyPrerogativeModel.m
//  YDElectricity
//
//  Created by 元典 on 2019/2/15.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "MyPrerogativeModel.h"

@implementation MyPrerogativeModel

-(instancetype)init{
    self = [super init];
    if (self) {
        self.prerogativeImageNames = @[@"y_b_分享赚钱icon",@"y_b_自购省钱icon",@"y_b_培训津贴",
                                       @"y_b_管理奖金icon",@"y_b_伯乐奖金icon",@"y_b_签约平台icon"];
        self.prerogativeNames = @[@"分享赚钱",@"自购省钱",@"培训津贴",@"管理奖金",@"伯乐奖金",@"签约平台"];
    }
    return self;
}

@end
