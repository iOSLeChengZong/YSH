//
//  AddressListCell.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/16.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "AddressListCell.h"

@implementation AddressListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setAddrModel:(AddressDataModel *)addrModel{
    _addrModel = addrModel;
    _nameLabel.text = _addrModel.name;
    _telePhoneLabel.text = _addrModel.telphone;
    _addressLabel.text = [_addrModel.detailAddr stringByAppendingString:_addrModel.areaStr];
    
    if ([_addrModel.defaultStr isEqualToString:@"默认"]) {
        _defaultLabel.text = _addrModel.defaultStr;
        [_defaultBtn setImage:[UIImage imageNamed:@"y_p_choose1"] forState:UIControlStateNormal];
    }else{
        _defaultLabel.text = @"";
        [_defaultBtn setImage:[UIImage imageNamed:@"y_p_choose0"] forState:UIControlStateNormal];
    }
    
    
    
}

- (IBAction)defaultAddressBtnClick:(id)sender {
   
    !self.delegate ?: [self.delegate onSetDefaultAddrWithIndex:self.index click:sender];
    
}

- (IBAction)idetorBtnClick:(id)sender {
    !self.delegate ?: [self.delegate onAddrEditWithIndex:self.index];
}

- (IBAction)deleteBtnClick:(id)sender {
    !self.delegate ?: [self.delegate onAddrDelWithIndex:self.index];
}

@end
