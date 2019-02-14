//
//  InHomeHeaderCell.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/21.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "InHomeHeaderCell.h"

@interface InHomeHeaderCell ()
//culomnImage
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *culomnImageHeightConstrait;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *culomnImageWidthContrait;

@end

@implementation InHomeHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.culomnImageWidthContrait.constant *= kWidthScall;
    self.culomnImageHeightConstrait.constant *= kWidthScall;
}



@end
