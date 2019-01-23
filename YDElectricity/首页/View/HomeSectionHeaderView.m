//
//  HomeSectionHeaderView.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/12.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "HomeSectionHeaderView.h"

@interface HomeSectionHeaderView()
@property (nonatomic,strong) NSArray *colorArr;
@property (nonatomic,strong) NSArray *buttonArr;
@end

@implementation HomeSectionHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _colorArr = @[[UIColor blueColor],[UIColor whiteColor]];
    _buttonArr = @[_introBtn,_hotBtn];
}

- (IBAction)introBtnClick:(id)sender {
    [self setUpBtnClor:sender];
    !_clickHandler ?: _clickHandler(HomeRequestModeRefresh,HotOrRecomendR);
}

- (IBAction)hotBtnClick:(id)sender {
    [self setUpBtnClor:sender];
    !_clickHandler ?: _clickHandler(HomeRequestModeRefresh,HotOrRecomendH);

}


-(void)addClickHandler:(void (^)(HomeRequestMode,HotOrRecomend))hander{
    _clickHandler = hander;
}

#pragma mark -- 改变按钮颜色
-(void)setUpBtnClor:(id)sender{
    for (UIButton *btn in _buttonArr) {
        if ([(UIButton*)sender isEqual:btn]) {
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];

        }
    }
}

@end
