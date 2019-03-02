//
//  AppDelegate.m
//  YDElectricity
//
//  Created by 元典 on 2018/11/26.
//  Copyright © 2018年 yuandian. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+System.h"
#import <MJExtension.h>
#import "MJStudent.h"
#import "MJBag.h"

#import "ViewController.h"

#import <ShareSDK/ShareSDK.h>
#import "AppDelegate+YDShareSDK.h"

#import "Person.h"
#import "CityDataViewModel.h"
#import "YDNetManager.h"
#import <QMapKit/QMapKit.h>

//test
//#import "UserTaskViewModel.h"


@interface AppDelegate ()
@property(nonatomic,strong)CityDataViewModel *cityDataVM;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //程序开始启动
    //设置app全局默认配置
    [self setupGlobalClobalConfig];
    //获取本地微信appid
    
    //腾讯地图
    [QMapServices sharedServices].apiKey = kQMAPKEY;
    
//    [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
//    for (NSString *fontFamilyName in UIFont.familyNames) {
//        NSLog(@"familyName:%@", fontFamilyName);
//        for (NSString *fontName in [UIFont fontNamesForFamilyName:fontFamilyName]) {
//            NSLog(@"fontName:%@", fontName);
//        }
//    }
    
   

    return YES;
}


@end
