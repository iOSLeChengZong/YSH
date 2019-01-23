//
//  AppDelegate+System.h
//  YDElectricity
//
//  Created by 元典 on 2018/11/26.
//  Copyright © 2018年 yuandian. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN




@interface AppDelegate (System)
@property (nonatomic,readonly) AFNetworkReachabilityStatus netReachStatus;
@property (nonatomic,getter=isOnLine,readonly) BOOL onLine;
    
-(void) setupGlobalClobalConfig;
//-(void)showEnterApp;
@end

NS_ASSUME_NONNULL_END
