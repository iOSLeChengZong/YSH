//
//  YDIntroHeaderCell.m
//  YDElectricity
//
//  Created by 元典 on 2018/11/29.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "YDIntroHeaderCell.h"
#import "TestModel.h"


@implementation YDIntroHeaderCell

#pragma mark -- iCarouselDatasource
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    NSLog(@"cccccc:%ld",_colorArr.count);
    return self.colorArr.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view{
    if (carousel == _adIC) {
        if (!view) {
            view = [[UIView alloc] initWithFrame: carousel.bounds];
            view.backgroundColor = self.colorArr[index];
            NSLog(@"index:%ld",index);
        }
        return view;
    }
    return nil;
}

#pragma mark -- iCarouselDelegate
//通过协议允许循环滚动
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    if (option == iCarouselOptionWrap) {
        value = YES;
    }
    return value;
}
//当滚动翻页时
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    if (carousel == _adIC) {
        self.pageC.currentPage = carousel.currentItemIndex;
//        self.titleLb.text = [self.introVM indexTitleForIndex:carousel.currentItemIndex];
    }
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    if (carousel == _adIC) {
//        [Tool playVideoInURL:[self.introVM indexURLForIndex:index]];
        NSLog(@"adICClick!");
    }else{
//        [Tool playVideoInURL:[self.introVM starVideoURLForIndex:index]];
    }
}



#pragma mark -- 生命周期
- (void)awakeFromNib {
 
    NSLog(@"wwwwwwww:%ld",_colorArr.count);
    [super awakeFromNib];
    //设置代理
    _adIC.delegate = self;
    _adIC.dataSource = self;
    _adIC.scrollSpeed = 0.1f;
    [NSTimer bk_scheduledTimerWithTimeInterval:3.0 block:^(NSTimer *timer) {
        [_adIC scrollToItemAtIndex:_adIC.currentItemIndex +1 animated:YES];
    } repeats:YES];

}


#pragma mark -- 方法
-(void)setColorArr:(NSArray *)colorArr{
    NSLog(@"scscscsc:%ld",_colorArr.count);
    
    _colorArr = colorArr;
    _pageC.numberOfPages = self.colorArr.count;
    [_adIC reloadData];
}


@end
