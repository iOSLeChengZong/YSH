//
//  UIBarButtonItem+ButtonToBarButtonItem.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/12.
//  Copyright © 2018 yuandian. All rights reserved.
//

#define kIOS11_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)

#import "UIBarButtonItem+ButtonToBarButtonItem.h"

@implementation UIBarButtonItem (ButtonToBarButtonItem)
+(instancetype)BarButtonItemWithTitle:(NSString *)title stytle:(UIBarButtonItemStyle)stytle target:(id)target action:(SEL)action{
    return [[self alloc] initWithTitle:title style:stytle target:target action:action];
}

+(instancetype)BarButtonItemWithBackgrounImageName:(NSString *)backgroundImageName highBackgroundImageName:(NSString *)hightBackgroundImageName target:(id)target aciton:(SEL)action{
    
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:hightBackgroundImageName] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    
    //监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

+(instancetype)BarButtonItemWithImageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName title:(NSString *)title target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//        [button setTitleColor:nil forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:11];//[UIFont fontWithName:@"" size:15];//
    }
    
    //设置按钮的尺寸为背景图尺寸 + 文字大小n尺寸
    button.width = [title sizeWithFont:button.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    button.height = button.currentImage.size.height+[title sizeWithFont:button.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].height;
    CGFloat with = button.frame.size.width;
    NSLog(@"btnFrame:%f",with);
    
    [button setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    //设置title在button上的位置(top left buttom right)
    button.titleEdgeInsets = UIEdgeInsetsMake(20, -42, 0, 0);
    
    //监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

+(NSArray<UIBarButtonItem *> *)LeftBarButtomItems:(BOOL)isLeft ImageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName title:(NSString *)title target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        //        [button setTitleColor:nil forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:11];//[UIFont fontWithName:@"" size:15];//
    }
    
    //设置按钮的尺寸为背景图尺寸 + 文字大小n尺寸
    button.width = [title sizeWithFont:button.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    button.height = button.currentImage.size.height+[title sizeWithFont:button.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].height;

    
    [button setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    //设置title在button上的位置(top left buttom right)
    button.titleEdgeInsets = UIEdgeInsetsMake(20, -42, 0, 0);
    
    //监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    //配置返回按钮距离屏幕边缘的距离
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width =  kIOS11_OR_LATER? 0 : -15;
    if (kIOS11_OR_LATER) {
        button.contentEdgeInsets =UIEdgeInsetsMake(0, 15,0, 0);
        button.imageEdgeInsets =UIEdgeInsetsMake(0, 15,0, 0);
        button.titleEdgeInsets = UIEdgeInsetsMake(20, -10, 0, 0);
        button.hitEdgeInsets =UIEdgeInsetsMake(0, -6, 0, 0);
    }
    if (isLeft) {
        return @[spaceItem,backItem];
    }else{
        return @[backItem,spaceItem];
    }
    
    
}





@end
