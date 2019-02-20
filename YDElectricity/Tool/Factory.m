//
//  Factory.m
//  YDElectricity
//
//  Created by 元典 on 2018/11/27.
//  Copyright © 2018 yuandian. All rights reserved.
//


#import "Factory.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Factory
+ (BOOL)isPhoneNumber:(NSString *)phoneNum{
//    return phoneNum.length == 11 && phoneNum.doubleValue > 10000000000;
    
    //去掉空格
    if ([self checkEmptyString:phoneNum])  return NO;
    
    
    
    NSString *phoneRegex = @"^((1[34578]))\\d{9}$";
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phoneNum];

    
//    NSString *mobileRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[0678]|18[0-9]|14[57])[0-9]{8}$";
//    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobileRegex];
//    return [pre evaluateWithObject:phoneNum];//此处返回的是BOOL类型,YES or NO;
    
}

+ (BOOL) checkEmptyString:(NSString *) string {
    
    if (string == nil) return string == nil;
    
    NSString *newStr = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [newStr isEqualToString:@""];
}



#pragma mark 判断邮箱，手机，QQ的格式
+(BOOL)isValidateEmail:(NSString *)email{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
    
}

//验证手机号码的格式

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (void)addBackItemToVC:(UIViewController *)vc{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 44);
    [btn setImage:[UIImage imageNamed:@"返回_默认"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"返回_按下"] forState:UIControlStateHighlighted];
    
    [btn bk_addEventHandler:^(id sender) {
        [vc.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    //把视图的边角变为圆形, cornerRadius圆角半径
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    //弹簧控件, 修复边距
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    vc.navigationItem.leftBarButtonItems = @[spaceItem,backItem];
}

+ (void)playVideo:(NSURL *)videoURL{
//    YDPlayerViewController *vc = [YDPlayerViewController new];
//    AVPlayerItem *playItem = [AVPlayerItem playerItemWithURL:videoURL];
//    vc.player = [AVPlayer playerWithPlayerItem:playItem];
//    [vc.player play];
//    [kAppdelegate.window.rootViewController presentViewController:vc animated:YES completion:nil];
}

+ (void)addSearchItemToVC:(UIViewController *)vc clickHandler:(void(^)(void))clickHandler{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 42, 50, 44);
    CGRect frame = btn.frame;
    
    btn.center = CGPointMake(kScreenW * 0.5, 42);
    frame.size = CGSizeMake(264 * kWidthScall, 31);
    
    NSLog(@"buttonCenter:%f",btn.center.x);
    
    btn.frame =  frame;
    [btn setImage:[UIImage imageNamed:@"y_h_sousuokuang0"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"y_h_sousuokuang1"] forState:UIControlStateHighlighted];
    
//    btn.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleRightMargin;
//    btn.autoresizesSubviews = YES;
//
//    CGRect leftViewbounds = vc.navigationItem.leftBarButtonItem.customView.bounds;
//    CGRect rightViewbounds = vc.navigationItem.rightBarButtonItem.customView.bounds;
//    
//
//    CGRect frame1;
//    CGFloat maxWidth = leftViewbounds.size.width > rightViewbounds.size.width ? leftViewbounds.size.width : rightViewbounds.size.width;
//    maxWidth += 15;//leftview 左右都有间隙，左边是5像素，右边是8像素，加2个像素的阀值 5 ＋ 8 ＋ 2
//    frame1 = btn.frame;
//
//    frame1.size.width = kScreenW - maxWidth * 2;
//    btn.frame = frame1;
    
    
    vc.navigationItem.titleView = btn;

    NSLog(@"navCenter:%f",vc.navigationItem.titleView.center.x);
    [btn bk_addEventHandler:^(id sender) {
        clickHandler();
    } forControlEvents:UIControlEventTouchUpInside];
    //把视图的边角变为圆形, cornerRadius圆角半径
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    //弹簧控件, 修复边距
//    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    spaceItem.width = -15;
//    vc.navigationItem.rightBarButtonItems = @[spaceItem/*,backItem*/];
    
}



//即将开放
+(void)showWaittingForOpened{
    YDAlertView *allertView = [[YDAlertView alloc] initWithFrame:kAlertRect withTitle:@"提示" alertMessage:@"即将开放!" confrimBolck:^{
        NSLog(@"点击了确认");
    } cancelBlock:^{
        NSLog(@"点击了取消");
    }];
    [allertView show];
}

//未登陆提示
+(void)noneLoginTipConfrimBolck:(void (^)(void))confrimBlock CancelBlock:(void (^)(void))cancelBlock{
    YDAlertView *alertV = [[YDAlertView alloc] initWithFrame:kAlertRect withTitle:@"未登陆" alertMessage:@"请先登陆" confrimBolck:^{
        !confrimBlock ?: confrimBlock();
    } cancelBlock:^{
        !cancelBlock ?: cancelBlock();
    }];
    [alertV show];
    
}



//2、找出底部横线的函数
+ (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

@end
