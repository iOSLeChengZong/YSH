//
//  SearchBarView.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/12.
//  Copyright © 2018 yuandian. All rights reserved.
//


/** searchBar 由背景图 和btn构成 */
#import "SearchBarView.h"

@interface SearchBarView ()
//@property(nonatomic,strong)UIButton *searchBtn;
//@property(nonatomic,strong)RounderView *backgroundView;

@end

@implementation SearchBarView

-(void)setUpChildView{
    RounderView *backgroundView = [[RounderView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [self addSubview: backgroundView];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, backgroundView.bounds.size.width, backgroundView.bounds.size.height)];
    imageV.image = [UIImage imageNamed:@""];
    [backgroundView addSubview:imageV];
    
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [searchBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [searchBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [searchBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [searchBtn setTitle:@"搜索元典" forState:UIControlStateNormal];
    //监听按钮点击
    WK(weakSelf)
    [searchBtn bk_addEventHandler:^(id sender) {
        [weakSelf searchBtnClick];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:searchBtn];
    
}

- (id)init{
    
    return [self initWithFrame:CGRectMake(10, 20, 300, 32)] ;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUpChildView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //设置心情默认值或者添加子视图
        [self setUpChildView];
    }
    return self;
}



-(void)searchBtnClick
{
    if ([self.delegate respondsToSelector:@selector(searchBarSearchBtnClicked:)]) {
        [self.delegate searchBarSearchBtnClicked:self];
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

@implementation RounderView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //当opaque属性被设为YES时，GPU就不会再利用图层颜色合成公式去合成真正的色值。因此，如果opaque被设置成YES，而对应UIView的alpha属性不为1.0的时候，就会有不可预料的情况发生：
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
