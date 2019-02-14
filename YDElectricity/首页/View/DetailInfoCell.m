//
//  DetailInfoCell.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/26.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "DetailInfoCell.h"

@interface DetailInfoCell ()
//imageName约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageNameTopC;

//title约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTopC;

//discountPrice约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *discountPriceTopc;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *couponViewBottomC;


//couponPrice约束
//top
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *couponPriceTopC;
//leading
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *couponPriceLeadingC;

//serviceLife约束
//leading
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *serviceLiftLeadingC;
//top
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *serviceLifteBottomC;

//立即领取约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *getBtnLeading;

@end

@implementation DetailInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self DetailInfoCellScreenFit];
}

- (IBAction)getBtnClick:(id)sender {
    !_clickHandler ?: _clickHandler();
}


-(void)addClickHandler:(void (^)(void))hander{
    _clickHandler = hander;
}

-(void)DetailInfoCellScreenFit{
    _imageNameTopC.constant *= kWidthScall;
    _titleTopC.constant *= kWidthScall;
    _discountPriceTopc.constant *= kWidthScall;
    _couponViewBottomC.constant *= kWidthScall;
    
    _couponPriceTopC.constant *= kWidthScall;
    _couponPriceLeadingC.constant *= kWidthScall;
    
    _serviceLifteBottomC.constant *= kWidthScall;
    _serviceLiftLeadingC.constant *= kWidthScall;
    _getBtnLeading.constant *= kWidthScall;
    
}

@end
