//
//  Person.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/6.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "Person.h"

@interface Person ()
{
    NSString *address;
}
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)NSInteger age;

@end

@implementation Person

/**
 遍历获取Person类所有的成员变量IvarList
 */
-(void)getAllIvarList
{
    unsigned int methodCount = 0;
    /**
     1.Ivar代表实例变量,结构体指针,
     2.class_copyIvarList 获取所有成员变量名称
     3.ivar_getName 获取成员变量名
     4.aivar_getTypeEncoding  获取成员变量类型编码
     */
    Ivar * ivars = class_copyIvarList([UIBarButtonItem class], &methodCount);
    for (unsigned int i = 0; i < methodCount; i ++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        const char * type = ivar_getTypeEncoding(ivar);
        NSLog(@"Person拥有的成员变量的类型为%s，名字为 %s ",type, name);
    }
    free(ivars);
    
}


/**
 遍历获取所有属性Property
 */
- (void) getAllProperty {
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([UIBarButtonItem class], &propertyCount);
    for (unsigned int i = 0; i < propertyCount; i++ ) {
        objc_property_t *thisProperty = &propertyList[i];//propertyList[i];
        const char* propertyName = property_getName(*thisProperty);
        NSLog(@"Person拥有的属性为: '%s'", propertyName);
    }
}


@end
