//
//  HomeProductCell.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/13.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "HomeProductCell.h"

@interface HomeProductCell ()
//1.商品主图高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productImageViewWidthContrait;

//2.productFromImage 约束
//顶部约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productFromImgeTopConstrait;
//左侧约束
//宽度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productFromImageWidthConstrait;
//高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productFromImageHeightContrait;


//3.productTitleLabel0 约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productTitleLabel0TopConstrait;

//4.productFromMoneyLabel 约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productFramMoneyLabelTopConstrait;

//5.productAfterSaleMoneyLabel约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productAfterSaleMoneyLabelTopConstrait;

//6.productFromeSaleMoneyLabel 约束
//宽高约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productFromSaleMoneyLabelWidthConstrait;
//高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productFromSaleLabelHeightConstrait;





@end

@implementation HomeProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    [self homeProductCellScreenFit];
}

//屏幕适配
-(void)homeProductCellScreenFit{
    _productImageViewWidthContrait.constant *= kWidthScall;
    
    _productFromImgeTopConstrait.constant *= kWidthScall;
    _productFromImageWidthConstrait.constant *= kWidthScall;
    _productFromImageHeightContrait.constant *= kWidthScall;
    
    _productTitleLabel0TopConstrait.constant *= kWidthScall;
    _productFramMoneyLabelTopConstrait.constant *= kWidthScall;
    
    _productAfterSaleMoneyLabelTopConstrait.constant *= kWidthScall;
    
    _productFromSaleMoneyLabelWidthConstrait.constant *= kWidthScall;
    _productFromSaleLabelHeightConstrait.constant *= kWidthScall;
    
    
    
    
}


@end
