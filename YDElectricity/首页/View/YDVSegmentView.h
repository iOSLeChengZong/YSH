//
//  YDVSegmentView.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/7.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//#import "ZJSegmentStyle.h"
//#import "ZJScrollPageViewDelegate.h"
@class ZJSegmentStyle;
@class ZJTitleView;

typedef void(^TitleBtnOnClickBlock)(ZJTitleView *titleView, NSInteger index);
typedef void(^ExtraBtnOnClick)(UIButton *extraBtn);


@interface YDVSegmentView : UIView
// 所有的标题
@property (strong, nonatomic) NSArray *titles;
// 所有标题的设置
@property (strong, nonatomic) ZJSegmentStyle *segmentStyle;
@property (copy, nonatomic) ExtraBtnOnClick extraBtnOnClick;
//@property (weak, nonatomic) id<ZJScrollPageViewDelegate> delegate;
@property (strong, nonatomic) UIImage *backgroundImage;

- (instancetype)initWithFrame:(CGRect )frame segmentStyle:(ZJSegmentStyle *)segmentStyle /*delegate:(id<ZJScrollPageViewDelegate>)delegate*/ titles:(NSArray *)titles titleDidClick:(TitleBtnOnClickBlock)titleDidClick;


/** 切换下标的时候根据progress同步设置UI*/
- (void)adjustUIWithProgress:(CGFloat)progress oldIndex:(NSInteger)oldIndex currentIndex:(NSInteger)currentIndex;
/** 让选中的标题居中*/
- (void)adjustTitleOffSetToCurrentIndex:(NSInteger)currentIndex;
/** 设置选中的下标*/
- (void)setSelectedIndex:(NSInteger)index animated:(BOOL)animated;
/** 重新刷新标题的内容*/
- (void)reloadTitlesWithNewTitles:(NSArray *)titles;
@end

NS_ASSUME_NONNULL_END
