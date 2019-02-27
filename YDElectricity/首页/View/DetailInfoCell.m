//
//  DetailInfoCell.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/26.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "DetailInfoCell.h"

@interface DetailInfoCell ()

@end

@implementation DetailInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)getBtnClick:(id)sender {
    !_clickHandler ?: _clickHandler();
}


-(void)addClickHandler:(void (^)(void))hander{
    _clickHandler = hander;
}



@end
