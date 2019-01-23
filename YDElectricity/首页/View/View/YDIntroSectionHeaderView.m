//
//  YDIntroSectionHeaderView.m
//  YDElectricity
//
//  Created by 元典 on 2018/11/28.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "YDIntroSectionHeaderView.h"

@implementation YDIntroSectionHeaderView
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *lineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"栏目标题"]];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(8);
            make.bottom.equalTo(0);
            make.size.equalTo(CGSizeMake(3, 20));
        }];
        [self addSubview:self.titleLb];
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lineView.mas_right).equalTo(8);
            make.centerY.equalTo(lineView);
        }];
        
        [self addSubview:self.changeControl];
        [self.changeControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-15);
            make.bottom.equalTo(0);
            make.size.equalTo(CGSizeMake(60, 20));
        }];
        [self addSubview:self.moreControl];
        [self.moreControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-15);
            make.bottom.equalTo(0);
            make.size.equalTo(CGSizeMake(60, 20));
        }];
    }
    return self;
}

- (void)setBtnMode:(IntroBtnMode)btnMode{
    _btnMode = btnMode;
    self.moreControl.hidden = YES;
    self.changeControl.hidden = YES;
    switch (btnMode) {
        case IntroBtnModeChange: {
            self.changeControl.hidden = NO;
            break;
        }
        case IntroBtnModeMore: {
            self.moreControl.hidden = NO;
            break;
        }
    }
}

- (void)prepareForReuse{
    [super prepareForReuse];
    [self setBtnMode:_btnMode];
}

- (UIControl *)moreControl{
    if (!_moreControl) {
        _moreControl = [UIControl new];
        [_moreControl bk_addEventHandler:^(id sender) {
            if ([_delegate respondsToSelector:@selector(introSectionHeaderView:clickBtnAtIndexPath:)]) {
                [_delegate introSectionHeaderView:self clickBtnAtIndexPath:_indexPath];
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lb = [UILabel new];
        lb.text = @"更多";
        lb.font = [UIFont systemFontOfSize:13];
        [_moreControl addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(-3);
        }];
        
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"更多"]];
        [_moreControl addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(lb.mas_left).equalTo(-3);
        }];
    }
    return _moreControl;
}

- (UIControl *)changeControl{
    if (!_changeControl) {
        _changeControl = [UIControl new];
        [_changeControl bk_addEventHandler:^(id sender) {
            if ([_delegate respondsToSelector:@selector(introSectionHeaderView:clickBtnAtIndexPath:)]) {
                [_delegate introSectionHeaderView:self clickBtnAtIndexPath:_indexPath];
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lb = [UILabel new];
        lb.text = @"换一换";
        lb.font = [UIFont systemFontOfSize:13];
        [_changeControl addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(-3);
        }];
        
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"换一换"]];
        [_changeControl addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(lb.mas_left).equalTo(-3);
        }];
        
    }
    return _changeControl;
}


- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [UILabel new];
    }
    return _titleLb;
}
@end
