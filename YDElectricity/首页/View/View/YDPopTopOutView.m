//
//  YDPopTopOutView.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/4.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "YDPopTopOutView.h"

@interface YDPopTopOutView()
@property(nonatomic,strong) UIButton *cancelBtn;
@property(nonatomic,strong) UIImageView *outerImage;
@property(nonatomic,strong) UIView *whiteView;
@property(nonatomic) CGRect topViewStartFrame;

@end

@implementation YDPopTopOutView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.topViewStartFrame = frame;
//        [self addAnimateViewFromTop];
    }
    return self;
}

//添加从顶部弹出的View
-(void)addAnimateViewFromTop{
    NSLog(@"delegate window:%@",[[[UIApplication sharedApplication] delegate] window]);
    NSLog(@"keywindow:%@",[UIApplication sharedApplication].keyWindow);
    
    [[[[UIApplication sharedApplication] delegate] window] addSubview:[self initPopBackgroundView]];
    [[[[UIApplication sharedApplication] delegate] window] bringSubviewToFront:[self initPopBackgroundView]];
    self.alpha = 1.0;
    self.cancelBtn.alpha = 0;
    self.whiteView = [[UIView alloc] initWithFrame:self.topViewStartFrame];//(25, -kScreenH, kScreenW -50, 500)
    self.whiteView.backgroundColor = kRGBA(1.0, 1.0, 1.0, 0.5);
    [self addSubview:self.whiteView];
    [self addWhiteViewSubView];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.whiteView.frame;
        
        frame.origin.y = (kScreenH  - frame.size.height) / 2;//kScreenH -470;
        self.whiteView.frame = frame;
        [self bringSubviewToFront:self.outerImage];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = self.whiteView.frame;
            frame.origin.y = (kScreenH  - frame.size.height) / 2 -140;//kScreenH -610;//140
            self.whiteView.frame = frame;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                CGRect frame = self.whiteView.frame;
                frame.origin.y = kScreenH * 0.5 - frame.size.height * 0.5;//kScreenH -570;//40
                self.whiteView.frame = frame;
            } completion:^(BOOL finished) {
                
                self.cancelBtn.alpha = 1.0;
                self.cancelBtn.frame = CGRectMake(CGRectGetMaxX(self.whiteView.frame)-40, CGRectGetMinY(self.whiteView.frame), 40, 40);
                [self.cancelBtn setImage:[UIImage imageNamed:@"cancel_white"] forState:UIControlStateNormal];
                [self.cancelBtn bk_addEventHandler:^(id sender) {
                    [self OnCloseBtnClick:self.cancelBtn];
                } forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:self.cancelBtn];
                
            }];
            
        }];
    }];
    
}

//初始化 弹出黑色背景视图
- (UIView *)initPopBackgroundView
{
    self.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    self.backgroundColor = kRGBA(0, 0, 0, 0.4);
    self.alpha = 0;
    
    //为落下的视图添加背景图
    UIImageView *innerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, kScreenH - 210, kScreenW, 210)];
    innerImage.image = [UIImage imageNamed:@"inner_layerImage"];
    [self addSubview:innerImage];
    UIImageView *outerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    outerImage.image = [UIImage imageNamed:@"outer_layerImage"];
    [self addSubview:outerImage];
    
    return self;
}

//添加白色子视图
- (void)addWhiteViewSubView
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.whiteView.frame.size.width, self.whiteView.frame.size.height)];
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.image = [UIImage imageNamed:@"bmw_image"];
    [self.whiteView addSubview:imageView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.whiteView.frame.size.width -10, 70)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.text = @"恭喜你获得一台别摸我";
    [imageView addSubview: titleLabel];
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLabel.frame), self.whiteView.frame.size.width -40, 70)];
    contentLabel.textColor = [UIColor orangeColor];
    contentLabel.font = [UIFont systemFontOfSize:15];
    contentLabel.numberOfLines = 0;
    contentLabel.textAlignment = NSTextAlignmentRight;
    contentLabel.text = @"别摸我是一款超级牛逼的车,据说是上天都不用的样子,全靠空气支撑,能上天,能下海,我只不过是瞎说的";
    [imageView addSubview:contentLabel];
    
}

//关闭按钮被点击
- (void) OnCloseBtnClick:(UIButton *)sender
{
    self.cancelBtn.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.whiteView.frame;
        frame.origin.y = -kScreenH;
        self.whiteView.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
