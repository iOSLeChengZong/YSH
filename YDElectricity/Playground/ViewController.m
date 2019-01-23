//
//  ViewController.m
//  YDElectricity
//
//  Created by 元典 on 2018/11/26.
//  Copyright © 2018年 yuandian. All rights reserved.
//

#import "ViewController.h"
#import "TestModel.h"

#import "YDIntroHeaderCell.h"

@interface ViewController ()



@end

@implementation ViewController
#pragma mark -- 生命周期


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(self.view.center.x-50, self.view.center.y-40, 100, 80);
    btn.backgroundColor = [UIColor grayColor];
    btn.titleLabel.text = @"TEST";
    btn.titleLabel.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:btn];

    
    
                                            
}





@end
