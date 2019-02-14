//
//  HomeProductCellOne.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/4.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "HomeProductCellOne.h"

@interface HomeProductCellOne ()
//productImageView 约束
//高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productImageViewHeightC;

//saleNum 约束
//顶部约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *saleNmuTopC;

//productAfterSaleMoneyLabel 约束
//顶部约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productAfterSaleMoneyLabelTopC;

//productFromeSaleMoneyLabel约束
//宽度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productFromeSaleMoneyLabelWidthC;
//高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productFromeSaleMoneyLabelHeightC;

@end

@implementation HomeProductCellOne

- (void)awakeFromNib {
    [super awakeFromNib];
    [self HomeProductCellOneScreenFit];
}

#pragma mark -- 屏幕适配
-(void)HomeProductCellOneScreenFit
{
    _productImageViewHeightC.constant *= kWidthScall;
    
    _saleNmuTopC.constant *= kWidthScall;
    
    _productAfterSaleMoneyLabelTopC.constant *= kWidthScall;
    
    _productFromeSaleMoneyLabelWidthC.constant *= kWidthScall;
    _productFromeSaleMoneyLabelHeightC.constant *= kWidthScall;
}

@end
