//
//  titleView.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/7.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "titleView.h"

@interface titleView ()
@property(nonatomic,strong)UILabel *label;

@end

@implementation titleView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.label];
    }
    return self;
}

-(UILabel *)label{
    
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    
    return _label;
}

-(void)setFont:(UIFont *)font{
    _font = font;
    _label.font = font;
}

-(void)setText:(NSString *)text{
    _text = text;
    _label.text = text;
}

-(void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    _label.textColor = textColor;
}

@end
