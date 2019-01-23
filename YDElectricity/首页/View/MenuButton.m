//
//  MenuButton.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/3.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "MenuButton.h"

@implementation MenuButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect titleF = self.titleLabel.frame;
    CGRect imageF = self.imageView.frame;
    CGFloat x = (self.bounds.size.width - titleF.size.width - imageF.size.width)/2;
    titleF.origin.x = x;
    self.titleLabel.frame = titleF;
    imageF.origin.x = CGRectGetMaxX(titleF);
    self.imageView.frame = imageF;
}


- (void)setModel:(MenuModel *)model
{
    _model = model;
    self.title = model.title;
    self.titleFont = model.fontSize;
    self.titleColor = [model colorWithState:model.state];
    [self setImage:[UIImage imageNamed:[model imageNameWithState:model.state imageType:model.imageType]] forState:UIControlStateNormal];
    
}


- (void)setTitle:(NSString *)title
{
    _title = title;
    [self setTitle:_title forState:UIControlStateNormal];
}

- (void)setTitleFont:(NSInteger)titleFont
{
    _titleFont = titleFont;
    self.titleLabel.font = [UIFont systemFontOfSize:_titleFont];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}

@end
