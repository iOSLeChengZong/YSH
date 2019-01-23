//
//  UIView+HUD.m
//  YDElectricity
//
//  Created by 元典 on 2018/11/26.
//  Copyright © 2018年 yuandian. All rights reserved.
//

#import "UIView+HUD.h"
//超时
#define kTimeOut 5
//弹出提示时长
#define kDuration 1

static NSMutableArray *imageList = nil;

@implementation UIView (HUD)
    
    -(void)showBusyHUD{
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self animated:YES];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
            //自定义繁忙视图
//            hud.mode = MBProgressHUDModeCustomView;
//            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
//            static dispatch_once_t onceToken;
//            dispatch_once(&onceToken, ^{
//                NSArray *imageNames = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06"];
//                imageList = [NSMutableArray new];
//                for (int i = 0; i < imageNames.count; ++i) {
//                    [imageList addObject:[UIImage imageNamed:imageNames[i]]];
//                }
//            });
//            imageView.animationImages = imageList;
//            imageView.animationDuration = kDuration;
//            [imageView startAnimating];
//            hud.bezelView.color = [UIColor clearColor];
            [hud hideAnimated:YES afterDelay:kTimeOut];
            
        });
    }

    -(void)showWarning:(NSString *)warning{
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self animated:YES];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = warning;
            [hud hideAnimated:YES afterDelay:kDuration];
            
        });
    }

-(void)showProgress:(float)progress{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeDeterminate;
        hud.label.text = @"上传";
        hud.label.font = [UIFont systemFontOfSize:12];
        hud.bezelView.alpha = 0.9;
        hud.margin = 15;
        [hud showAnimated:YES];
        hud.progress = progress;
        
    });
}

    -(void)hideBusyHUD{
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self animated:YES];
        });
    }
    
@end
