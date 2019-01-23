//
//  MenuButton.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/3.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MenuButton : UIButton
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) NSInteger titleFont;
@property (nonatomic,strong) UIColor *titleColor;
@property (nonatomic,strong) MenuModel *model;

@end

NS_ASSUME_NONNULL_END
