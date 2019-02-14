//
//  YDCustomButton.h
//  YDElectricity
//
//  Created by 元典 on 2019/2/13.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, YDCustomButtonType) {
    ButtonImageOriginal,// 原始位置。图片在左
    ButtonImageLeft, // 图片在左
    ButtonImageRight, // 图片在右
    ButtonImageTop, // 图片在上
    ButtonImageBottom, // 图片在下
};

@interface YDCustomButton : UIButton
- (instancetype)initWithBtnFrame:(CGRect)btnFrame btnType:(YDCustomButtonType)btnType titleAndImageSpace:(CGFloat)btnSpace imageSizeWidth:(CGFloat)btnImageWidth imageSizeHeight:(CGFloat)btnImageHeight;

@property (nonatomic, assign) YDCustomButtonType customBtnType;
@property (nonatomic, assign) CGFloat btnSpace;

@property (nonatomic, assign) CGFloat imgWidth;
@property (nonatomic, assign) CGFloat imgHeight;
@end

NS_ASSUME_NONNULL_END
