//
//  NSObject+Parse.h
//  YDElectricity
//
//  Created by 元典 on 2018/11/27.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Parse)
+(id)parse:(id)responseObj;

//字符串转数组
+(id)parseJSONStringToArrayOrDictionaryString:(id)theData;

@end

NS_ASSUME_NONNULL_END
