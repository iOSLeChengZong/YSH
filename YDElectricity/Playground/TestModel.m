//
//  TestModel.m
//  YDElectricity
//
//  Created by 元典 on 2018/11/29.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

-(instancetype)init{
    self = [super init];
    if (self) {
        _colorArr = @[[UIColor redColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor blueColor],[UIColor purpleColor]];;
    }
    return self;
}

@end
