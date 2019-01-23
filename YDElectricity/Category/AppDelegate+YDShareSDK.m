//
//  AppDelegate+YDShareSDK.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/5.
//  Copyright © 2018 yuandian. All rights reserved.
//


/**
 ShareSDK使用方法:
 1.需要在分享的试图中导入的头文件: #import <ShareSDK/ShareSDK.h>   #import <ShareSDKUI/ShareSDK+SSUI.h>
 2.调用构造分享参数接口和分享的接口
 
 NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];
 （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传image参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
 if (imageArray) {
 
 NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
 [shareParams SSDKSetupShareParamsByText:@"分享内容"
 images:imageArray
 url:[NSURL URLWithString:@"http://mob.com"]
 title:@"分享标题"
 type:SSDKContentTypeAuto];
 //有的平台要客户端分享需要加此方法，例如微博
 [shareParams SSDKEnableUseClientShare];
 //2、分享（可以弹出我们的分享菜单和编辑界面）
 [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
 items:nil
 shareParams:shareParams
 onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
 
 switch (state) {
 case SSDKResponseStateSuccess:
 {
 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
 message:nil
 delegate:nil
 cancelButtonTitle:@"确定"
 otherButtonTitles:nil];
 [alertView show];
 break;
 }
 case SSDKResponseStateFail:
 {
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
 message:[NSString stringWithFormat:@"%@",error]
 delegate:nil
 cancelButtonTitle:@"OK"
 otherButtonTitles:nil, nil];
 [alert show];
 break;
 }
 default:
 break;
 }
 }
 ];}
 
 //大家请注意：4.1.2版本开始因为UI重构了下，所以这个弹出分享菜单的接口有点改变，如果集成的是4.1.2以及以后版本，如下调用：
 [ShareSDK showShareActionSheet:nil customItems:nil shareParams:shareParams sheetConfiguration:nil onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
 switch (state) {
 case SSDKResponseStateSuccess:
 {
 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
 message:nil
 delegate:nil
 cancelButtonTitle:@"确定"
 otherButtonTitles:nil];
 [alertView show];
 break;
 }
 case SSDKResponseStateFail:
 {
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
 message:[NSString stringWithFormat:@"%@",error]
 delegate:nil
 cancelButtonTitle:@"OK"
 otherButtonTitles:nil, nil];
 [alert show];
 break;
 }
 default:
 break;
 }
 }];
 
 
 
 
 */


#import "AppDelegate+YDShareSDK.h"
#import <ShareSDK/ShareSDK.h>


@implementation AppDelegate (YDShareSDK)

-(void)didFinishLaunchingWithOptionsForShareSDK
{
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        //QQ
        [platformsRegister setupQQWithAppId:@"100371282" appkey:@"aed9b0303e3ed1e27bae87c33761161d"];

        //微信
        [platformsRegister setupWeChatWithAppId:@"wx617c77c82218ea2c" appSecret:@"c7253e5289986cf4c4c74d1ccc185fb1"];

        //新浪
        [platformsRegister setupSinaWeiboWithAppkey:@"568898243" appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3" redirectUrl:@"http://www.sharesdk.cn"];

    }];

}

//Please use application:openURL:options:
//-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//    return NO;
//}

//-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
//    return NO;
//
//}


@end
