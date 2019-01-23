//
//  Constant.h
//  YDElectricity
//
//  Created by 元典 on 2018/11/26.
//  Copyright © 2018年 yuandian. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

//屏幕宽度
#define kScreenW [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define kScreenH [UIScreen mainScreen].bounds.size.height

//判断设备类型
#define iPhone4 ([UIScreen mainScreen].bounds.size.height == 480)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
// 判断是否是iPhone X
#define iPhoneXORXS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXSMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneX iPhoneXORXS ^ iPhoneXR ^ iPhoneXSMax
// 状态栏高度
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (iPhoneX ? 88.f : 64.f)

// 导航栏高度（不包括状态栏）
#define NAVI_BAR_HEIGHT 44.0f

// Tab Bar高度
#define TABBAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)
#define kWidthScall kScreenW / 375.0 //这里的375我是针对6s为标准适配的,如果需要其他标准可以修改
#define kHightScall kScreenH / 667.0//对于iphoneX系列以6p为准

//点相对于相素倍数
#define kiPhonePointmultiple (iPhone5 | iPhone6 | iPhoneXR ? 2 : 3 )


//字体适配
#define font(R) (R)*(kScreenWidth)/320.0  //这里是5s屏幕字体
#define kFONT16 [UIFont systemFontOfSize:font(16.0f)]
//全局字体选中颜色
#define kFONTSlectRGB kRGBA(250, 15, 70, 1.0)
//全局字体默认颜色
#define KFontDefaultRGB kRGBA(114, 113, 113, 1.0)


//三原色的设置
#define kRGBA(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

//全局的灰色
#define kNaviBarBGColor kRGBA(215,215,215,1.0)
//全局View背景色
#define kViewBGColor    kRGBA(239,244,240,1.0)

//appdelegate的实例对象
#define kAppdelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

//把self转化为 __block __weak 的形式,方便在block中使用而不导致内存循环引用问题
//在宏中使用 \ 可以换行
#define WK(weakSelf) \
__block __weak __typeof(&*self)weakSelf = self;\


//是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
//是否为iOS8及以上系统
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

//Main  identifier
#define kMain @"Main"
#define kYDHome @"YDHome"
#define kYDDiscover @"YDDiscover"
#define kYDBusiness @"YDBusiness"
#define kYDPersonal @"YDPersonal"
#define kLogin @"Login"


//填写手机号吗segue
#define kPhoneNumSegue @"PhoneNumSegue"
//确认导师 segue
#define kConfirmTeacherSegue @"ConfirmTeacherSegue"


//用户微信ID
#define kUserWxOpenID @"wxOpenID"
//用户手机号码
#define kUserPhoneNum @"phoneNum"
#define kUserToken @"token"
#define kUserID @"userID"

//用户当前信息
#define kUserCurrentInfo @"currentInfo"
//当前选择的地址
#define kDefauleAddr @"DdfauleAddr"


#define kAlertRect CGRectMake(0, 0, 278, 195)




//https://www.jianshu.com/p/ba98b0ad1811 iOS截屏
//wifi密码
//ydkj66666
#endif /* Constant_h */
