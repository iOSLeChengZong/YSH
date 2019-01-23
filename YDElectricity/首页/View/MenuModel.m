//
//  MenuModel.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/3.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "MenuModel.h"

@implementation MenuModel
- (instancetype)init
{
    if (self = [super init]) {
        _state = @"0";
        _defaultColor = [UIColor darkGrayColor];
        _selectedColor = kRGBA(250, 15, 70, 1.0);
        _fontSize = 14;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    
    //[@"综合排序",@"优惠券面值由高到低",@"优惠券面值由低到高",@"预估佣金由高到低"];
    _title = title;
    if ([title rangeOfString:@"综合"].length) {
        _title = @"综合";
    }
    if ([title rangeOfString:@"优惠券"].length) {
        _title = @"优惠券";
    }
    if ([title rangeOfString:@"新品"].length) {
        _title = @"新品";
    }
    if ([title rangeOfString:@"佣金"].length) {
        _title = @"佣金";
    }
    
}


- (NSString *)imageNameWithState:(NSString *)state imageType:(ButtonImageType)imageType
{
    NSString *imageName = @"";
    switch (imageType) {
        case ImageTypeList:
            if ([state isEqualToString:@"0"]) {
                imageName = @"y_h_down00";
            }else if ([state isEqualToString:@"1"]){
                imageName = @"y_h_down1";
            }else if ([state isEqualToString:@"2"]){
                imageName = @"y_h_upward1";
            }else if ([state isEqualToString:@"3"]){
                imageName = @"shang_moren"; //这种状态暂时没用
            }
            break;
        case ImageTypeUpAndDown:
            if ([state isEqualToString:@"0"]) {
                imageName = @"y_h_weixuanze0";
            }else if ([state isEqualToString:@"1"]){
                imageName = @"y_h_down";
            }else{
                imageName = @"y_h_upward";
            }
            break;
        case ImageTypeChoose:
            if ([state isEqualToString:@"0"]) {
                imageName = @"y_h_style0";
            }else{
                imageName = @"y_h_style1";
            }
            break;
            
        default:
            break;
    }
    return imageName;
}


- (UIColor *)colorWithState:(NSString *)state
{
    UIColor *color = self.selectedColor;
    if ([state isEqualToString:@"0"] || [state isEqualToString:@"3"]) {
        color = self.defaultColor;
    }
    return color;
}
@end
