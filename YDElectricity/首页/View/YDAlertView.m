//
//  YDAlertView.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/3.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "YDAlertView.h"
#define TagValue  1000
#define AlertTime 0.3 //弹出动画时间
#define DropTime 0.5 //落下动画时间

@interface YDAlertView()

@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,strong)UILabel *ContentLB;
@property(nonatomic,strong)UIButton *cancleBtn;
@property(nonatomic,strong)UIButton *sureBtn;



@end

@implementation YDAlertView

-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title alertMessage:(NSString *)msg confrimBolck:(void (^)())confrimBlock cancelBlock:(void (^)())cancelBlock{
    if (self = [super initWithFrame:frame]) {
        [self customUIwith:frame title:title message:msg];
        _sureBlock = confrimBlock;
        _cancleBlock = cancelBlock;
    }
    return self;
}


-(void)customUIwith:(CGRect)frame title:(NSString *)title message:(NSString *)msg{
    UIImageView *bgimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    bgimageview.image = [UIImage imageNamed:@"y_b_分享订单pop"];
    [self addSubview:bgimageview];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    
    _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, frame.size.width-30, 54)];
    _titleLB.textColor = [UIColor whiteColor];
    _titleLB.textAlignment = NSTextAlignmentCenter;
    _titleLB.font = [UIFont systemFontOfSize:15];
    [self addSubview:_titleLB];
    
    _ContentLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 54, frame.size.width-30, 107)];
    _ContentLB.numberOfLines = 0;
    _ContentLB.textAlignment = NSTextAlignmentCenter;//NSTextAlignmentLeft;
    _ContentLB.textColor = kFONTSlectRGB;
    _ContentLB.font = [UIFont systemFontOfSize:21];
    [self addSubview:_ContentLB];
    
    _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_cancleBtn setBackgroundImage:[UIImage imageNamed:@"alertCanclebtn"] forState:UIControlStateNormal];
    [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    _cancleBtn.titleLabel.font = _titleLB.font = [UIFont systemFontOfSize:15];
    [_cancleBtn setTitleColor:KFontDefaultRGB forState:UIControlStateNormal];
    _cancleBtn.frame = CGRectMake(43, 161, 70, 30);
    [self addSubview:_cancleBtn];
    [_cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_sureBtn setBackgroundImage:[UIImage imageNamed:@"alertSuerbtn"] forState:UIControlStateNormal];
    [_sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    _sureBtn.titleLabel.font = _titleLB.font = [UIFont systemFontOfSize:15];
    [_sureBtn setTitleColor:kFONTSlectRGB forState:UIControlStateNormal];
    _sureBtn.frame = CGRectMake(177, 161, 70, 30);
    [self addSubview:_sureBtn];
    [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _titleLB.text = title;
    _ContentLB.text = msg;
    
}

-(void)cancleBtnClick{
    [self hide];
    if (_cancleBlock) {
        _cancleBlock();
    }
}
-(void)sureBtnClick{
    [self hide];
    if (_sureBlock) {
        _sureBlock();
    }
}


-(void)show{
    if (self.superview) {
        [self removeFromSuperview];
    }
    UIView *oldView = [[UIApplication sharedApplication].keyWindow viewWithTag:TagValue];
    if (oldView) {
        [oldView removeFromSuperview];
    }
    UIView *iview = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    iview.tag = TagValue;
    iview.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [iview addGestureRecognizer:tap];
    iview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [[UIApplication sharedApplication].keyWindow addSubview:iview];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.center = [UIApplication sharedApplication].keyWindow.center;
    self.alpha = 0;
    self.transform = CGAffineTransformScale(self.transform,0.1,0.1);
    [UIView animateWithDuration:AlertTime animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}


//弹出隐藏
-(void)hide{
    if (self.superview) {
        [UIView animateWithDuration:AlertTime animations:^{
            self.transform = CGAffineTransformScale(self.transform,0.1,0.1);
            self.alpha = 0;
        } completion:^(BOOL finished) {
            UIView *bgview = [[UIApplication sharedApplication].keyWindow viewWithTag:TagValue];
            if (bgview) {
                [bgview removeFromSuperview];
            }
            [self removeFromSuperview];
        }];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
