//
//  Factory.h
//  YDElectricity
//
//  Created by 元典 on 2018/11/27.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Factory : NSObject
/** 添加左上角返回按钮 */
+ (void)addBackItemToVC:(UIViewController *)vc;

/** md5加密 */
+ (NSString *)md5:(NSString *)str;

/** 视频播放器 */
+ (void)playVideo:(NSURL *)videoURL;

/** 右上角添加搜索按钮 */
+ (void)addSearchItemToVC:(UIViewController *)vc clickHandler:(void(^)(void))clickHandler;


/** 验证手机号吗合法性 */
+ (BOOL)isPhoneNumber:(NSString *)phoneNum;

+(BOOL)isValidateEmail:(NSString *)email;
+ (BOOL)isMobileNumber:(NSString *)mobileNum;


/** 即将开发提示 */
+(void)showWaittingForOpened;

@end

NS_ASSUME_NONNULL_END
