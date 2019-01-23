//
//  UIView+HUD.h
//  YDElectricity
//
//  Created by 元典 on 2018/11/26.
//  Copyright © 2018年 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HUD)
    
//忙提示
- (void)showBusyHUD;

//文字提示
- (void)showWarning:(NSString *)warning;

//进度提示
- (void)showProgress:(float)progress;

//隐藏提示
- (void)hideBusyHUD;



    

@end

NS_ASSUME_NONNULL_END
