//
//  NSObject+MJExtension.h
//  YDElectricity
//
//  Created by 元典 on 2018/11/27.
//  Copyright © 2018年 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (MJExtension)
//解析
+ (id)parse:(id)responseObj;
//属性名和key映射
+ (NSString *)replacedKeyFromPropertyName:(NSString *)propertyName;
//属性与类名映射
+(NSDictionary *)objectClassInArray;

@end

NS_ASSUME_NONNULL_END
