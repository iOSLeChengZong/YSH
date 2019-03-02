//
//  YDCustomCalloutView.m
//  YDElectricity
//
//  Created by 元典 on 2019/3/2.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "YDCustomCalloutView.h"
#define kPortraitWidth 80
#define kAngleViewWidth 60

@implementation YDCustomCalloutView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initSubView];
    }
    return self;
}

-(void)initSubView{

    //底三角形
    _angleView = [[UIView alloc] initWithFrame:CGRectMake(0, kPortraitWidth * 0.5, kAngleViewWidth, kAngleViewWidth)];
    [self addSubview:_angleView];
    
    //顶部圆形图
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kPortraitWidth, kPortraitWidth)];
    [_imageView viewcornerRadius:_angleView.bounds.size.width * 0.5 borderWith:0.5 clearColor:NO];
    [self addSubview:_imageView];

    
}


#pragma mark - draw view path
- (void)drawRect:(CGRect)rect {
    [self drawInContext:UIGraphicsGetCurrentContext()];
    self.angleView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.angleView.layer.shadowOpacity = 1.0;
    self.angleView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}


-(void)drawInContext:(CGContextRef) context{
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    [self getDrawPath:context];
    CGContextFillPath(context);
}

- (void)getDrawPath:(CGContextRef) context {
    CGRect rect = self.angleView.frame;
    CGFloat minX = CGRectGetMinX(rect);
    CGFloat minY = CGRectGetMinY(rect);
    CGFloat maxX = CGRectGetMaxX(rect);
    CGFloat midX = CGRectGetMidX(rect);
    CGFloat maxY = CGRectGetMaxY(rect);
    
    //绘制三角形
    CGContextMoveToPoint(context, maxX, minY);
    CGContextAddLineToPoint(context, midX,maxY);
    CGContextAddLineToPoint(context, minX, minY);
    
    
}


@end
