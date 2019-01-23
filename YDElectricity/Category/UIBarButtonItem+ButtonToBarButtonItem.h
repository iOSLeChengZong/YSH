//
//  UIBarButtonItem+ButtonToBarButtonItem.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/12.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (ButtonToBarButtonItem)
/** 文字BarButtonItem */
+(instancetype)BarButtonItemWithTitle:(NSString *)title stytle:(UIBarButtonItemStyle) stytle target:(id)target action:(SEL)action;

/** 设置图片类BarButtonItem */
+(instancetype)BarButtonItemWithBackgrounImageName:(NSString *)backgroundImageName highBackgroundImageName:(NSString *)hightBackgroundImageName target:(id)target aciton:(SEL)action;


/** 图片加文字的BarButtonItem */
+(instancetype)BarButtonItemWithImageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName title:(NSString *)title target:(id)target action:(SEL)action;

/** 调整左边BarButtomItem间距 */
+(NSArray<UIBarButtonItem *> *)LeftBarButtomItems:(BOOL) isLeft ImageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName title:(NSString *)title target:(id)target action:(SEL)action;


@end

NS_ASSUME_NONNULL_END
