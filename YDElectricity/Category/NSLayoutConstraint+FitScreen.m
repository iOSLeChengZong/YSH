//
//  NSLayoutConstraint+FitScreen.m
//  YDElectricity
//
//  Created by 李城宗 on 2019/2/24.
//  Copyright © 2019年 yuandian. All rights reserved.
//

#import "NSLayoutConstraint+FitScreen.h"
#import <objc/runtime.h>

@implementation NSLayoutConstraint (FitScreen)


+ (void)load{

    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}



- (id)myInitWithCoder:(NSCoder*)aDecode
{
    [self myInitWithCoder:aDecode];
    if (self){
        
        if(![self.identifier isEqualToString:@"666"])    // 也可以加一个判断条件，只对符合条件的约束进行适配
        {
            self.constant *= kWidthScall;
        }else{
            self.constant = -STATUS_BAR_HEIGHT;
        }
    }
    return self;
}

@end
